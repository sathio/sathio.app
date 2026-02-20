import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

// --- State ---
class HomeState {
  final String userName;
  final String greeting;
  final String language;
  final String languageCode;
  final List<QuickAction> quickActions;
  final List<RecentActivity> recentActivities;

  const HomeState({
    this.userName = 'User',
    this.greeting = 'Hello',
    this.language = 'Hindi',
    this.languageCode = 'HI',
    this.quickActions = const [],
    this.recentActivities = const [],
  });

  HomeState copyWith({
    String? userName,
    String? greeting,
    String? language,
    String? languageCode,
    List<QuickAction>? quickActions,
    List<RecentActivity>? recentActivities,
  }) {
    return HomeState(
      userName: userName ?? this.userName,
      greeting: greeting ?? this.greeting,
      language: language ?? this.language,
      languageCode: languageCode ?? this.languageCode,
      quickActions: quickActions ?? this.quickActions,
      recentActivities: recentActivities ?? this.recentActivities,
    );
  }
}

class QuickAction {
  final String id;
  final String label;
  final String emoji;

  const QuickAction({
    required this.id,
    required this.label,
    required this.emoji,
  });
}

class RecentActivity {
  final String id;
  final String title;
  final String subtitle;
  final String iconName;
  final String timestamp;
  final String status; // 'completed', 'in_progress', 'failed'

  const RecentActivity({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.iconName,
    required this.timestamp,
    required this.status,
  });
}

// --- Notifier ---
class HomeNotifier extends Notifier<HomeState> {
  @override
  HomeState build() {
    _loadUserData();
    return HomeState(
      greeting: _getTimeBasedGreeting(),
      quickActions: _getDefaultQuickActions(),
    );
  }

  String _getTimeBasedGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 5) return 'Good Night';
    if (hour < 12) return 'Good Morning';
    if (hour < 17) return 'Good Afternoon';
    return 'Good Evening';
  }

  List<QuickAction> _getDefaultQuickActions() {
    return const [
      QuickAction(id: 'services', label: 'Sarkari Seva', emoji: '🏛️'),
      QuickAction(id: 'aadhaar', label: 'Aadhaar', emoji: '🆔'),
      QuickAction(id: 'bill_pay', label: 'Bill Pay', emoji: '💳'),
      QuickAction(id: 'pm_kisan', label: 'PM-Kisan', emoji: '🌾'),
      QuickAction(id: 'ration', label: 'Ration Card', emoji: '🏪'),
      QuickAction(id: 'health', label: 'Health', emoji: '🏥'),
      QuickAction(id: 'shopping', label: 'Shopping', emoji: '🛒'),
    ];
  }

  Future<void> _loadUserData() async {
    try {
      final box = await Hive.openBox('onboarding_box');
      final name = box.get('name', defaultValue: 'User') as String;

      final settingsBox = await Hive.openBox('settings');
      final lang = settingsBox.get('language', defaultValue: 'Hindi') as String;
      final langCode =
          settingsBox.get('language_code', defaultValue: 'HI') as String;
      final interests =
          settingsBox.get('user_interests', defaultValue: <dynamic>[])
              as List<dynamic>;

      // Personalize quick actions based on interests
      List<QuickAction> actions = _getDefaultQuickActions();
      if (interests.isNotEmpty) {
        // Re-order: put interest-matching actions first
        final interestSet = interests
            .map((e) => e.toString().toLowerCase())
            .toSet();
        actions.sort((a, b) {
          final aMatch = interestSet.contains(a.label.toLowerCase()) ? 0 : 1;
          final bMatch = interestSet.contains(b.label.toLowerCase()) ? 0 : 1;
          return aMatch.compareTo(bMatch);
        });
      }

      state = state.copyWith(
        userName: name,
        language: lang,
        languageCode: langCode,
        quickActions: actions,
        greeting: _getTimeBasedGreeting(),
      );
    } catch (e) {
      // If Hive fails, keep defaults
    }
  }

  void setLanguage(String language, String languageCode) async {
    state = state.copyWith(language: language, languageCode: languageCode);
    final box = await Hive.openBox('settings');
    await box.put('language', language);
    await box.put('language_code', languageCode);
  }

  void addRecentActivity(RecentActivity activity) {
    final activities = [activity, ...state.recentActivities];
    state = state.copyWith(recentActivities: activities.take(20).toList());
  }

  void refreshGreeting() {
    state = state.copyWith(greeting: _getTimeBasedGreeting());
  }
}

// --- Provider ---
final homeProvider = NotifierProvider<HomeNotifier, HomeState>(
  HomeNotifier.new,
);
