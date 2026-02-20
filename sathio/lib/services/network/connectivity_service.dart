import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Monitors network connectivity status.
class ConnectivityService {
  final Connectivity _connectivity = Connectivity();
  final StreamController<bool> _controller = StreamController<bool>.broadcast();

  bool _isOnline = true; // Optimistic default

  ConnectivityService() {
    _init();
  }

  void _init() {
    // Listen for changes
    _connectivity.onConnectivityChanged.listen((results) {
      _updateStatus(results);
    });

    // Check initial status
    _connectivity.checkConnectivity().then(_updateStatus);
  }

  void _updateStatus(List<ConnectivityResult> results) {
    // If any result is mobile/wifi/ethernet, we're connected
    final isConnected = results.any(
      (result) =>
          result == ConnectivityResult.mobile ||
          result == ConnectivityResult.wifi ||
          result == ConnectivityResult.ethernet,
    );

    if (_isOnline != isConnected) {
      _isOnline = isConnected;
      _controller.add(isConnected);
      debugPrint('ConnectivityService: ${_isOnline ? "ONLINE" : "OFFLINE"}');
    }
  }

  /// Current connectivity status (synchronous).
  bool get isOnline => _isOnline;

  /// Stream of connectivity changes.
  Stream<bool> get onConnectivityChanged => _controller.stream;

  void dispose() {
    _controller.close();
  }
}

/// Provider for the ConnectivityService.
final connectivityServiceProvider = Provider<ConnectivityService>((ref) {
  final service = ConnectivityService();
  ref.onDispose(() => service.dispose());
  return service;
});

/// Stream provider for easy UI consumption (returns true if online).
final isOnlineProvider = StreamProvider<bool>((ref) {
  final service = ref.watch(connectivityServiceProvider);
  return service.onConnectivityChanged;
});
