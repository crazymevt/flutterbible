import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../app/app_state.dart';
import '../../app/shared_prefs.dart';
import 'tutorial_keys.dart';

/// Which real-UI element a tutorial step points at. [TutorialAnchor.none]
/// (or an anchor whose widget isn't currently laid out) renders as a centered
/// showcase card instead of an anchored spotlight.
enum TutorialAnchor { none, reader, toolsRail, search, menu }

class _Step {
  final IconData icon;
  final String title;
  final String description;
  final int accent; // ARGB; tinted for the medallion + spotlight ring.
  final TutorialAnchor anchor;
  final bool searchSyntax; // append the rendered query-syntax chips

  const _Step({
    required this.icon,
    required this.title,
    required this.description,
    required this.accent,
    this.anchor = TutorialAnchor.none,
    this.searchSyntax = false,
  });
}

// Mid-tone accents chosen to read against both the light and dark scrim/card.
const _kSteps = <_Step>[
  _Step(
    icon: Icons.auto_stories_rounded,
    title: 'Welcome to StudyBible',
    description:
        'A quick tour of the essentials. It takes about a minute — you can skip it any time and replay it later from Settings.',
    accent: 0xFF3F6FB5,
  ),
  _Step(
    icon: Icons.menu_book_rounded,
    title: 'The Reader',
    description:
        'Read versions side-by-side or interleaved. Tap a verse for actions like notes, compare, and cross-references — and long-press (or right-click) any word for dictionary definitions.',
    accent: 0xFF2E7D6B,
    anchor: TutorialAnchor.reader,
  ),
  _Step(
    icon: Icons.view_sidebar_rounded,
    title: 'Study Tools',
    description:
        'Cross-references, notes, commentaries, dictionaries, sermons, reading plans, devotionals, topics, and places — every study tool lives a tap away here.',
    accent: 0xFF6A4FB3,
    anchor: TutorialAnchor.toolsRail,
  ),
  _Step(
    icon: Icons.search_rounded,
    title: 'Powerful Search',
    description:
        'From the bar up top, jump straight to a passage by typing a reference, or search every Bible and journal in milliseconds:',
    accent: 0xFFB5632A,
    anchor: TutorialAnchor.search,
    searchSyntax: true,
  ),
  _Step(
    icon: Icons.edit_note_rounded,
    title: 'Journals & Prayers',
    description:
        'Open the menu to track your walk with God: rich-text journal entries with clickable verse references, plus a running list of active and answered prayers.',
    accent: 0xFF8A2F5E,
    anchor: TutorialAnchor.menu,
  ),
  _Step(
    icon: Icons.cloud_download_rounded,
    title: 'Content & Sync',
    description:
        'Also in the menu: the Content Manager to download hundreds of free Bibles, commentaries, dictionaries, and devotionals, plus Backup & Restore to keep your data safe across devices.',
    accent: 0xFF2F6FB3,
    anchor: TutorialAnchor.menu,
  ),
];

/// Full-screen guided tour drawn over the live app shell. Steps either spotlight
/// a real UI element (via [tutorialKeys]) with a dimmed cutout + pulse ring, or
/// fall back to a centered showcase card. Marks the tutorial seen on finish or
/// skip, which removes the overlay (see `main_shell.dart`).
class TutorialOverlay extends ConsumerStatefulWidget {
  const TutorialOverlay({super.key});

  @override
  ConsumerState<TutorialOverlay> createState() => _TutorialOverlayState();
}

