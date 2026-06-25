import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:just_audio/just_audio.dart';
import '../../app/audio_providers.dart';
import '../../app/reader_state.dart';

/// Bottom-sheet view onto the long-lived [AudioPlayerController]. The player
/// itself lives in the controller (a kept-alive provider), so dismissing this
/// sheet does not stop playback.
class AudioPlayerWidget extends ConsumerStatefulWidget {
  const AudioPlayerWidget({super.key});

  @override
  ConsumerState<AudioPlayerWidget> createState() => _AudioPlayerWidgetState();
}

class _AudioPlayerWidgetState extends ConsumerState<AudioPlayerWidget> {
  // The only state that belongs to the sheet itself: the in-progress scrub
  // position. Non-null while the user is dragging the slider.
  double? _dragValue;

  // Shared pill container for the secondary controls.
  Widget _chip(BuildContext context, {required Widget child, bool active = false}) {
    final scheme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: active
            ? scheme.primaryContainer
            : scheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(16),
      ),
      child: child,
    );
  }

  Widget _buildSpeedChip(BuildContext context, double playbackSpeed) {
    final scheme = Theme.of(context).colorScheme;
    final label = playbackSpeed == playbackSpeed.roundToDouble()
        ? '${playbackSpeed.toStringAsFixed(0)}×'
        : '$playbackSpeed×';
    final active = playbackSpeed != 1.0;
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: () =>
          ref.read(audioPlayerControllerProvider.notifier).cycleSpeed(),
      child: _chip(
        context,
        active: active,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.speed, size: 16, color: scheme.onSurfaceVariant),
            const SizedBox(width: 6),
            Text(
              label,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: scheme.onSurfaceVariant,
                  ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildVoiceChip(BuildContext context, ChapterAudioData audioData) {
    final scheme = Theme.of(context).colorScheme;
    return _chip(
      context,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.record_voice_over, size: 16, color: scheme.onSurfaceVariant),
          const SizedBox(width: 6),
          DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: audioData.activeVoice,
              icon: Icon(Icons.arrow_drop_down, size: 20, color: scheme.onSurfaceVariant),
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: scheme.onSurfaceVariant,
                  ),
              isDense: true,
              onChanged: (String? newValue) {
                if (newValue != null) {
                  ref.read(selectedVoiceProvider.notifier).setVoice(newValue);
                }
              },
              items: audioData.availableVoices.map<DropdownMenuItem<String>>((String value) {
                final formattedName = value[0].toUpperCase() + value.substring(1);
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(formattedName),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSleepChip(BuildContext context, int? sleepMinutes) {
    final scheme = Theme.of(context).colorScheme;
    final active = sleepMinutes != null;
    return PopupMenuButton<int?>(
      tooltip: 'Sleep timer',
      onSelected: (m) =>
          ref.read(audioPlayerControllerProvider.notifier).setSleepTimer(m),
      itemBuilder: (context) => [
        const PopupMenuItem<int?>(value: null, child: Text('Off')),
        ...AudioPlayerController.sleepOptions.map(
          (m) => PopupMenuItem<int?>(value: m, child: Text('$m minutes')),
        ),
      ],
      child: _chip(
        context,
        active: active,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.bedtime, size: 16, color: scheme.onSurfaceVariant),
            const SizedBox(width: 6),
            Text(
              active ? '$sleepMinutes min' : 'Sleep',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: scheme.onSurfaceVariant,
                  ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final audioData = ref.watch(chapterAudioProvider);

    if (audioData == null) {
      return const SizedBox.shrink();
    }

    final uiState = ref.watch(audioPlayerControllerProvider);
    final controller = ref.read(audioPlayerControllerProvider.notifier);
    final player = controller.player;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Drag handle
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.onSurfaceVariant.withAlpha(80),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Title
            Text(
              'Now Playing',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
            ),
            const SizedBox(height: 8),
            Text(
              '${ref.watch(selectedBookNameProvider)} ${ref.watch(selectedChapterProvider)}',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            if (uiState.loadFailed) ...[
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.error_outline,
                    size: 18,
                    color: Theme.of(context).colorScheme.error,
                  ),
                  const SizedBox(width: 8),
                  Flexible(
                    child: Text(
                      'Could not load audio.',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Theme.of(context).colorScheme.error,
                          ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  TextButton(
                    onPressed: controller.retryLoad,
                    child: const Text('Retry'),
                  ),
                ],
              ),
            ],
            const SizedBox(height: 32),

            // Slider
            StreamBuilder<Duration>(
              stream: player.positionStream,
              builder: (context, snapshot) {
                final position = snapshot.data ?? Duration.zero;
                final duration = player.duration ?? Duration.zero;
                final maxMs = duration.inMilliseconds.toDouble() > 0
                    ? duration.inMilliseconds.toDouble()
                    : 1.0;
                // While scrubbing, show the dragged position, not the stream's.
                final sliderValue = (_dragValue ?? position.inMilliseconds.toDouble())
                    .clamp(0.0, maxMs);
                final labelMs = (_dragValue ?? position.inMilliseconds.toDouble()).round();

                String formatDuration(Duration d) {
                  String twoDigits(int n) => n.toString().padLeft(2, "0");
                  String twoDigitMinutes = twoDigits(d.inMinutes.remainder(60));
                  String twoDigitSeconds = twoDigits(d.inSeconds.remainder(60));
                  if (d.inHours > 0) return "${twoDigits(d.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
                  return "$twoDigitMinutes:$twoDigitSeconds";
                }

                final timeStyle = Theme.of(context).textTheme.labelSmall;

                return Column(
                  children: [
                    SliderTheme(
                      data: SliderTheme.of(context).copyWith(
                        trackHeight: 4.0,
                        thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 8.0),
                      ),
                      child: Slider(
                        value: sliderValue,
                        max: maxMs,
                        // Update only local state while dragging; seek on release
                        // so we don't spam the player on every pixel of movement.
                        onChanged: (value) {
                          setState(() => _dragValue = value);
                        },
                        onChangeEnd: (value) {
                          player.seek(Duration(milliseconds: value.round()));
                          setState(() => _dragValue = null);
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(formatDuration(Duration(milliseconds: labelMs)), style: timeStyle),
                          Text(formatDuration(duration), style: timeStyle),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),

            const SizedBox(height: 24),

            // Controls — FittedBox keeps the 5-button row from overflowing on
            // very narrow screens by scaling it down.
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: const Icon(Icons.skip_previous),
                  iconSize: 32.0,
                  tooltip: 'Previous chapter',
                  onPressed: () => controller.skipChapter(forward: false),
                ),
                const SizedBox(width: 8),
                IconButton(
                  icon: const Icon(Icons.replay_10),
                  iconSize: 28.0,
                  tooltip: 'Back 10 seconds',
                  onPressed: () {
                    final newPos = player.position - const Duration(seconds: 10);
                    player.seek(newPos < Duration.zero ? Duration.zero : newPos);
                  },
                ),
                const SizedBox(width: 12),
                StreamBuilder<PlayerState>(
                  stream: player.playerStateStream,
                  builder: (context, snapshot) {
                    final playerState = snapshot.data;
                    final processingState = playerState?.processingState;
                    final playing = playerState?.playing;

                    Widget playPauseIcon;
                    if (processingState == ProcessingState.loading ||
                        processingState == ProcessingState.buffering) {
                      playPauseIcon = const SizedBox(
                        width: 48,
                        height: 48,
                        child: CircularProgressIndicator(strokeWidth: 3),
                      );
                    } else if (playing != true) {
                      playPauseIcon = const Icon(Icons.play_circle_fill, size: 64);
                    } else if (processingState != ProcessingState.completed) {
                      playPauseIcon = const Icon(Icons.pause_circle_filled, size: 64);
                    } else {
                      playPauseIcon = const Icon(Icons.replay_circle_filled, size: 64);
                    }

                    return IconButton(
                      icon: playPauseIcon,
                      iconSize: 64.0,
                      padding: EdgeInsets.zero,
                      color: Theme.of(context).colorScheme.primary,
                      onPressed: () {
                        if (playing != true) {
                          player.play();
                        } else if (processingState != ProcessingState.completed) {
                          player.pause();
                        } else {
                          player.seek(Duration.zero);
                        }
                      },
                    );
                  },
                ),
                const SizedBox(width: 12),
                IconButton(
                  icon: const Icon(Icons.forward_10),
                  iconSize: 28.0,
                  tooltip: 'Forward 10 seconds',
                  onPressed: () {
                    final newPos = player.position + const Duration(seconds: 10);
                    final dur = player.duration ?? Duration.zero;
                    player.seek(newPos > dur ? dur : newPos);
                  },
                ),
                const SizedBox(width: 8),
                IconButton(
                  icon: const Icon(Icons.skip_next),
                  iconSize: 32.0,
                  tooltip: 'Next chapter',
                  onPressed: () => controller.skipChapter(forward: true),
                ),
              ],
              ),
            ),

            const SizedBox(height: 32),

            // Secondary controls: speed, voice actor, sleep timer
            Wrap(
              alignment: WrapAlignment.center,
              crossAxisAlignment: WrapCrossAlignment.center,
              spacing: 12,
              runSpacing: 8,
              children: [
                _buildSpeedChip(context, uiState.playbackSpeed),
                _buildVoiceChip(context, audioData),
                _buildSleepChip(context, uiState.sleepMinutes),
              ],
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
