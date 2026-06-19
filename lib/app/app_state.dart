import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'shared_prefs.dart';

enum ActiveTool {
  none,
  crossReference,
  notes,
  search,
  dictionary,
  library,
  commentaries,
  history,
  media,
  readingPlans,
}

class ActiveToolNotifier extends Notifier<ActiveTool> {
  @override
  ActiveTool build() => ActiveTool.none;

  void setTool(ActiveTool tool) {
    if (state == tool) {
      state = ActiveTool.none;
    } else {
      state = tool;
    }
  }
  
  void close() {
    state = ActiveTool.none;
  }
}

final activeToolProvider = NotifierProvider<ActiveToolNotifier, ActiveTool>(() => ActiveToolNotifier());

enum AppModule {
  reader,
  journalsPrayers,
  dashboard,
  contentManager,
  backupRestore,
  readingPlans,
}

class ShowDashboardOnStartNotifier extends Notifier<bool> {
  @override
  bool build() {
    final prefs = ref.watch(sharedPreferencesProvider);
    return prefs.getBool('showDashboardOnStart') ?? false;
  }

  void set(bool value) {
    state = value;
    ref.read(sharedPreferencesProvider).setBool('showDashboardOnStart', value);
  }
}

final showDashboardOnStartProvider = NotifierProvider<ShowDashboardOnStartNotifier, bool>(() => ShowDashboardOnStartNotifier());

class AppModuleNotifier extends Notifier<AppModule> {
  AppModule build() {
    final showDashboard = ref.watch(showDashboardOnStartProvider);
    return showDashboard ? AppModule.dashboard : AppModule.reader;
  }

  void setModule(AppModule module) {
    state = module;
  }
}

final appModuleProvider = NotifierProvider<AppModuleNotifier, AppModule>(() => AppModuleNotifier());
