import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../providers/home_provider.dart';
import '../../../core/animations/stagger_helpers.dart';
import '../../voice/voice_overlay_controller.dart';
import '../../services/services_screen.dart'; // Import ServicesScreen

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  int? _activeChipIndex;

  @override
  Widget build(BuildContext context) {
    final homeState = ref.watch(homeProvider);
    final bottomPadding = MediaQuery.of(context).padding.bottom;

    // Listen for Voice Response to navigate
    // Listener removed: Navigation handled by ListeningOverlay to avoid race conditions

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFFF8F0FF), // Soft lavender
              Color(0xFFE8F4FD), // Soft blue
              Color(0xFFFFF8F0), // Warm cream
            ],
            stops: [0.0, 0.5, 1.0],
          ),
        ),
        child: Stack(
          children: [
            // Subtle radial overlays (Luma texture)
            Positioned.fill(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: RadialGradient(
                    center: const Alignment(-0.8, -0.6),
                    radius: 1.8,
                    colors: [
                      const Color(0xFFE8DEFF).withValues(alpha: 0.15),
                      const Color(0xFFD6EEFF).withValues(alpha: 0.1),
                      Colors.transparent,
                    ],
                    stops: const [0.0, 0.3, 0.7],
                  ),
                ),
              ),
            ),
            Positioned.fill(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: RadialGradient(
                    center: const Alignment(0.9, 0.7),
                    radius: 1.4,
                    colors: [
                      const Color(0xFFFFE8D6).withValues(alpha: 0.12),
                      const Color(0xFFFFF0E8).withValues(alpha: 0.08),
                      Colors.transparent,
                    ],
                    stops: const [0.0, 0.35, 0.7],
                  ),
                ),
              ),
            ),

            // Scrollable content
            CustomScrollView(
              slivers: [
                // Top safe area
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: MediaQuery.of(context).padding.top + 16,
                  ),
                ),

                // --- Top Bar ---
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Language Pill
                        GestureDetector(
                              onTap: () => _showLanguageDialog(context, ref),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 6,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.white.withValues(alpha: 0.8),
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                    color: const Color(0xFFE8E8E8),
                                  ),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Text(
                                      '🇮🇳',
                                      style: TextStyle(fontSize: 14),
                                    ),
                                    const SizedBox(width: 6),
                                    Text(
                                      homeState.language,
                                      style: GoogleFonts.inter(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w500,
                                        color: const Color(0xFF111111),
                                      ),
                                    ),
                                    const SizedBox(width: 4),
                                    const Icon(
                                      Icons.keyboard_arrow_down_rounded,
                                      size: 16,
                                      color: Color(0xFF999999),
                                    ),
                                  ],
                                ),
                              ),
                            )
                            .animate()
                            .fadeIn(duration: 300.ms, delay: 200.ms)
                            .slideY(begin: -0.3, end: 0, duration: 300.ms),

                        // Right: Settings + Avatar
                        Row(
                              children: [
                                Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: Colors.white.withValues(alpha: 0.8),
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: const Color(0xFFE8E8E8),
                                    ),
                                  ),
                                  child: const Icon(
                                    Icons.settings_outlined,
                                    color: Color(0xFF666666),
                                    size: 20,
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Container(
                                  width: 40,
                                  height: 40,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    gradient: LinearGradient(
                                      colors: [
                                        Color(0xFFF58220),
                                        Color(0xFFF7A94B),
                                      ],
                                    ),
                                  ),
                                  child: const Icon(
                                    Icons.person,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                ),
                              ],
                            )
                            .animate()
                            .fadeIn(duration: 300.ms, delay: 200.ms)
                            .slideY(begin: -0.3, end: 0, duration: 300.ms),
                      ],
                    ),
                  ),
                ),

                // --- Greeting ---
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 32, 20, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TypewriterText(
                          text: '${homeState.greeting}, ${homeState.userName}!',
                          style: GoogleFonts.inter(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF111111),
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                              'How can I help you?',
                              style: GoogleFonts.inter(
                                fontSize: 16,
                                color: const Color(0xFF666666),
                              ),
                            )
                            .animate(delay: 600.ms)
                            .fadeIn(duration: 400.ms)
                            .slideY(begin: 0.15, end: 0, duration: 400.ms),
                      ],
                    ),
                  ),
                ),

                // --- Search / Voice Bar ---
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 24, 20, 0),
                    child:
                        GestureDetector(
                              onTap: () {
                                HapticFeedback.lightImpact();
                                VoiceOverlayController.showAndStartListening(
                                  context,
                                  ref,
                                );
                              },
                              child: Container(
                                height: 56,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(100),
                                  border: Border.all(
                                    color: const Color(0xFFE8E8E8),
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withValues(
                                        alpha: 0.04,
                                      ),
                                      blurRadius: 12,
                                      offset: const Offset(0, 4),
                                    ),
                                  ],
                                ),
                                child: Row(
                                  children: [
                                    const Icon(
                                      Icons.search_rounded,
                                      color: Color(0xFFB0B0B0),
                                      size: 22,
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: Text(
                                        'Speak or type...',
                                        style: GoogleFonts.inter(
                                          fontSize: 15,
                                          color: const Color(0xFFB0B0B0),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: 34,
                                      height: 34,
                                      decoration: BoxDecoration(
                                        gradient: const LinearGradient(
                                          colors: [
                                            Color(0xFFF58220),
                                            Color(0xFFF7A94B),
                                          ],
                                        ),
                                        shape: BoxShape.circle,
                                        boxShadow: [
                                          BoxShadow(
                                            color: const Color(
                                              0xFFF58220,
                                            ).withValues(alpha: 0.25),
                                            blurRadius: 8,
                                            offset: const Offset(0, 2),
                                          ),
                                        ],
                                      ),
                                      child: const Icon(
                                        Icons.mic,
                                        color: Colors.white,
                                        size: 18,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                            .animate(delay: 800.ms)
                            .fadeIn(duration: 400.ms)
                            .slideY(
                              begin: 0.3,
                              end: 0,
                              duration: 400.ms,
                              curve: Curves.easeOutBack,
                            ),
                  ),
                ),

                // --- Quick Action Chips ---
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 22),
                    child: SizedBox(
                      height: 42,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        itemCount: homeState.quickActions.length,
                        itemBuilder: (context, index) {
                          final action = homeState.quickActions[index];
                          final isActive = _activeChipIndex == index;
                          return Padding(
                                padding: const EdgeInsets.only(right: 8),
                                child: GestureDetector(
                                  onTap: () {
                                    HapticFeedback.selectionClick();
                                    setState(() {
                                      _activeChipIndex = isActive
                                          ? null
                                          : index;
                                    });
                                    // Navigate to services if selected
                                    if (action.id == 'services') {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (_) =>
                                              const ServicesScreen(),
                                        ),
                                      );
                                    }
                                  },
                                  child: AnimatedContainer(
                                    duration: const Duration(milliseconds: 200),
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 16,
                                      vertical: 8,
                                    ),
                                    decoration: BoxDecoration(
                                      color: isActive
                                          ? const Color(0xFFF58220)
                                          : Colors.white.withValues(alpha: 0.9),
                                      borderRadius: BorderRadius.circular(10),
                                      border: isActive
                                          ? null
                                          : Border.all(
                                              color: const Color(0xFFE8E8E8),
                                            ),
                                      boxShadow: isActive
                                          ? [
                                              BoxShadow(
                                                color: const Color(
                                                  0xFFF58220,
                                                ).withValues(alpha: 0.3),
                                                blurRadius: 8,
                                                offset: const Offset(0, 2),
                                              ),
                                            ]
                                          : [
                                              BoxShadow(
                                                color: Colors.black.withValues(
                                                  alpha: 0.03,
                                                ),
                                                blurRadius: 4,
                                                offset: const Offset(0, 1),
                                              ),
                                            ],
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          action.emoji,
                                          style: const TextStyle(fontSize: 14),
                                        ),
                                        const SizedBox(width: 6),
                                        Text(
                                          action.label,
                                          style: GoogleFonts.inter(
                                            fontSize: 13,
                                            fontWeight: FontWeight.w500,
                                            color: isActive
                                                ? Colors.white
                                                : const Color(0xFF333333),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              )
                              .animate(
                                delay: Duration(
                                  milliseconds: 1000 + (index * 80),
                                ),
                              )
                              .fadeIn(duration: 300.ms)
                              .slideX(begin: -0.15, end: 0, duration: 300.ms);
                        },
                      ),
                    ),
                  ),
                ),

                // --- Recent Activity Header ---
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 30, 20, 12),
                    child: Text(
                      'Recent',
                      style: GoogleFonts.inter(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF111111),
                      ),
                    ).animate(delay: 1200.ms).fadeIn(duration: 300.ms),
                  ),
                ),

                // --- Recent Activity List ---
                homeState.recentActivities.isEmpty
                    ? SliverToBoxAdapter(
                        child: _buildEmptyState()
                            .animate(delay: 1400.ms)
                            .fadeIn(duration: 400.ms)
                            .slideY(begin: 0.15, end: 0, duration: 400.ms),
                      )
                    : SliverList(
                        delegate: SliverChildBuilderDelegate((context, index) {
                          final activity = homeState.recentActivities[index];
                          return Padding(
                            padding: const EdgeInsets.fromLTRB(20, 0, 20, 12),
                            child: _buildActivityCard(activity),
                          );
                        }, childCount: homeState.recentActivities.length),
                      ),

                // Bottom padding for floating mic
                SliverToBoxAdapter(
                  child: SizedBox(height: 100 + bottomPadding),
                ),
              ],
            ),

            // --- Floating Mic Button ---
            Positioned(
              bottom: 24 + bottomPadding,
              left: 0,
              right: 0,
              child: Center(
                child:
                    GestureDetector(
                          onTap: () {
                            HapticFeedback.mediumImpact();
                            VoiceOverlayController.showAndStartListening(
                              context,
                              ref,
                            );
                          },
                          child:
                              Container(
                                    width: 64,
                                    height: 64,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      gradient: const LinearGradient(
                                        colors: [
                                          Color(0xFFF58220),
                                          Color(0xFFF7A94B),
                                        ],
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          color: const Color(
                                            0xFFF58220,
                                          ).withValues(alpha: 0.3),
                                          blurRadius: 20,
                                          spreadRadius: 2,
                                          offset: const Offset(0, 6),
                                        ),
                                      ],
                                    ),
                                    child: const Icon(
                                      Icons.mic,
                                      color: Colors.white,
                                      size: 28,
                                    ),
                                  )
                                  .animate(
                                    onPlay: (c) => c.repeat(reverse: true),
                                  )
                                  .custom(
                                    duration: 2000.ms,
                                    curve: Curves.easeInOut,
                                    builder: (context, value, child) {
                                      return Container(
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          boxShadow: [
                                            BoxShadow(
                                              color: const Color(0xFFF58220)
                                                  .withValues(
                                                    alpha:
                                                        0.15 + (0.12 * value),
                                                  ),
                                              blurRadius: 16 + (8 * value),
                                              spreadRadius: 2 + (4 * value),
                                            ),
                                          ],
                                        ),
                                        child: child,
                                      );
                                    },
                                  ),
                        )
                        .animate(delay: 1400.ms)
                        .fadeIn(duration: 500.ms)
                        .slideY(
                          begin: 1.0,
                          end: 0,
                          duration: 500.ms,
                          curve: Curves.easeOutBack,
                        ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(32),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.8),
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
          children: [
            Container(
              width: 56,
              height: 56,
              decoration: const BoxDecoration(
                color: Color(0xFFF5F5F5),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.history_rounded,
                color: Color(0xFFB0B0B0),
                size: 28,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'No activity yet',
              style: GoogleFonts.inter(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF111111),
              ),
            ),
            const SizedBox(height: 6),
            Text(
              'Start by speaking or tapping a quick action!',
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                fontSize: 14,
                color: const Color(0xFF999999),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActivityCard(RecentActivity activity) {
    Color statusColor;
    String statusLabel;
    switch (activity.status) {
      case 'completed':
        statusColor = const Color(0xFF22C55E);
        statusLabel = 'Done';
        break;
      case 'in_progress':
        statusColor = const Color(0xFFF58220);
        statusLabel = 'In Progress';
        break;
      case 'failed':
        statusColor = const Color(0xFFEF4444);
        statusLabel = 'Failed';
        break;
      default:
        statusColor = const Color(0xFF999999);
        statusLabel = activity.status;
    }

    return GestureDetector(
      onTap: () {
        HapticFeedback.selectionClick();
        // TODO: Navigate to activity detail / continue task
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.85),
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
        child: Row(
          children: [
            // Icon
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: const Color(0xFFFFF5EC),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                _getActivityIcon(activity.iconName),
                color: const Color(0xFFF58220),
                size: 22,
              ),
            ),
            const SizedBox(width: 14),
            // Title + Subtitle
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    activity.title,
                    style: GoogleFonts.inter(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF111111),
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    activity.subtitle,
                    style: GoogleFonts.inter(
                      fontSize: 13,
                      color: const Color(0xFF999999),
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            // Status + Time
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 3,
                  ),
                  decoration: BoxDecoration(
                    color: statusColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    statusLabel,
                    style: GoogleFonts.inter(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: statusColor,
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  activity.timestamp,
                  style: GoogleFonts.inter(
                    fontSize: 11,
                    color: const Color(0xFFB0B0B0),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  IconData _getActivityIcon(String iconName) {
    switch (iconName) {
      case 'aadhaar':
        return Icons.credit_card_rounded;
      case 'bill':
        return Icons.receipt_long_rounded;
      case 'kisan':
        return Icons.agriculture_rounded;
      case 'ration':
        return Icons.store_rounded;
      case 'health':
        return Icons.local_hospital_rounded;
      case 'shopping':
        return Icons.shopping_bag_rounded;
      default:
        return Icons.task_alt_rounded;
    }
  }

  void _showLanguageDialog(BuildContext context, WidgetRef ref) {
    final languages = [
      {'name': 'Hindi', 'code': 'HI', 'native': 'हिन्दी'},
      {'name': 'English', 'code': 'EN', 'native': 'English'},
      {'name': 'Bengali', 'code': 'BN', 'native': 'বাংলা'},
      {'name': 'Tamil', 'code': 'TA', 'native': 'தமிழ்'},
      {'name': 'Telugu', 'code': 'TE', 'native': 'తెలుగు'},
      {'name': 'Marathi', 'code': 'MR', 'native': 'मराठी'},
      {'name': 'Gujarati', 'code': 'GU', 'native': 'ગુજરાતી'},
      {'name': 'Kannada', 'code': 'KN', 'native': 'ಕನ್ನಡ'},
      {'name': 'Odia', 'code': 'OR', 'native': 'ଓଡ଼ିଆ'},
      {'name': 'Punjabi', 'code': 'PA', 'native': 'ਪੰਜਾਬੀ'},
    ];

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        final currentLang = ref.read(homeProvider).languageCode;
        return DraggableScrollableSheet(
          initialChildSize: 0.6,
          maxChildSize: 0.85,
          minChildSize: 0.4,
          expand: false,
          builder: (context, scrollController) {
            return Padding(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Handle bar
                  Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: const Color(0xFFDDDDDD),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Choose Language',
                    style: GoogleFonts.inter(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF111111),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Expanded(
                    child: ListView.builder(
                      controller: scrollController,
                      itemCount: languages.length,
                      itemBuilder: (context, index) {
                        final lang = languages[index];
                        final isSelected = currentLang == lang['code'];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 4),
                          child: ListTile(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            tileColor: isSelected
                                ? const Color(0xFFFFF5EC)
                                : Colors.transparent,
                            leading: Text(
                              lang['native']!,
                              style: GoogleFonts.inter(
                                fontSize: 16,
                                color: isSelected
                                    ? const Color(0xFFF58220)
                                    : const Color(0xFF666666),
                              ),
                            ),
                            title: Text(
                              lang['name']!,
                              style: GoogleFonts.inter(
                                fontSize: 15,
                                fontWeight: isSelected
                                    ? FontWeight.w600
                                    : FontWeight.w400,
                                color: const Color(0xFF111111),
                              ),
                            ),
                            trailing: isSelected
                                ? const Icon(
                                    Icons.check_circle,
                                    color: Color(0xFFF58220),
                                    size: 20,
                                  )
                                : null,
                            onTap: () {
                              ref
                                  .read(homeProvider.notifier)
                                  .setLanguage(lang['name']!, lang['code']!);
                              Navigator.pop(context);
                            },
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
