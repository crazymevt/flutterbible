import 'dart:convert';
import 'dart:io';

import 'package:drift/native.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:study_bible/app/achievement_service.dart';
import 'package:study_bible/app/action_providers.dart';
import 'package:study_bible/app/shared_prefs.dart';
import 'package:study_bible/app/sync_service.dart';
import 'package:study_bible/app/user_providers.dart';
import 'package:study_bible/data/user_store.dart';

class _NoopAchievementService extends AchievementService {
  _NoopAchievementService(super.ref);
  @override
  Future<void> evaluateAchievements() async {}
}

ActionItem _item({
  required String id,
  int? dueAt,
  int? completedAt,
  bool deleted = false,
}) =>
    ActionItem(
      id: id,
      updatedAt: 1,
      deviceId: 'A',
      deleted: deleted,
      title: 'Do $id',
      description: '',
      createdAt: 1,
      dueAt: dueAt,
      completedAt: completedAt,
    );

void main() {
  group('actionsNeedingAlert', () {
    const now = 1000000000000;
    const day = 24 * 60 * 60 * 1000;

    test('ignores items without a due date', () {
      expect(actionsNeedingAlert([_item(id: 'a', dueAt: null)], now), isEmpty);
    });

    test('ignores items due beyond the lead window', () {
      // Due in 2 days — lead window is 24h, so not yet alerting.
      expect(
        actionsNeedingAlert([_item(id: 'a', dueAt: now + 2 * day)], now),
        isEmpty,
      );
    });

    test('alerts within the lead window', () {
      expect(
        actionsNeedingAlert([_item(id: 'a', dueAt: now + day ~/ 2)], now)
            .map((a) => a.id),
        ['a'],
      );
    });

    test('alerts when overdue', () {
      expect(
        actionsNeedingAlert([_item(id: 'a', dueAt: now - day)], now)
            .map((a) => a.id),
        ['a'],
      );
    });

    test('ignores completed and deleted items even when overdue', () {
      final items = [
        _item(id: 'done', dueAt: now - day, completedAt: now - 1),
        _item(id: 'gone', dueAt: now - day, deleted: true),
      ];
      expect(actionsNeedingAlert(items, now), isEmpty);
    });
  });

  group('ActionItemAction', () {
    late UserStore store;
    late ProviderContainer container;

    setUp(() {
      store = UserStore(NativeDatabase.memory());
      container = ProviderContainer(overrides: [
        userStoreProvider.overrideWithValue(store),
        deviceIdProvider.overrideWith((ref) async => 'A'),
      ]);
    });

    tearDown(() async {
      container.dispose();
      await store.close();
    });

    Future<List<ActionItem>> live() => (store.select(store.actionItems)
          ..where((a) => a.deleted.equals(false)))
        .get();

    test('saveActionItem creates, then updates', () async {
      final id = await container.read(actionItemActionProvider).saveActionItem(
            title: 'Call client',
            description: 'about the proposal',
            dueAt: 123456,
          );
      var rows = await live();
      expect(rows, hasLength(1));
      expect(rows.single.title, 'Call client');
      expect(rows.single.dueAt, 123456);
      expect(rows.single.completedAt, isNull);

      await container.read(actionItemActionProvider).saveActionItem(
            id: id,
            title: 'Call client back',
            dueAt: null, // clears the due date
          );
      rows = await live();
      expect(rows, hasLength(1));
      expect(rows.single.title, 'Call client back');
      expect(rows.single.dueAt, isNull);
    });

    test('toggleCompleted sets and clears the completion timestamp', () async {
      final id = await container
          .read(actionItemActionProvider)
          .saveActionItem(title: 'Task');

      await container.read(actionItemActionProvider).toggleCompleted(id, true);
      expect((await live()).single.completedAt, isNotNull);

      await container.read(actionItemActionProvider).toggleCompleted(id, false);
      expect((await live()).single.completedAt, isNull);
    });

    test('deleteActionItem soft-deletes', () async {
      final id = await container
          .read(actionItemActionProvider)
          .saveActionItem(title: 'Task');
      await container.read(actionItemActionProvider).deleteActionItem(id);
      expect(await live(), isEmpty);
    });
  });

  group('Sync', () {
    test('pulls a remote action item into the local store', () async {
      final tmpDir = await Directory.systemTemp.createTemp('action_sync');
      addTearDown(() => tmpDir.delete(recursive: true));

      final store = UserStore(NativeDatabase.memory());
      addTearDown(store.close);

      final remoteLine = jsonEncode({
        'id': 'act1',
        'updatedAt': 200,
        'deviceId': 'B',
        'deleted': false,
        'type': 'actionItem',
        'title': 'Remote task',
        'description': 'from device B',
        'createdAt': 100,
        'dueAt': 5000,
        'completedAt': null,
      });
      await File('${tmpDir.path}/state-B.jsonl').writeAsString('$remoteLine\n');

      SharedPreferences.setMockInitialValues({
        'syncFolderPath': tmpDir.path,
        'googleDriveEnabled': false,
      });
      final prefs = await SharedPreferences.getInstance();

      final container = ProviderContainer(overrides: [
        userStoreProvider.overrideWithValue(store),
        sharedPreferencesProvider.overrideWithValue(prefs),
        deviceIdProvider.overrideWith((ref) async => 'A'),
        achievementServiceProvider
            .overrideWith((ref) => _NoopAchievementService(ref)),
      ]);
      addTearDown(container.dispose);

      await container.read(syncServiceProvider).sync();

      final row = await (store.select(store.actionItems)
            ..where((a) => a.id.equals('act1')))
          .getSingle();
      expect(row.title, 'Remote task');
      expect(row.dueAt, 5000);
      expect(row.description, 'from device B');
    });
  });
}
