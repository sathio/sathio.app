import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../buttons/buttons.dart';

class AgentActionCard extends StatelessWidget {
  final String actionDescription;
  final Widget icon;
  final VoidCallback onStop;
  final double? progress; // 0.0 to 1.0, null for indeterminate

  const AgentActionCard({
    super.key,
    required this.actionDescription,
    required this.icon,
    required this.onStop,
    this.progress,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF111111),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.2),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              // Animated Icon Container
              Container(
                width: 40,
                height: 40,
                decoration: const BoxDecoration(
                  color: Color(0xFF2A2A2A),
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: icon
                    .animate(onPlay: (c) => c.repeat(reverse: true))
                    .scaleXY(
                      begin: 0.9,
                      end: 1.1,
                      duration: 1500.ms,
                      curve: Curves.easeInOut,
                    ),
              ),
              const SizedBox(width: 12),
              // Header
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Sathio is working...',
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFFF58220),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      actionDescription,
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              // Stop Button
              SecondaryButton(
                onPressed: onStop,
                text: 'Stop',
                isDark: true, // Use dark variant inside this dark card
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Progress Bar
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: progress, // null for indeterminate
              backgroundColor: const Color(0xFF333333),
              valueColor: const AlwaysStoppedAnimation<Color>(
                Color(0xFFF58220),
              ),
              minHeight: 4,
            ),
          ),
        ],
      ),
    );
  }
}
