import 'package:flutter/widgets.dart';

/// Centralized responsive breakpoints.
///
/// The reader switches from a single-column mobile layout to the two-pane
/// desktop layout (reader + tool panel + navigation rail) at [compact].
/// Keep all width-based layout decisions referencing these constants rather
/// than sprinkling magic numbers through the widget tree.
class Breakpoints {
  Breakpoints._();

  /// Below this width we use the compact (mobile) layout; at or above it we
  /// use the wide (desktop/tablet) layout.
  static const double compact = 900.0;
}

extension ResponsiveContext on BuildContext {
  /// True when the current window is wide enough for the desktop layout
  /// (tool panels docked beside the reader + persistent navigation rail).
  bool get isWideLayout =>
      MediaQuery.sizeOf(this).width > Breakpoints.compact;
}