class _TutorialOverlayState extends ConsumerState<TutorialOverlay>
    with TickerProviderStateMixin {
  int _index = 0;
  Rect? _targetRect; // where the spotlight is heading (also drives card placement)
  Rect? _prevRect; // where it came from, for the glide between two targets
  late final AnimationController _pulse;
  late final AnimationController _move;

  @override
  void initState() {
    super.initState();
    _pulse = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1600),
    )..repeat();
    _move = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 360),
      value: 1,
    );
  }

  @override
  void dispose() {
    _pulse.dispose();
    _move.dispose();
    super.dispose();
  }

  /// The hole to paint right now: glides from [_prevRect] to [_targetRect] only
  /// when both are real targets; appearing/disappearing cutouts snap (lerping
  /// from a null rect grows awkwardly out of the top-left corner).
  Rect? get _currentHole {
    if (_prevRect == null || _targetRect == null) return _targetRect;
    return Rect.lerp(_prevRect, _targetRect, _move.value);
  }

  /// Points the spotlight at [rect], gliding from the current hole if both ends
  /// are real targets, otherwise snapping.
  void _setTarget(Rect? rect) {
    if (rect == _targetRect) return;
    _prevRect = _currentHole;
    _targetRect = rect;
    if (_prevRect != null && _targetRect != null) {
      _move.forward(from: 0);
    } else {
      _move.value = 1;
    }
  }

  GlobalKey? _keyFor(TutorialAnchor anchor) {
    switch (anchor) {
      case TutorialAnchor.reader:
        return tutorialReaderKey;
      case TutorialAnchor.toolsRail:
        return tutorialToolsRailKey;
      case TutorialAnchor.search:
        return tutorialSearchKey;
      case TutorialAnchor.menu:
        return tutorialMenuKey;
      case TutorialAnchor.none:
        return null;
    }
  }

  /// Reads the current step's target rect in global coordinates, or null if the
  /// step has no anchor or its widget isn't laid out on this layout.
  Rect? _resolveRect() {
    final key = _keyFor(_kSteps[_index].anchor);
    final ctx = key?.currentContext;
    if (ctx == null) return null;
    final box = ctx.findRenderObject() as RenderBox?;
    if (box == null || !box.attached || !box.hasSize) return null;
    return box.localToGlobal(Offset.zero) & box.size;
  }

  void _syncRect() {
    final rect = _resolveRect();
    if (rect != _targetRect && mounted) setState(() => _setTarget(rect));
  }

  void _finish() {
    // While the tour is up, the reader is forced behind the overlay
    // (main_shell) without changing the module. Land the user there for real
    // now that it's done; by now the verse providers have settled, so the
    // switch is safe.
    if (ref.read(appModuleProvider) != AppModule.reader) {
      ref.read(appModuleProvider.notifier).setModule(AppModule.reader);
    }
    ref.read(hasSeenTutorialProvider.notifier).setSeen(true);
  }

  void _next() {
    if (_index >= _kSteps.length - 1) {
      _finish();
      return;
    }
    setState(() {
      _index++;
      _setTarget(_resolveRect()); // synchronous — shell is already laid out
    });
  }

  void _back() {
    if (_index == 0) return;
    setState(() {
      _index--;
      _setTarget(_resolveRect());
    });
  }

  @override
  Widget build(BuildContext context) {
    // Targets can move (resize, async content load); re-measure each frame.
    WidgetsBinding.instance.addPostFrameCallback((_) => _syncRect());

    final theme = Theme.of(context);
    final step = _kSteps[_index];
    final accent = Color(step.accent);
    final rect = _targetRect;
    final isLast = _index == _kSteps.length - 1;

    final scrim = theme.colorScheme.scrim.withValues(alpha: 0.72);

    return Material(
      type: MaterialType.transparency,
      child: Stack(
        children: [
          // Dimmed scrim (+ optional spotlight cutout). Absorbs taps so the
          // shell behind stays inert during the tour.
          Positioned.fill(
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {},
              child: AnimatedBuilder(
                animation: Listenable.merge([_pulse, _move]),
                builder: (context, _) => CustomPaint(
                  painter: _SpotlightPainter(
                    hole: _currentHole,
                    scrimColor: scrim,
                    ringColor: accent,
                    pulse: _pulse.value,
                  ),
                ),
              ),
            ),
          ),
          // The step card, animated in and positioned clear of the spotlight.
          _CardLayout(
            targetRect: rect,
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 280),
              switchInCurve: Curves.easeOutCubic,
              transitionBuilder: (child, animation) => FadeTransition(
                opacity: animation,
                child: SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(0, 0.06),
                    end: Offset.zero,
                  ).animate(animation),
                  child: child,
                ),
              ),
              child: _StepCard(
                key: ValueKey(_index),
                step: step,
                accent: accent,
                index: _index,
                count: _kSteps.length,
                isLast: isLast,
                onSkip: _finish,
                onBack: _index > 0 ? _back : null,
                onNext: _next,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Positions the card in the screen's open space — to the side away from the
/// spotlight, or centered when there's no target — and *glides* there when the
/// step changes so the motion reads as intentional rather than a jump.
class _CardLayout extends StatelessWidget {
  final Rect? targetRect;
  final Widget child;

  const _CardLayout({required this.targetRect, required this.child});

  Alignment _alignmentFor(Rect target, Size size) {
    final cx = target.center.dx;
    // Spotlight hugs the left → card sits right, and vice versa. A roughly
    // centered/full-width target leaves the sides cramped, so drop to the
    // bottom instead.
    if (cx < size.width * 0.42) return Alignment.centerRight;
    if (cx > size.width * 0.58) return Alignment.centerLeft;
    return Alignment.bottomCenter;
  }

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    final safe = media.padding;
    final alignment = targetRect == null
        ? Alignment.center
        : _alignmentFor(targetRect!, media.size);

    return AnimatedAlign(
      duration: const Duration(milliseconds: 360),
      curve: Curves.easeInOutCubic,
      alignment: alignment,
      child: Padding(
        padding: EdgeInsets.fromLTRB(
          24 + safe.left,
          24 + safe.top,
          24 + safe.right,
          24 + safe.bottom,
        ),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 460),
          child: child,
        ),
      ),
    );
  }
}

class _StepCard extends StatelessWidget {
  final _Step step;
  final Color accent;
  final int index;
  final int count;
  final bool isLast;
  final VoidCallback onSkip;
  final VoidCallback? onBack;
  final VoidCallback onNext;

