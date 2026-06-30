import 'package:flutter/material.dart';

/// A single shimmering placeholder block. Drive it from a shared
/// [AnimationController] (see [SkeletonList]) so every block on a surface pulses
/// in unison rather than each running its own ticker.
class SkeletonBox extends StatelessWidget {
  final double? width;
  final double height;
  final BorderRadius borderRadius;
  final Animation<double> animation;

  const SkeletonBox({
    super.key,
    required this.animation,
    this.width,
    this.height = 14,
    this.borderRadius = const BorderRadius.all(Radius.circular(6)),
  });

  @override
  Widget build(BuildContext context) {
    final base = Theme.of(context).colorScheme.onSurfaceVariant;
    return AnimatedBuilder(
      animation: animation,
      builder: (context, _) => Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: base.withValues(alpha: animation.value),
          borderRadius: borderRadius,
        ),
      ),
    );
  }
}

/// A list-shaped loading placeholder for the reader tool panels. Renders a few
/// faux rows (title + body lines) that gently pulse, matching the shape of the
/// content that's about to arrive so the swap reads as "almost there" rather
/// than a spinner flash.
class SkeletonList extends StatefulWidget {
  /// Number of faux rows to render.
  final int rows;

  /// Outer padding; defaults to the panels' standard list padding.
  final EdgeInsetsGeometry padding;

  const SkeletonList({
    super.key,
    this.rows = 6,
    this.padding = const EdgeInsets.all(16),
  });

  @override
  State<SkeletonList> createState() => _SkeletonListState();
}

class _SkeletonListState extends State<SkeletonList>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1100),
  )..repeat(reverse: true);

  late final Animation<double> _pulse = Tween<double>(
    begin: 0.08,
    end: 0.22,
  ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // A non-scrollable scroll view so a tall row count never overflows a short
    // pane — the faux rows simply clip to whatever height is available, the
    // same way a real list's first screenful would.
    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      padding: widget.padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (var i = 0; i < widget.rows; i++) ...[
            if (i > 0) const SizedBox(height: 24),
            SkeletonBox(animation: _pulse, width: 140, height: 16),
            const SizedBox(height: 10),
            SkeletonBox(animation: _pulse, height: 12),
            const SizedBox(height: 6),
            SkeletonBox(animation: _pulse, width: 220, height: 12),
          ],
        ],
      ),
    );
  }
}
