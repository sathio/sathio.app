import 'package:supabase_flutter/supabase_flutter.dart';
import '../../core/config/supabase_config.dart';

class SupabaseService {
  // Singleton instance
  static final SupabaseService _instance = SupabaseService._internal();

  factory SupabaseService() {
    return _instance;
  }

  SupabaseService._internal();

  /// Initialize Supabase with configuration from environment variables
  Future<void> initialize() async {
    try {
      await Supabase.initialize(
        url: SupabaseConfig.url,
        anonKey: SupabaseConfig.anonKey,
      );
    } catch (e) {
      // Re-throw to be handled by the main app runner
      throw Exception('Failed to initialize Supabase: $e');
    }
  }

  /// Get the Supabase client instance
  SupabaseClient get client => Supabase.instance.client;
}
