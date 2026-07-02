import 'package:flutter/gestures.dart' show PointerDeviceKind;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/content_providers.dart';
import '../../app/people_providers.dart';
import '../../app/reader_state.dart';
import '../common/skeleton.dart';
import 'people_panel.dart' show formatIsoYear, showPersonDetailSheet;

/// A fullscreen, pannable/zoomable timeline of the people of the Bible: each
/// person is a horizontal lifespan bar (sorted oldest-first), with major dated
/// events marked along a shared time axis. Tap a bar to open the person, tap an
/// event marker to read its account.
class PeopleTimelineScreen extends ConsumerStatefulWidget {
  const PeopleTimelineScreen({super.key});

  @override
  ConsumerState<PeopleTimelineScreen> createState() =>
      _PeopleTimelineScreenState();
}

class _PeopleTimelineScreenState extends ConsumerState<PeopleTimelineScreen> {
  // Layout metrics.
  static const double _rowHeight = 34;
  static const double _gutterWidth = 140;
  static const double _rulerHeight = 48;
  static const double _edgePad = 48;
  static const double _minPx = 0.08;
  static const double _maxPx = 12;

  // Horizontal (time) and vertical (people) scroll are each shared by two
  // viewports — the ruler + body, and the name gutter + body — kept in lockstep
  // so the axes stay pinned.
  final _hHead = ScrollController();
  final _hBody = ScrollController();
  final _vNames = ScrollController();
  final _vBody = ScrollController();
  final List<VoidCallback> _unlink = [];

  /// Pixels per year. Null until the first layout picks a fit-to-width default.
  double? _px;
  bool _didInitScale = false;
  int? _selectedEventId;

  /// Whether the Events list is showing instead of the chart.
  bool _showEvents = false;
  final _eventSearch = TextEditingController();
  String _eventQuery = '';

  @override
  void initState() {
    super.initState();
    _mirror(_hHead, _hBody);
    _mirror(_hBody, _hHead);
    _mirror(_vNames, _vBody);
    _mirror(_vBody, _vNames);
  }

  /// Keeps [follower] at [leader]'s offset. A per-direction guard plus a small
  /// deadband stops the paired mirrors from ping-ponging.
  void _mirror(ScrollController leader, ScrollController follower) {
    var busy = false;
    void listener() {
      if (busy || !leader.hasClients || !follower.hasClients) return;
      final target = leader.offset.clamp(
        follower.position.minScrollExtent,
        follower.position.maxScrollExtent,
      );
      if ((follower.offset - target).abs() < 0.5) return;
      busy = true;
      follower.jumpTo(target);
      busy = false;
    }

    leader.addListener(listener);
    _unlink.add(() => leader.removeListener(listener));
  }

  @override
  void dispose() {
    for (final off in _unlink) {
      off();
    }
    _hHead.dispose();
    _hBody.dispose();
    _vNames.dispose();
    _vBody.dispose();
    _eventSearch.dispose();
    super.dispose();
  }

  int _span(TimelineData d) => (d.maxYear - d.minYear).clamp(1, 1 << 30);

  double _contentWidth(TimelineData d) => _edgePad * 2 + _span(d) * _px!;

  void _ensureInitialScale(double viewportWidth, TimelineData d) {
    if (_didInitScale || viewportWidth <= 0) return;
    // Default to fitting the whole sweep of history on screen; the user zooms
    // into an era from there.
    final fit = (viewportWidth - _edgePad * 2) / _span(d);
    _px = fit.clamp(_minPx, _maxPx);
    _didInitScale = true;
  }

