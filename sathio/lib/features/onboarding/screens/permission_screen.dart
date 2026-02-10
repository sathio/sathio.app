import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/theme/app_colors.dart';
import '../onboarding_provider.dart';

class PermissionScreen extends ConsumerStatefulWidget {
  const PermissionScreen({super.key});

  @override
  ConsumerState<PermissionScreen> createState() => _PermissionScreenState();
}

class _PermissionScreenState extends ConsumerState<PermissionScreen>
    with WidgetsBindingObserver {
  PermissionStatus _micStatus = PermissionStatus.denied;
  PermissionStatus _notificationStatus = PermissionStatus.denied;
  PermissionStatus _locationStatus = PermissionStatus.denied;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _checkPermissions();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _checkPermissions();
    }
  }

  Future<void> _checkPermissions() async {
    final mic = await Permission.microphone.status;
    final notif = await Permission.notification.status;
    final loc = await Permission.location.status;

    if (mounted) {
      setState(() {
        _micStatus = mic;
        _notificationStatus = notif;
        _locationStatus = loc;
      });
    }
  }

  Future<void> _requestPermission(Permission permission, String type) async {
    final status = await permission.request();
    if (mounted) {
      setState(() {
        if (type == 'mic') _micStatus = status;
        if (type == 'notif') _notificationStatus = status;
        if (type == 'loc') _locationStatus = status;
      });
    }

    if (status.isPermanentlyDenied) {
      // openAppSettings(); // Optional
    }
  }

  @override
  Widget build(BuildContext context) {
    final canContinue = _micStatus.isGranted || _micStatus.isLimited;

    return Scaffold(
      backgroundColor: AppColors.orange,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Top 30%: Orange header
          Expanded(
            flex: 3,
            child: SafeArea(
              bottom: false,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Permissions',
                        style: GoogleFonts.poppins(
                          fontSize: 48,
                          height: 1.0,
                          fontWeight: FontWeight.w900,
                          color: const Color(0xFFFBF4E2),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'To give you the best experience',
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          color: Colors.white.withOpacity(0.9),
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // Bottom 70%: Cream panel
          Expanded(
            flex: 7,
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Color(0xFFFBF4E2),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
              ),
              child: Stack(
                children: [
                  // Permission cards
                  ListView(
                    padding: const EdgeInsets.fromLTRB(24, 30, 24, 100),
                    children: [
                      Text(
                        'Permissions needed',
                        style: GoogleFonts.poppins(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFFD95D39),
                        ),
                      ),
                      const SizedBox(height: 24),
                      _buildPermissionCard(
                        icon: Icons.mic,
                        title: 'Microphone',
                        subtitle: 'To hear your voice',
                        status: _micStatus,
                        isRequired: true,
                        onTap: () =>
                            _requestPermission(Permission.microphone, 'mic'),
                        delay: 300,
                      ),
                      const SizedBox(height: 16),
                      _buildPermissionCard(
                        icon: Icons.notifications_active,
                        title: 'Notifications',
                        subtitle: 'For important updates',
                        status: _notificationStatus,
                        isRequired: false,
                        onTap: () => _requestPermission(
                          Permission.notification,
                          'notif',
                        ),
                        delay: 400,
                      ),
                      const SizedBox(height: 16),
                      _buildPermissionCard(
                        icon: Icons.location_on,
                        title: 'Location',
                        subtitle: 'To show schemes from your state',
                        status: _locationStatus,
                        isRequired: false,
                        onTap: () =>
                            _requestPermission(Permission.location, 'loc'),
                        delay: 500,
                      ),
                    ],
                  ),

                  // FAB — bottom right
                  Positioned(
                    bottom: 30,
                    right: 30,
                    child: AnimatedOpacity(
                      duration: const Duration(milliseconds: 300),
                      opacity: canContinue ? 1.0 : 0.0,
                      child: GestureDetector(
                        onTap: canContinue
                            ? () {
                                ref
                                    .read(onboardingProvider.notifier)
                                    .nextPage();
                              }
                            : null,
                        child: Container(
                          width: 64,
                          height: 64,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: const Icon(
                            Icons.arrow_forward,
                            color: Colors.black,
                            size: 28,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPermissionCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required PermissionStatus status,
    required bool isRequired,
    required VoidCallback onTap,
    required int delay,
  }) {
    final isGranted = status.isGranted || status.isLimited;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isGranted ? AppColors.orange : Colors.transparent,
          width: isGranted ? 2 : 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            offset: const Offset(0, 4),
            blurRadius: 10,
          ),
        ],
      ),
      child: Row(
        children: [
          // Icon
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppColors.orange.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: AppColors.orange, size: 24),
          ),
          const SizedBox(width: 16),

          // Text
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      title,
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.black87,
                      ),
                    ),
                    if (isRequired) ...[
                      const SizedBox(width: 6),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.orange.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          'Required',
                          style: GoogleFonts.poppins(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: AppColors.orange,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: GoogleFonts.poppins(
                    color: Colors.black54,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),

          // Action Button / Checkmark
          if (isGranted)
            Container(
              padding: const EdgeInsets.all(8),
              decoration: const BoxDecoration(
                color: AppColors.orange,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.check, color: Colors.white, size: 16),
            ).animate().scale(curve: Curves.elasticOut)
          else
            GestureDetector(
              onTap: onTap,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: AppColors.orange.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  'ALLOW',
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                    color: AppColors.orange,
                  ),
                ),
              ),
            ),
        ],
      ),
    ).animate().fadeIn(delay: delay.ms).slideX(begin: 0.1, end: 0);
  }
}
