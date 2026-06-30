import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import 'package:drift/drift.dart';
import '../data/user_store.dart';
import 'user_providers.dart';
import 'sync_service.dart';

/// How far ahead of an action's due time the app starts alerting. The alert
/// then persists (through the due time and while overdue) until the action is
/// completed or the user dismisses it.
const int kActionLeadMs = 24 * 60 * 60 * 1000; // 24 hours

/// Live, newest-first list of action items.
final actionItemsProvider = StreamProvider<List<ActionItem>>((ref) {
  final store = ref.watch(userStoreProvider);
  return (store.select(store.actionItems)
        ..where((a) => a.deleted.equals(false))
        ..orderBy([
          (a) => OrderingTerm(expression: a.createdAt, mode: OrderingMode.desc),
        ]))
      .watch();
});

/// Pure helper: the not-completed action items whose due time is within the
/// lead window or already past, given [nowMs]. Used both by the UI list (to
/// flag rows) and the app-wide due banner.
List<ActionItem> actionsNeedingAlert(List<ActionItem> items, int nowMs) {
  return items
      .where((a) =>
          !a.deleted &&
          a.completedAt == null &&
          a.dueAt != null &&
          nowMs >= a.dueAt! - kActionLeadMs)
      .toList();
}

final actionItemActionProvider = Provider((ref) => ActionItemAction(ref));

class ActionItemAction {
  final Ref ref;
  ActionItemAction(this.ref);

  /// Creates a new action item, or updates the one with [id]. Returns its id.
  Future<String> saveActionItem({
    String? id,
    required String title,
    String description = '',
    int? dueAt,
  }) async {
    final store = ref.read(userStoreProvider);
    final deviceId = await ref.read(deviceIdProvider.future);
    final now = DateTime.now().millisecondsSinceEpoch;

    final actionId = id ?? const Uuid().v4();
    final existing = id != null
        ? await (store.select(store.actionItems)..where((a) => a.id.equals(id)))
            .getSingleOrNull()
        : null;

    if (existing != null) {
      await store.into(store.actionItems).insert(
            existing.copyWith(
              title: title,
              description: description,
              dueAt: Value(dueAt),
              updatedAt: now,
            ),
            mode: InsertMode.replace,
          );
    } else {
      await store.into(store.actionItems).insert(
            ActionItem(
              id: actionId,
              updatedAt: now,
              deviceId: deviceId,
              deleted: false,
              title: title,
              description: description,
              createdAt: now,
              dueAt: dueAt,
              completedAt: null,
            ),
          );
    }
    return actionId;
  }

  Future<void> toggleCompleted(String id, bool completed) async {
    final store = ref.read(userStoreProvider);
    final now = DateTime.now().millisecondsSinceEpoch;
    final existing =
        await (store.select(store.actionItems)..where((a) => a.id.equals(id)))
            .getSingleOrNull();
    if (existing != null) {
      await store.into(store.actionItems).insert(
            existing.copyWith(
              completedAt: Value(completed ? now : null),
              updatedAt: now,
            ),
            mode: InsertMode.replace,
          );
    }
  }

  Future<void> deleteActionItem(String id) async {
    final store = ref.read(userStoreProvider);
    final existing =
        await (store.select(store.actionItems)..where((a) => a.id.equals(id)))
            .getSingleOrNull();
    if (existing != null) {
      await store.into(store.actionItems).insert(
            existing.copyWith(
              deleted: true,
              updatedAt: DateTime.now().millisecondsSinceEpoch,
            ),
            mode: InsertMode.replace,
          );
    }
  }
}