  const _StepCard({
    super.key,
    required this.step,
    required this.accent,
    required this.index,
    required this.count,
    required this.isLast,
    required this.onSkip,
    required this.onBack,
    required this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final dark = theme.brightness == Brightness.dark;
    final medallionBg = accent.withValues(alpha: dark ? 0.24 : 0.14);

    return Card(
      elevation: 8,
      color: theme.colorScheme.surfaceContainerHigh,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
        side: BorderSide(color: accent.withValues(alpha: 0.35)),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(28, 16, 28, 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: onSkip,
                child: const Text('Skip'),
              ),
            ),
            Container(
              width: 84,
              height: 84,
              decoration: BoxDecoration(
                color: medallionBg,
                shape: BoxShape.circle,
              ),
              child: Icon(step.icon, size: 42, color: accent),
            ),
            const SizedBox(height: 20),
            Text(
              step.title,
              textAlign: TextAlign.center,
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              step.description,
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyLarge?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
                height: 1.45,
              ),
            ),
            if (step.searchSyntax) ...[
              const SizedBox(height: 16),
              _SearchSyntax(accent: accent),
            ],
            const SizedBox(height: 24),
            _ProgressDots(index: index, count: count, accent: accent),
            const SizedBox(height: 16),
            Row(
              children: [
                TextButton.icon(
                  onPressed: onBack,
                  icon: const Icon(Icons.arrow_back_rounded, size: 18),
                  label: const Text('Back'),
                ),
                const Spacer(),
                FilledButton.icon(
                  onPressed: onNext,
                  style: FilledButton.styleFrom(backgroundColor: accent),
                  icon: Icon(
                    isLast ? Icons.check_rounded : Icons.arrow_forward_rounded,
                    size: 18,
                  ),
                  label: Text(isLast ? 'Get Started' : 'Next'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/// Renders the search operators as styled "code" chips — what the old plain
/// [Text] showed as literal backticks.
class _SearchSyntax extends StatelessWidget {
  final Color accent;
  const _SearchSyntax({required this.accent});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    Widget row(String code, String meaning) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _Code(code, accent: accent),
              const SizedBox(width: 10),
              Flexible(
                child: Text(
                  meaning,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ),
            ],
          ),
        );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        row('John 3:16', 'jump straight to a passage'),
        row('john: angel', 'search within a single book'),
        row('ot:', 'limit to the Old Testament'),
        row('nt:', 'limit to the New Testament'),
        row('faith ~10 works', 'words within 10 of each other'),
      ],
    );
  }
}

class _Code extends StatelessWidget {
  final String text;
  final Color accent;
  const _Code(this.text, {required this.accent});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: accent.withValues(
            alpha: theme.brightness == Brightness.dark ? 0.22 : 0.12),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: accent.withValues(alpha: 0.35)),
      ),
      child: Text(
        text,
        style: theme.textTheme.bodyMedium?.copyWith(
          fontFamily: 'monospace',
          fontWeight: FontWeight.w600,
          color: theme.colorScheme.onSurface,
        ),
      ),
    );
  }
}

class _ProgressDots extends StatelessWidget {
  final int index;
  final int count;
  final Color accent;
  const _ProgressDots(
      {required this.index, required this.count, required this.accent});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(count, (i) {
        final active = i == index;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 280),
          curve: Curves.easeOut,
          margin: const EdgeInsets.symmetric(horizontal: 3),
          width: active ? 22 : 8,
          height: 8,
          decoration: BoxDecoration(
            color: active ? accent : theme.colorScheme.outlineVariant,
            borderRadius: BorderRadius.circular(4),
          ),
        );
      }),
    );
  }
}

class _SpotlightPainter extends CustomPainter {
  final Rect? hole;
  final Color scrimColor;
  final Color ringColor;
  final double pulse; // 0..1, drives the expanding ring

  _SpotlightPainter({
    required this.hole,
    required this.scrimColor,
    required this.ringColor,
    required this.pulse,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final full = Offset.zero & size;
    final scrimPaint = Paint()..color = scrimColor;

    if (hole == null) {
      canvas.drawRect(full, scrimPaint);
      return;
    }

    // Clamp the cutout to the canvas and round its corners.
    final h = hole!.intersect(full).inflate(6);
    final rrect = RRect.fromRectAndRadius(h, const Radius.circular(16));
    final path = Path()
      ..fillType = PathFillType.evenOdd
      ..addRect(full)
      ..addRRect(rrect);
    canvas.drawPath(path, scrimPaint);

    // Expanding, fading pulse ring to draw the eye.
    final grow = 6 + pulse * 12;
    final ringPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.5
      ..color = ringColor.withValues(alpha: (1 - pulse) * 0.9);
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        h.inflate(grow),
        Radius.circular(16 + grow),
      ),
      ringPaint,
    );
  }

  @override
  bool shouldRepaint(_SpotlightPainter old) =>
      old.hole != hole ||
      old.pulse != pulse ||
      old.scrimColor != scrimColor ||
      old.ringColor != ringColor;
}