  /// Zooms about the horizontal centre of the viewport so the era in view
  /// stays put.
  void _zoomBy(double factor) {
    final d = ref.read(timelineDataProvider).asData?.value;
    if (d == null || _px == null || !_hBody.hasClients) return;
    final vp = _hBody.position.viewportDimension;
    final centreYear = d.minYear + (_hBody.offset + vp / 2 - _edgePad) / _px!;
    setState(() => _px = (_px! * factor).clamp(_minPx, _maxPx));
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_hBody.hasClients) return;
      final target = _edgePad + (centreYear - d.minYear) * _px! - vp / 2;
      _hBody.jumpTo(
        target.clamp(
          _hBody.position.minScrollExtent,
          _hBody.position.maxScrollExtent,
        ),
      );
    });
  }

  void _fit() {
    final d = ref.read(timelineDataProvider).asData?.value;
    if (d == null || !_hBody.hasClients) return;
    final vp = _hBody.position.viewportDimension;
    setState(
      () => _px = ((vp - _edgePad * 2) / _span(d)).clamp(_minPx, _maxPx),
    );
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_hBody.hasClients) _hBody.jumpTo(0);
    });
  }

  void _goToVerse(String book, int chapter, int verse) {
    ref.read(selectedBookNameProvider.notifier).set(book);
    ref.read(selectedChapterProvider.notifier).set(chapter);
    ref.read(targetVerseToScrollProvider.notifier).set(verse);
    ref.read(selectedVersesProvider.notifier).clear();
    ref.read(selectedVersesProvider.notifier).toggle(verse);
    ref.read(navigationControllerProvider).recordHistory(verse: verse);
    // Close the event sheet and the timeline, back to the reader.
    Navigator.of(context).popUntil((r) => r.isFirst);
  }

  void _onRulerTapDown(double dx, TimelineData d) {
    TimelineEventPoint? best;
    var bestDist = 16.0;
    for (final e in d.events) {
      final ex = _edgePad + (e.year - d.minYear) * _px!;
      final dist = (ex - dx).abs();
      if (dist < bestDist) {
        bestDist = dist;
        best = e;
      }
    }
    if (best == null) return;
    setState(() => _selectedEventId = best!.id);
    _showEventSheet(best);
  }

  void _showEventSheet(TimelineEventPoint e) {
    final theme = Theme.of(context);
    showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      builder: (sheetContext) => SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                e.title,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                formatIsoYear(e.year),
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 16),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  if (e.bookName != null)
                    FilledButton.tonalIcon(
                      icon: const Icon(Icons.menu_book),
                      label: Text('Read ${e.bookName} ${e.chapter}:${e.verse}'),
                      onPressed: () {
                        Navigator.of(sheetContext).pop();
                        _goToVerse(e.bookName!, e.chapter!, e.verse!);
                      },
                    ),
                  OutlinedButton.icon(
                    icon: const Icon(Icons.timeline),
                    label: const Text('Show on timeline'),
                    onPressed: () {
                      Navigator.of(sheetContext).pop();
                      _showOnTimeline(e);
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Switches to the chart, selects [e], and scrolls its year into the centre.
  void _showOnTimeline(TimelineEventPoint e) {
    setState(() {
      _showEvents = false;
      _selectedEventId = e.id;
    });
    WidgetsBinding.instance.addPostFrameCallback((_) => _centerOnYear(e.year));
  }

  /// Centres the chart horizontally on [year]. Retries for a few frames while
  /// the chart's scroll view attaches after a view switch.
  void _centerOnYear(int year, [int tries = 0]) {
    final d = ref.read(timelineDataProvider).asData?.value;
    if (d == null || _px == null) return;
    if (!_hBody.hasClients) {
      if (tries < 5) {
        WidgetsBinding.instance.addPostFrameCallback(
          (_) => _centerOnYear(year, tries + 1),
        );
      }
      return;
    }
    final vp = _hBody.position.viewportDimension;
    final target = _edgePad + (year - d.minYear) * _px! - vp / 2;
    _hBody.jumpTo(
      target.clamp(
        _hBody.position.minScrollExtent,
        _hBody.position.maxScrollExtent,
      ),
    );
  }

  void _showHelp() {
    showDialog<void>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Bible Timeline'),
        content: const Text(
          'Each bar is a person’s lifespan, oldest at the top. Diamonds on the '
          'time axis mark major events.\n\n'
          '• Drag to pan across time and through people.\n'
          '• Use the zoom buttons to focus on an era or fit the whole span.\n'
          '• Tap a bar to open that person; tap an event marker to read its '
          'account.\n\n'
          'Dates follow the traditional chronology in the Theographic dataset '
          'and are approximate.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: const Text('Got it'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final dataAsync = ref.watch(timelineDataProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bible Timeline'),
        actions: [
          if (!_showEvents) ...[
            IconButton(
              icon: const Icon(Icons.zoom_out),
              tooltip: 'Zoom out',
              onPressed: () => _zoomBy(1 / 1.6),
            ),
            IconButton(
              icon: const Icon(Icons.zoom_in),
              tooltip: 'Zoom in',
              onPressed: () => _zoomBy(1.6),
            ),
            IconButton(
              icon: const Icon(Icons.fit_screen),
              tooltip: 'Fit all',
              onPressed: _fit,
            ),
          ],
          IconButton(
            icon: const Icon(Icons.help_outline),
            tooltip: 'How to read this',
            onPressed: _showHelp,
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(52),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(12, 0, 12, 8),
            child: Align(
              alignment: Alignment.centerLeft,
              child: SegmentedButton<bool>(
                showSelectedIcon: false,
                segments: const [
                  ButtonSegment(
                    value: false,
                    icon: Icon(Icons.timeline),
                    label: Text('Chart'),
                  ),
                  ButtonSegment(
                    value: true,
                    icon: Icon(Icons.list),
                    label: Text('Events'),
                  ),
                ],
                selected: {_showEvents},
                onSelectionChanged: (s) =>
                    setState(() => _showEvents = s.first),
              ),
            ),
          ),
        ),
      ),
      body: dataAsync.when(
        loading: () => const SkeletonList(),
        error: (e, _) => Center(child: Text('Could not load the timeline: $e')),
        data: (data) {
          if (_showEvents) return _buildEventsList(context, data);
          if (data.people.isEmpty) {
            return const Center(
              child: Padding(
                padding: EdgeInsets.all(24),
                child: Text(
                  'No dated people are available for the timeline yet.',
                  textAlign: TextAlign.center,
                ),
              ),
            );
          }
          return ScrollConfiguration(
            behavior: const _DragScrollBehavior(),
            child: LayoutBuilder(
              builder: (context, constraints) {
                final bodyViewport = (constraints.maxWidth - _gutterWidth - 1)
                    .clamp(1, 1 << 30);
                _ensureInitialScale(bodyViewport.toDouble(), data);
                return _buildChart(context, data);
              },
            ),
          );
        },
      ),
    );
  }

  /// The searchable, chronological Events list — a legible alternative to the
  /// densely-packed event diamonds on the chart.
  Widget _buildEventsList(BuildContext context, TimelineData data) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final q = _eventQuery.trim().toLowerCase();
    final events = q.isEmpty
        ? data.events
        : data.events.where((e) => e.title.toLowerCase().contains(q)).toList();

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(12, 12, 12, 8),
          child: TextField(
            controller: _eventSearch,
            decoration: InputDecoration(
              hintText: 'Search events (e.g. Exodus, Flood)…',
              prefixIcon: const Icon(Icons.search),
              filled: true,
              fillColor: scheme.surfaceContainerHighest,
              isDense: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide.none,
              ),
            ),
            onChanged: (v) => setState(() => _eventQuery = v),
          ),
        ),
        if (events.isEmpty)
          Expanded(
            child: Center(
              child: Text(
                q.isEmpty
                    ? 'No dated events available.'
                    : 'No events matching "$_eventQuery".',
              ),
            ),
          )
        else
          Expanded(
            child: ListView.separated(
              itemCount: events.length,
              separatorBuilder: (_, _) => const Divider(height: 1),
              itemBuilder: (context, i) {
                final e = events[i];
                final ref = e.bookName != null
                    ? ' · ${e.bookName} ${e.chapter}:${e.verse}'
                    : '';
                return ListTile(
                  leading: SizedBox(
                    width: 24,
                    child: Center(
                      child: Transform.rotate(
                        angle:
                            0.7853981633974483, // 45°, a diamond like the axis
                        child: Container(
                          width: 11,
                          height: 11,
                          color: scheme.tertiary,
                        ),
                      ),
                    ),
                  ),
                  title: Text(e.title),
                  subtitle: Text('${formatIsoYear(e.year)}$ref'),
                  selected: e.id == _selectedEventId,
                  trailing: const Icon(Icons.chevron_right, size: 18),
                  onTap: () {
                    setState(() => _selectedEventId = e.id);
                    _showEventSheet(e);
                  },
                );
              },
            ),
          ),
      ],
    );
  }

  Widget _buildChart(BuildContext context, TimelineData data) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final contentW = _contentWidth(data);
    final step = _niceStep(_px!);

    int? selectedYear;
    if (_selectedEventId != null) {
      for (final e in data.events) {
        if (e.id == _selectedEventId) {
          selectedYear = e.year;
          break;
        }
      }
    }

    return Column(
      children: [
        // Time-axis ruler (pinned above the body, scrolls horizontally in sync).
        SizedBox(
          height: _rulerHeight,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                width: _gutterWidth,
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                color: scheme.surfaceContainerHighest,
                child: Text(
                  '${data.people.length} people',
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: scheme.onSurfaceVariant,
                  ),
                ),
              ),
              const VerticalDivider(width: 1),
              Expanded(
                child: SingleChildScrollView(
                  controller: _hHead,
                  scrollDirection: Axis.horizontal,
                  physics: const ClampingScrollPhysics(),
                  child: GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTapDown: (d) => _onRulerTapDown(d.localPosition.dx, data),
                    child: CustomPaint(
                      size: Size(contentW, _rulerHeight),
                      painter: _RulerPainter(
                        minYear: data.minYear,
                        px: _px!,
                        edgePad: _edgePad,
                        step: step,
                        events: data.events,
                        selectedYear: selectedYear,
                        labelColor: scheme.onSurfaceVariant,
                        tickColor: scheme.outlineVariant,
                        eventColor: scheme.tertiary,
                        selectedColor: scheme.primary,
                        textDirection: Directionality.of(context),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const Divider(height: 1),
        Expanded(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Pinned name gutter (scrolls vertically in sync with the body).
              SizedBox(
                width: _gutterWidth,
                child: ListView.builder(
                  controller: _vNames,
                  itemExtent: _rowHeight,
                  itemCount: data.people.length,
                  itemBuilder: (context, i) {
                    final p = data.people[i];
                    return InkWell(
                      onTap: () => showPersonDetailSheet(context, ref, p.id),
                      child: Container(
                        color: i.isEven
                            ? scheme.surfaceContainerLow
                            : Colors.transparent,
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          p.displayTitle,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: theme.textTheme.bodySmall,
                        ),
                      ),
                    );
                  },
                ),
              ),
              const VerticalDivider(width: 1),
              // Body: horizontally scrollable lifespan bars with a gridline
              // overlay, scrolling vertically in sync with the gutter.
              Expanded(
                child: SingleChildScrollView(
                  controller: _hBody,
                  scrollDirection: Axis.horizontal,
                  physics: const ClampingScrollPhysics(),
                  child: SizedBox(
                    width: contentW,
                    child: Stack(
                      children: [
                        ListView.builder(
                          controller: _vBody,
                          itemExtent: _rowHeight,
                          itemCount: data.people.length,
                          itemBuilder: (context, i) {
                            final p = data.people[i];
                            return _PersonBarRow(
                              person: p,
                              minYear: data.minYear,
                              px: _px!,
                              edgePad: _edgePad,
                              banded: i.isEven,
                              onTap: () =>
                                  showPersonDetailSheet(context, ref, p.id),
                            );
                          },
                        ),
                        Positioned.fill(
                          child: IgnorePointer(
                            child: CustomPaint(
                              painter: _GridPainter(
                                minYear: data.minYear,
                                px: _px!,
                                edgePad: _edgePad,
                                step: step,
                                selectedYear: selectedYear,
                                gridColor: scheme.outlineVariant.withValues(
                                  alpha: 0.4,
                                ),
                                boundaryColor: scheme.outline,
                                selectedColor: scheme.primary,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

/// Chooses a round tick interval so labels are spaced at least ~92px apart at
/// the current zoom.
int _niceStep(double px) {
  const steps = [25, 50, 100, 250, 500, 1000, 2000];
  for (final s in steps) {
    if (s * px >= 92) return s;
  }
  return steps.last;
}

/// One person's lifespan bar, absolutely positioned by year within the row.
class _PersonBarRow extends StatelessWidget {
  const _PersonBarRow({
    required this.person,
    required this.minYear,
    required this.px,
    required this.edgePad,
    required this.banded,
    required this.onTap,
  });

  final TimelinePerson person;
  final int minYear;
  final double px;
  final double edgePad;
  final bool banded;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final lo = person.birthYear <= person.deathYear
        ? person.birthYear
        : person.deathYear;
    final hi = person.birthYear <= person.deathYear
        ? person.deathYear
        : person.birthYear;
    final left = edgePad + (lo - minYear) * px;
    final width = ((hi - lo) * px).clamp(3.0, double.infinity);
    final showEndLabels = width > 96;

    return Stack(
      children: [
        if (banded)
          Positioned.fill(child: ColoredBox(color: scheme.surfaceContainerLow)),
        Positioned(
          left: left,
          top: 6,
          bottom: 6,
          width: width,
          child: GestureDetector(
            onTap: onTap,
            child: Container(
              decoration: BoxDecoration(
                color: scheme.primaryContainer,
                borderRadius: BorderRadius.circular(6),
                border: Border.all(
                  color: scheme.primary.withValues(alpha: 0.5),
                ),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 6),
              alignment: Alignment.center,
              child: showEndLabels
                  ? Row(
                      children: [
                        Text(
                          formatIsoYear(person.birthYear),
                          style: TextStyle(
                            fontSize: 10,
                            color: scheme.onPrimaryContainer,
                          ),
                        ),
                        const Spacer(),
                        Text(
                          formatIsoYear(person.deathYear),
                          style: TextStyle(
                            fontSize: 10,
                            color: scheme.onPrimaryContainer,
                          ),
                        ),
                      ],
                    )
                  : null,
            ),
          ),
        ),
      ],
    );
  }
}

/// Paints the time-axis ruler: round-year ticks with labels, plus a diamond
/// marker for every dated event.
class _RulerPainter extends CustomPainter {
  _RulerPainter({
    required this.minYear,
    required this.px,
    required this.edgePad,
    required this.step,
    required this.events,
    required this.selectedYear,
    required this.labelColor,
    required this.tickColor,
    required this.eventColor,
    required this.selectedColor,
    required this.textDirection,
  });

  final int minYear;
  final double px;
  final double edgePad;
  final int step;
  final List<TimelineEventPoint> events;
  final int? selectedYear;
  final Color labelColor;
  final Color tickColor;
  final Color eventColor;
  final Color selectedColor;
  final TextDirection textDirection;

  double _x(int year) => edgePad + (year - minYear) * px;

  @override
  void paint(Canvas canvas, Size size) {
    final tick = Paint()
      ..color = tickColor
      ..strokeWidth = 1;

    // Round-year ticks and labels.
    final firstTick = (minYear / step).ceil() * step;
    final lastYear = minYear + ((size.width - edgePad * 2) / px).round();
    for (var y = firstTick; y <= lastYear; y += step) {
      final x = _x(y);
      canvas.drawLine(
        Offset(x, size.height - 12),
        Offset(x, size.height),
        tick,
      );
      final tp = TextPainter(
        text: TextSpan(
          text: _axisLabel(y),
          style: TextStyle(color: labelColor, fontSize: 11),
        ),
        textDirection: textDirection,
      )..layout();
      tp.paint(canvas, Offset(x - tp.width / 2, 4));
    }

    // Event markers (diamonds) sitting just above the baseline.
    final markY = size.height - 16.0;
    for (final e in events) {
      final selected = e.year == selectedYear;
      _diamond(
        canvas,
        Offset(_x(e.year), markY),
        selected ? 5 : 3.5,
        selected ? selectedColor : eventColor,
      );
    }
  }

  void _diamond(Canvas canvas, Offset c, double r, Color color) {
    final path = Path()
      ..moveTo(c.dx, c.dy - r)
      ..lineTo(c.dx + r, c.dy)
      ..lineTo(c.dx, c.dy + r)
      ..lineTo(c.dx - r, c.dy)
      ..close();
    canvas.drawPath(path, Paint()..color = color);
  }

  @override
  bool shouldRepaint(_RulerPainter old) =>
      old.minYear != minYear ||
      old.px != px ||
      old.step != step ||
      old.selectedYear != selectedYear ||
      old.events != events;
}

/// Paints the body's vertical gridlines (aligned to the ruler ticks), the
/// BC/AD boundary, and the selected event's highlight line.
class _GridPainter extends CustomPainter {
  _GridPainter({
    required this.minYear,
    required this.px,
    required this.edgePad,
    required this.step,
    required this.selectedYear,
    required this.gridColor,
    required this.boundaryColor,
    required this.selectedColor,
  });

  final int minYear;
  final double px;
  final double edgePad;
  final int step;
  final int? selectedYear;
  final Color gridColor;
  final Color boundaryColor;
  final Color selectedColor;

  double _x(int year) => edgePad + (year - minYear) * px;

  @override
  void paint(Canvas canvas, Size size) {
    final grid = Paint()
      ..color = gridColor
      ..strokeWidth = 1;
    final firstTick = (minYear / step).ceil() * step;
    final lastYear = minYear + ((size.width - edgePad * 2) / px).round();
    for (var y = firstTick; y <= lastYear; y += step) {
      final x = _x(y);
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), grid);
    }

    // The BC/AD boundary, if it's within range.
    if (minYear < 0 && lastYear > 0) {
      canvas.drawLine(
        Offset(_x(0), 0),
        Offset(_x(0), size.height),
        Paint()
          ..color = boundaryColor
          ..strokeWidth = 1.5,
      );
    }

    if (selectedYear != null) {
      canvas.drawLine(
        Offset(_x(selectedYear!), 0),
        Offset(_x(selectedYear!), size.height),
        Paint()
          ..color = selectedColor
          ..strokeWidth = 2,
      );
    }
  }

  @override
  bool shouldRepaint(_GridPainter old) =>
      old.minYear != minYear ||
      old.px != px ||
      old.step != step ||
      old.selectedYear != selectedYear;
}

/// Ruler tick label: BC for negative years, AD otherwise (no year 0).
String _axisLabel(int year) {
  if (year < 0) return '${-year} BC';
  if (year == 0) return '1 BC';
  return 'AD $year';
}

/// Lets the timeline be panned by mouse drag on desktop/web, not just touch
/// and trackpad.
class _DragScrollBehavior extends MaterialScrollBehavior {
  const _DragScrollBehavior();

  @override
  Set<PointerDeviceKind> get dragDevices => {
    PointerDeviceKind.touch,
    PointerDeviceKind.mouse,
    PointerDeviceKind.trackpad,
    PointerDeviceKind.stylus,
  };
}
