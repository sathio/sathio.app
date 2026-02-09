import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'services/supabase/supabase_service.dart';
import 'core/router/app_router.dart';
import 'core/theme/app_theme.dart';
import 'core/constants/app_constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    // Load environment variables
    await dotenv.load(
      fileName: ".env",
    ); // Note: .env file must be added to assets in pubspec.yaml

    // Initialize Hive
    await Hive.initFlutter();

    // Initialize Supabase
    await SupabaseService().initialize();
  } catch (e) {
    debugPrint("Initialization Error: \$e");
  }

  runApp(const ProviderScope(child: SathioApp()));
}

class SathioApp extends ConsumerWidget {
  const SathioApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(appRouterProvider);

    return MaterialApp.router(
      title: AppConstants.appName,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      routerConfig: router,
    );
  }
}
