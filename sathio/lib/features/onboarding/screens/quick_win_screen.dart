import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:dio/dio.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/constants/asset_paths.dart';
import '../../../core/theme/app_colors.dart';
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

      final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.medium,
      );

      String cityName = "Your city";
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
            _weatherResult = "It is $tempInt°C in $cityName ☀️";
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
                    children: [
                      Text(
                        'Magic',
                        style: GoogleFonts.poppins(
                          fontSize: 64,
                          height: 1.0,
                          fontWeight: FontWeight.w900,
                          color: const Color(0xFFFBF4E2),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Let\'s do a small task!',
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Colors.white.withOpacity(0.9),
                        ),
                        textAlign: TextAlign.center,
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
                fit: StackFit.expand,
                children: [
                  // Main content centered
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          AnimatedSwitcher(
                            duration: const Duration(milliseconds: 500),
                            child: _isCompleted
                                ? _buildResultCard()
                                : _buildTaskCard(),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // FAB — bottom right (only when completed)
                  if (_isCompleted)
                    Positioned(
                      bottom: 30,
                      right: 30,
                      child:
                          GestureDetector(
                            onTap: () {
                              ref.read(onboardingProvider.notifier).nextPage();
                            },
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
                          ).animate().scale(
                            duration: 300.ms,
                            curve: Curves.easeOutBack,
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
          ),
        ],
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
          borderRadius: BorderRadius.circular(32),
          boxShadow: [
            BoxShadow(
              color: AppColors.orange.withOpacity(0.1),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
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
              'Check today\'s weather',
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColors.orange,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Tap to check weather',
              style: GoogleFonts.poppins(fontSize: 14, color: Colors.black54),
            ),
            const SizedBox(height: 24),
            if (_isLoading)
              const CircularProgressIndicator(color: AppColors.orange)
            else
              Text(
                    'TAP HERE',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      color: AppColors.orange,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 1.2,
                    ),
                  )
                  .animate(onPlay: (c) => c.repeat())
                  .shimmer(duration: 2.seconds, color: AppColors.orange),
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
        color: const Color(0xFFF0FDF4),
        borderRadius: BorderRadius.circular(32),
        border: Border.all(color: Colors.green.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.green.withOpacity(0.1),
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
            _weatherResult,
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.green.shade800,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            'See! How easy it was!',
            style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.green.shade600,
            ),
          ),
        ],
      ),
    ).animate().scale(curve: Curves.elasticOut, duration: 600.ms);
  }
}
