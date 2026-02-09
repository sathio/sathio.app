import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:dio/dio.dart';
import '../../../core/constants/asset_paths.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/spacing.dart';
import '../../../core/utils/extensions.dart';
import '../onboarding_provider.dart';

class QuickWinScreen extends ConsumerStatefulWidget {
  const QuickWinScreen({super.key});

  @override
  ConsumerState<QuickWinScreen> createState() => _QuickWinScreenState();
}

class _QuickWinScreenState extends ConsumerState<QuickWinScreen> {
  bool _isLoading = false;
  bool _isCompleted = false;
  String _weatherResult = "";
  final Dio _dio = Dio();

  void _performTask() async {
    setState(() {
      _isLoading = true;
    });

    try {
      // 1. Check/Request Location Permission
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          throw Exception("Location permission denied");
        }
      }
      if (permission == LocationPermission.deniedForever) {
        throw Exception("Turn on location in settings");
      }

      // 2. Get Current Position
      final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.medium,
      );

      // 3. Get City Name (Reverse Geocoding)
      String cityName = "Aapke shehar";
      try {
        List<Placemark> placemarks = await placemarkFromCoordinates(
          position.latitude,
          position.longitude,
        );
        if (placemarks.isNotEmpty) {
          cityName =
              placemarks.first.locality ??
              placemarks.first.subAdministrativeArea ??
              "India";
        }
      } catch (e) {
        debugPrint("Geocoding Error: $e");
      }

      // 4. Fetch Weather (OpenMeteo)
      final response = await _dio.get(
        'https://api.open-meteo.com/v1/forecast',
        queryParameters: {
          'latitude': position.latitude,
          'longitude': position.longitude,
          'current': 'temperature_2m',
        },
      );

      if (response.statusCode == 200) {
        final temp = response.data['current']['temperature_2m'];
        final tempInt = (temp as num).round();

        if (mounted) {
          setState(() {
            _weatherResult = "$cityName mein $tempInt°C hai ☀️";
            _isLoading = false;
            _isCompleted = true;
          });
        }
      } else {
        throw Exception("Weather data unavailable");
      }
    } catch (e) {
      debugPrint("Error fetching weather: $e");
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              "Error: ${e.toString().replaceAll('Exception: ', '')}",
            ),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colorScheme.surface,
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(AppSpacing.lg),
              child: Column(
                children: [
                  const SizedBox(height: AppSpacing.xl),

                  // Header
                  Text(
                    'Chalo ek choti si\nmadad karte hain!',
                    style: context.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimaryLight,
                    ),
                    textAlign: TextAlign.center,
                  ).animate().fadeIn().slideY(begin: -0.2, end: 0),

                  const SizedBox(height: AppSpacing.md),

                  Text(
                    'See how easy it is to use Sathio',
                    style: context.textTheme.bodyMedium?.copyWith(
                      color: AppColors.textSecondaryLight,
                    ),
                    textAlign: TextAlign.center,
                  ).animate().fadeIn(delay: 200.ms),

                  const Spacer(),

                  // Task Card
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 500),
                    child: _isCompleted ? _buildResultCard() : _buildTaskCard(),
                  ),

                  const Spacer(),

                  // Footer Button
                  AnimatedOpacity(
                    opacity: _isCompleted ? 1.0 : 0.0,
                    duration: const Duration(milliseconds: 300),
                    child: SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: _isCompleted
                            ? () {
                                debugPrint("QuickWin Continue Pressed");
                                ref
                                    .read(onboardingProvider.notifier)
                                    .nextPage();
                              }
                            : null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          disabledBackgroundColor: AppColors.gray300,
                          elevation: 4,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text(
                          'AB ASLI KAAM SHURU KAREIN',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.0,
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: AppSpacing.lg),

                  // Progress Dots (6 of 7)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(7, (index) {
                      final isActive = index == 5; // 6th Screen
                      return AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        height: 8,
                        width: isActive ? 24 : 8,
                        decoration: BoxDecoration(
                          color: isActive
                              ? AppColors.primary
                              : AppColors.gray300,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      );
                    }),
                  ),
                  const SizedBox(height: AppSpacing.md),
                ],
              ),
            ),

            // Confetti Overlay
            if (_isCompleted)
              Positioned.fill(
                child: IgnorePointer(
                  child: Lottie.asset(
                    AssetPaths.successAnim,
                    repeat: false,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildTaskCard() {
    return GestureDetector(
      onTap: _isLoading ? null : _performTask,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withValues(alpha: 0.1),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
          border: Border.all(color: AppColors.gray200),
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.orange.shade50,
                shape: BoxShape.circle,
              ),
              child: const Text('☀️', style: TextStyle(fontSize: 40)),
            ),
            const SizedBox(height: 16),
            Text(
              'Aaj ka mausam jaano',
              style: context.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimaryLight,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Tap to check weather',
              style: context.textTheme.bodyMedium?.copyWith(
                color: AppColors.textSecondaryLight,
              ),
            ),
            const SizedBox(height: 24),
            if (_isLoading)
              const CircularProgressIndicator(color: AppColors.primary)
            else
              Text(
                    'TAP HERE',
                    style: TextStyle(
                      color: AppColors.primary,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                    ),
                  )
                  .animate(onPlay: (c) => c.repeat())
                  .shimmer(duration: 2.seconds, color: AppColors.primary),
          ],
        ),
      ),
    );
  }

  Widget _buildResultCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFFF0FDF4), // Light green bg
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.green.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.green.withValues(alpha: 0.1),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        children: [
          const Icon(Icons.check_circle, size: 60, color: Colors.green),
          const SizedBox(height: 16),
          Text(
            _weatherResult, // Real result
            style: context.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.green.shade800,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            'Dekha! Kitna aasan tha!',
            style: context.textTheme.titleMedium?.copyWith(
              color: Colors.green.shade600,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    ).animate().scale(curve: Curves.elasticOut, duration: 600.ms);
  }
}
