import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';

enum MicState { idle, listening, processing }

class MicButton extends StatefulWidget {
  final VoidCallback onPressed;
  final MicState state;

  const MicButton({
    super.key,
    required this.onPressed,
    this.state = MicState.idle,
  });

  @override
  State<MicButton> createState() => _MicButtonState();
}

class _MicButtonState extends State<MicButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isListening = widget.state == MicState.listening;
    final isProcessing = widget.state == MicState.processing;

    return GestureDetector(
      onTap: () {
        HapticFeedback.mediumImpact();
        widget.onPressed();
      },
      child: AnimatedBuilder(
        animation: _pulseController,
        builder: (context, child) {
          double pulse = 0.0;
          if (widget.state == MicState.idle) {
            pulse = (_pulseController.value * 6); // Subtle pulse
          } else if (isListening) {
            pulse = (_pulseController.value * 12); // Intense pulse
          }

          return Container(
            width: 64 + pulse,
            height: 64 + pulse,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFFF58220).withValues(alpha: 0.3),
                  blurRadius: 16 + pulse,
                  spreadRadius: pulse / 2,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Container(
              width: 64,
              height: 64,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [Color(0xFFF58220), Color(0xFFF7A94B)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              alignment: Alignment.center,
              child: _buildIcon(isListening, isProcessing),
            ),
          );
        },
      ),
    );
  }

  Widget _buildIcon(bool isListening, bool isProcessing) {
    if (isProcessing) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(3, (index) {
          return Container(
                margin: const EdgeInsets.symmetric(horizontal: 2),
                width: 6,
                height: 6,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
              )
              .animate(onPlay: (c) => c.repeat())
              .scale(
                duration: 600.ms,
                delay: (index * 200).ms,
                begin: const Offset(1, 1),
                end: const Offset(1.5, 1.5),
              )
              .fade(begin: 0.5, end: 1.0);
        }),
      );
    } else if (isListening) {
      return const Icon(
        Icons.graphic_eq, // Placeholder for waveform
        color: Colors.white,
        size: 28,
      ).animate(onPlay: (c) => c.repeat()).shake(duration: 1200.ms, hz: 2);
    } else {
      return const Icon(Icons.mic, color: Colors.white, size: 28);
    }
  }
}
