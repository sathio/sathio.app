import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'features/onboarding/screens/splash_screen.dart';
import 'services/supabase/supabase_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Load environment variables
  try {
    await dotenv.load(fileName: ".env");
  } catch (e) {
    debugPrint(
      "Warning: .env file not found. Using default/empty environment.",
    );
    // In production, you might want to crash or show a specific error screen
    // if critical env vars are missing.
  }

  // Initialize Hive
  await Hive.initFlutter();

  // Initialize Supabase
  try {
    await SupabaseService().initialize();
  } catch (e) {
    debugPrint("Supabase Initialization Error: $e");
    // Handle initialization error appropriately (e.g., show error screen)
  }

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sathio',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF008080),
        ), // Teal as seed
        useMaterial3: true,
        textTheme: GoogleFonts.interTextTheme(),
      ),
      home: const SplashScreen(),
    );
  }
}
