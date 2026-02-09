import 'package:supabase_flutter/supabase_flutter.dart';
import '../../core/config/supabase_config.dart';

class SupabaseService {
  // Singleton instance
  static final SupabaseService _instance = SupabaseService._internal();

  factory SupabaseService() {
    return _instance;
  }

  SupabaseService._internal();

  /// Initialize Supabase
  Future<void> initialize() async {
    try {
      if (SupabaseConfig.url.isEmpty || SupabaseConfig.anonKey.isEmpty) {
        throw Exception('Supabase URL or Anon Key is missing in .env');
      }

      await Supabase.initialize(
        url: SupabaseConfig.url,
        anonKey: SupabaseConfig.anonKey,
      );
    } catch (e) {
      // Log the error or handle it as needed
      rethrow;
    }
  }

  /// Get Supabase client instance
  SupabaseClient get client => Supabase.instance.client;
}
