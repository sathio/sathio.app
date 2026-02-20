import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../services/voice/voice_state.dart';
import '../../../services/voice/voice_providers.dart';
import '../screens/response_screen.dart'; // Import ResponseScreen

/// Modal overlay that appears when the user is speaking.
/// Shows animated mic, waveform, and current voice state.
class ListeningOverlay extends ConsumerStatefulWidget {
  const ListeningOverlay({super.key});

  static Future<void> show(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      enableDrag: false,
      builder: (context) => const ListeningOverlay(),
    );
  }

  @override
  ConsumerState<ListeningOverlay> createState() => _ListeningOverlayState();
}

class _ListeningOverlayState extends ConsumerState<ListeningOverlay> {
  bool _hasPopped = false;

  void _safePop() {
    if (!_hasPopped && mounted) {
      _hasPopped = true;
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    // Watch voice state to update UI
    final voiceState = ref.watch(voiceInteractionProvider);

    // Auto-close if idle (cancelled) or speaking (handoff to response screen)
    ref.listen(voiceInteractionProvider, (previous, next) {
      if (next is VoiceSpeaking && previous is! VoiceSpeaking) {
        if (mounted) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (_) => const ResponseScreen()),
          );
        }
      } else if (next is VoiceIdle && previous is! VoiceIdle) {
        _safePop();
      }
    });

    return Container(
      height: 350,
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Color(0xFF1A1A1A), // Dark surface
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(32),
          topRight: Radius.circular(32),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Close button
          Align(
            alignment: Alignment.topRight,
            child: IconButton(
              onPressed: () {
                ref.read(voiceInteractionProvider.notifier).cancelListening();
              },
              icon: const Icon(Icons.close, color: Colors.white54),
            ),
          ),

          // Main Animation Area
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Animated Mic Icon — tap to stop recording
                GestureDetector(
                  onTap: () {
                    if (voiceState is VoiceListening) {
                      ref
                          .read(voiceInteractionProvider.notifier)
                          .stopListening();
                    }
                  },
                  child: _buildAnimatedMic(voiceState),
                ),
                const SizedBox(height: 24),

                // Status Text
                _buildStatusText(voiceState),
                const SizedBox(height: 8),

                // Timer or Waveform
                if (voiceState is VoiceListening)
                  Text(
                    _formatDuration(voiceState.elapsed),
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      color: Colors.white54,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildAnimatedMic(VoiceState state) {
    final isListening = state is VoiceListening;
    final isProcessing = state is VoiceProcessing;

    return Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: const LinearGradient(
              colors: [Color(0xFFF58220), Color(0xFFF7A94B)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFFF58220).withValues(alpha: 0.3),
                blurRadius: 20,
                spreadRadius: isListening ? 10 : 0, // Pulse effect
              ),
            ],
          ),
          child: Icon(
            isProcessing
                ? Icons.sync
                : isListening
                ? Icons.stop_rounded
                : Icons.mic,
            color: Colors.white,
            size: 32,
          ),
        )
        .animate(target: isListening ? 1 : 0)
        .scale(
          begin: const Offset(1, 1),
          end: const Offset(1.1, 1.1),
          duration: 600.ms,
          curve: Curves.easeInOut,
        )
        .then(
          delay: 600.ms,
        ) // Loop effect handled by repetitive triggers or use onPlay
        .animate(target: isProcessing ? 1 : 0)
        .rotate(duration: 1000.ms, curve: Curves.linear); // Spin if processing
  }

  Widget _buildStatusText(VoiceState state) {
    String text = 'Boliye... mic dabayein band karne ke liye';
    if (state is VoiceProcessing) {
      if (state.step == ProcessingStep.detectingLanguage) {
        text = 'Bhasha pehchan raha hoon...';
      } else if (state.step == ProcessingStep.transcribing) {
        text = 'Likh raha hoon...';
      } else {
        text = 'Samajh raha hoon...';
      }
    } else if (state is VoiceSpeaking) {
      text = 'Bol raha hoon...';
    } else if (state is VoiceError) {
      text = 'Kuch gadbad ho gayi.';
    }

    return Text(
      text,
      style: GoogleFonts.inter(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
    ).animate().fadeIn().slideY(begin: 0.2, end: 0);
  }

  String _formatDuration(Duration d) {
    final minutes = d.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = d.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }
}
