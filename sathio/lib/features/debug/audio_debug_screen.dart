import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../services/audio/audio_providers.dart';
import '../../../services/audio/audio_recorder_service.dart';
import '../../../services/audio/audio_player_service.dart';

/// Debug screen for testing audio record → playback cycle.
/// Navigate here during development to verify audio services work correctly.
class AudioDebugScreen extends ConsumerStatefulWidget {
  const AudioDebugScreen({super.key});

  @override
  ConsumerState<AudioDebugScreen> createState() => _AudioDebugScreenState();
}

class _AudioDebugScreenState extends ConsumerState<AudioDebugScreen> {
  String? _recordedPath;
  double _playbackSpeed = 1.0;
  String _statusLog = 'Ready. Tap Record to begin.\n';

  void _log(String message) {
    setState(() {
      _statusLog +=
          '${DateTime.now().toIso8601String().substring(11, 19)} — $message\n';
    });
  }

  @override
  Widget build(BuildContext context) {
    final recordingState = ref.watch(recordingStateProvider);
    final playbackState = ref.watch(playbackStateProvider);
    final position = ref.watch(playbackPositionProvider);
    final duration = ref.watch(audioDurationProvider);

    final recorder = ref.read(audioRecorderProvider);
    final player = ref.read(audioPlayerProvider);

    final isRecording =
        recordingState.whenOrNull(data: (s) => s == RecordingState.recording) ??
        false;
    final isPlaying =
        playbackState.whenOrNull(
          data: (s) => s == AudioPlaybackState.playing,
        ) ??
        false;
    final isPaused =
        playbackState.whenOrNull(data: (s) => s == AudioPlaybackState.paused) ??
        false;

    final posValue = position.value ?? Duration.zero;
    final durValue = duration.value ?? Duration.zero;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Audio Debug',
          style: GoogleFonts.inter(fontWeight: FontWeight.w600),
        ),
        backgroundColor: Colors.white,
        foregroundColor: const Color(0xFF111111),
        elevation: 0,
      ),
      backgroundColor: const Color(0xFFFAFAFA),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // --- Recording Section ---
              _sectionCard(
                title: '🎙️ Recording',
                child: Column(
                  children: [
                    // State indicator
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: isRecording
                            ? const Color(0xFFEF4444).withValues(alpha: 0.1)
                            : const Color(0xFFF5F5F5),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 8,
                            height: 8,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: isRecording
                                  ? const Color(0xFFEF4444)
                                  : const Color(0xFFB0B0B0),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            isRecording ? 'Recording...' : 'Idle',
                            style: GoogleFonts.inter(
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xFF333333),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 16),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Record / Stop
                        _actionButton(
                          icon: isRecording
                              ? Icons.stop
                              : Icons.fiber_manual_record,
                          label: isRecording ? 'Stop' : 'Record',
                          color: isRecording
                              ? const Color(0xFF333333)
                              : const Color(0xFFEF4444),
                          onTap: () async {
                            if (isRecording) {
                              _log('Stopping recording...');
                              final path = await recorder.stopRecording();
                              setState(() => _recordedPath = path);
                              _log('Saved to: $path');
                            } else {
                              _log('Starting recording...');
                              await recorder.startRecording();
                              _log('Recording started');
                            }
                          },
                        ),
                        const SizedBox(width: 16),
                        // Cancel
                        _actionButton(
                          icon: Icons.delete_outline,
                          label: 'Cancel',
                          color: const Color(0xFF999999),
                          onTap: isRecording
                              ? () async {
                                  _log('Cancelling recording...');
                                  await recorder.cancelRecording();
                                  setState(() => _recordedPath = null);
                                  _log('Recording cancelled');
                                }
                              : null,
                        ),
                      ],
                    ),

                    if (_recordedPath != null) ...[
                      const SizedBox(height: 12),
                      Text(
                        'File: ${_recordedPath!.split('/').last}',
                        style: GoogleFonts.inter(
                          fontSize: 12,
                          color: const Color(0xFF22C55E),
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // --- Playback Section ---
              _sectionCard(
                title: '🔊 Playback',
                child: Column(
                  children: [
                    // Progress bar
                    SliderTheme(
                      data: SliderTheme.of(context).copyWith(
                        trackHeight: 4,
                        thumbShape: const RoundSliderThumbShape(
                          enabledThumbRadius: 6,
                        ),
                        activeTrackColor: const Color(0xFFF58220),
                        inactiveTrackColor: const Color(0xFFE0E0E0),
                        thumbColor: const Color(0xFFF58220),
                      ),
                      child: Slider(
                        value: durValue.inMilliseconds > 0
                            ? posValue.inMilliseconds.toDouble().clamp(
                                0,
                                durValue.inMilliseconds.toDouble(),
                              )
                            : 0,
                        max: durValue.inMilliseconds > 0
                            ? durValue.inMilliseconds.toDouble()
                            : 1,
                        onChanged: (val) {
                          player.seek(Duration(milliseconds: val.toInt()));
                        },
                      ),
                    ),
                    // Time labels
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            _formatDuration(posValue),
                            style: GoogleFonts.inter(
                              fontSize: 12,
                              color: const Color(0xFF999999),
                            ),
                          ),
                          Text(
                            _formatDuration(durValue),
                            style: GoogleFonts.inter(
                              fontSize: 12,
                              color: const Color(0xFF999999),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 12),

                    // Controls
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _actionButton(
                          icon: Icons.play_arrow,
                          label: 'Play',
                          color: const Color(0xFF22C55E),
                          onTap: _recordedPath != null && !isPlaying
                              ? () async {
                                  _log(
                                    'Playing: ${_recordedPath!.split('/').last}',
                                  );
                                  await player.play(_recordedPath!);
                                }
                              : null,
                        ),
                        const SizedBox(width: 12),
                        _actionButton(
                          icon: isPaused ? Icons.play_arrow : Icons.pause,
                          label: isPaused ? 'Resume' : 'Pause',
                          color: const Color(0xFFF58220),
                          onTap: isPlaying || isPaused
                              ? () async {
                                  if (isPlaying) {
                                    await player.pause();
                                    _log('Paused');
                                  } else {
                                    await player.resume();
                                    _log('Resumed');
                                  }
                                }
                              : null,
                        ),
                        const SizedBox(width: 12),
                        _actionButton(
                          icon: Icons.stop,
                          label: 'Stop',
                          color: const Color(0xFF333333),
                          onTap: isPlaying || isPaused
                              ? () async {
                                  await player.stop();
                                  _log('Stopped');
                                }
                              : null,
                        ),
                      ],
                    ),

                    const SizedBox(height: 12),

                    // Speed controls
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [0.75, 1.0, 1.25, 1.5].map((speed) {
                        final isActive = _playbackSpeed == speed;
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          child: GestureDetector(
                            onTap: () {
                              setState(() => _playbackSpeed = speed);
                              player.setSpeed(speed);
                              _log('Speed set to ${speed}x');
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color: isActive
                                    ? const Color(0xFFF58220)
                                    : const Color(0xFFF5F5F5),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                '${speed}x',
                                style: GoogleFonts.inter(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: isActive
                                      ? Colors.white
                                      : const Color(0xFF666666),
                                ),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // --- Log ---
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1A1A1A),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: SingleChildScrollView(
                    reverse: true,
                    child: Text(
                      _statusLog,
                      style: GoogleFonts.jetBrainsMono(
                        fontSize: 11,
                        color: const Color(0xFF66FF66),
                        height: 1.6,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _sectionCard({required String title, required Widget child}) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE8E8E8)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title,
            style: GoogleFonts.inter(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF111111),
            ),
          ),
          const SizedBox(height: 12),
          child,
        ],
      ),
    );
  }

  Widget _actionButton({
    required IconData icon,
    required String label,
    required Color color,
    VoidCallback? onTap,
  }) {
    final isDisabled = onTap == null;
    return GestureDetector(
      onTap: onTap,
      child: Opacity(
        opacity: isDisabled ? 0.35 : 1.0,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: color, size: 22),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: GoogleFonts.inter(
                fontSize: 11,
                fontWeight: FontWeight.w500,
                color: const Color(0xFF666666),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatDuration(Duration d) {
    final minutes = d.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = d.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }
}
