import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../buttons/buttons.dart';

class ResponseCard extends StatelessWidget {
  final String content;
  final VoidCallback onPlayPause;
  final bool isPlaying;
  final VoidCallback onToggleSpeed;
  final double currentSpeed; // 0.75, 1.0, 1.25
  final String? timestamp;

  const ResponseCard({
    super.key,
    required this.content,
    required this.onPlayPause,
    required this.isPlaying,
    required this.onToggleSpeed,
    required this.currentSpeed,
    this.timestamp,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Avatar
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: const Color(0xFFFFF5EB),
              shape: BoxShape.circle,
              border: Border.all(color: const Color(0xFFF58220), width: 1),
            ),
            alignment: Alignment.center,
            child: const Icon(
              Icons.smart_toy_outlined,
              color: Color(0xFFF58220),
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          // Bubble
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: const BoxDecoration(
                    color: Color(0xFFF5F5F5),
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(16),
                      bottomLeft: Radius.circular(16),
                      bottomRight: Radius.circular(16),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        content,
                        style: GoogleFonts.inter(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          color: const Color(0xFF111111),
                          height: 1.5,
                        ),
                      ),
                      const SizedBox(height: 12),
                      // Controls
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CircularIconButton(
                            onPressed: onPlayPause,
                            icon: Icon(
                              isPlaying ? Icons.pause : Icons.volume_up,
                              color: const Color(0xFF666666),
                              size: 18,
                            ),
                            backgroundColor: Colors.white,
                          ),
                          const SizedBox(width: 8),
                          GestureDetector(
                            onTap: onToggleSpeed,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: const Color(0xFFE0E0E0),
                                ),
                              ),
                              child: Text(
                                '${currentSpeed}x',
                                style: GoogleFonts.inter(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: const Color(0xFF666666),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                if (timestamp != null) ...[
                  const SizedBox(height: 4),
                  Text(
                    timestamp!,
                    style: GoogleFonts.inter(
                      fontSize: 10,
                      color: const Color(0xFF999999),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
