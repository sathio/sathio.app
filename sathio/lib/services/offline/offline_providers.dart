import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'offline_content_manager.dart';
import 'offline_query_handler.dart';

final offlineContentManagerProvider = Provider<OfflineContentManager>((ref) {
  return OfflineContentManager();
});

final offlineQueryHandlerProvider = Provider<OfflineQueryHandler>((ref) {
  final contentManager = ref.watch(offlineContentManagerProvider);
  return OfflineQueryHandler(contentManager);
});

// Seed data on app start
final offlineInitializerProvider = FutureProvider<void>((ref) async {
  final manager = ref.watch(offlineContentManagerProvider);
  await manager.seedInitialData();
});
