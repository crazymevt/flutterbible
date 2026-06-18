import 'package:flutter_riverpod/flutter_riverpod.dart';

enum ActiveTool {
  none,
  crossReference,
  notes,
  search,
  library,
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
