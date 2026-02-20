import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

/// Manages offline content (FAQs, Scheme info) stored in Hive.
/// Content is organized by language code.
class OfflineContentManager {
  static const String _boxPrefix = 'offline_content_';

  // ── Hive Box Management ─────────────────────────────────────────────────

  Future<Box> _getBox(String langCode) async {
    final boxName = '$_boxPrefix$langCode';
    if (!Hive.isBoxOpen(boxName)) {
      return await Hive.openBox(boxName);
    }
    return Hive.box(boxName);
  }

  // ── Seed Data (For MVP - normally this would download from server) ──────

  Future<void> seedInitialData() async {
    // Check if Hindi box is empty, if so, seed it
    final hiBox = await _getBox('hi');
    if (hiBox.isEmpty) {
      debugPrint('OfflineContentManager: Seeding initial Hindi content...');
      await hiBox.putAll({
        'faq_pm_kisan': {
          'question': 'PM Kisan ke paise kab aayenge?',
          'answer':
              'PM Kisan ki agli kisht agle mahine ki 15 tarikh tak aane ki ummeed hai. Aap status check kar sakte hain.',
          'type': 'faq',
        },
        'faq_ration_card': {
          'question': 'Ration card mein naam kaise jodein?',
          'answer':
              'Ration card mein naam joodne ke liye aapko apne nazdiki CSC center jana hoga ya food department ki website par online apply karna hoga. Aadhar card zaroori hai.',
          'type': 'faq',
        },
        'emergency_ambulance': {
          'title': 'Ambulance',
          'number': '108',
          'type': 'emergency',
        },
        'emergency_police': {
          'title': 'Police',
          'number': '100',
          'type': 'emergency',
        },
      });
    }

    // Seed English
    final enBox = await _getBox('en');
    if (enBox.isEmpty) {
      await enBox.putAll({
        'faq_pm_kisan': {
          'question': 'When will PM Kisan money come?',
          'answer':
              'The next installment of PM Kisan is expected by the 15th of next month. You can check the status.',
          'type': 'faq',
        },
        'faq_ration_card': {
          'question': 'How to add name in Ration card?',
          'answer':
              'To add a name to the ration card, visit your nearest CSC center or apply online on the food department website. Aadhar card is mandatory.',
          'type': 'faq',
        },
      });
    }
  }

  // ── Retrieval Methods ───────────────────────────────────────────────────

  /// Get all FAQs for a given language.
  Future<List<Map<String, dynamic>>> getFaqs(String langCode) async {
    final box = await _getBox(langCode);
    final faqs = <Map<String, dynamic>>[];

    for (var key in box.keys) {
      final value = box.get(key);
      if (value is Map && value['type'] == 'faq') {
        faqs.add(Map<String, dynamic>.from(value));
      }
    }
    return faqs;
  }

  /// Get all emergency numbers for a language.
  Future<List<Map<String, dynamic>>> getEmergencyNumbers(
    String langCode,
  ) async {
    final box = await _getBox(langCode);
    final numbers = <Map<String, dynamic>>[];

    for (var key in box.keys) {
      final value = box.get(key);
      if (value is Map && value['type'] == 'emergency') {
        numbers.add(Map<String, dynamic>.from(value));
      }
    }
    return numbers;
  }
}

final offlineContentProvider = Provider<OfflineContentManager>((ref) {
  return OfflineContentManager();
});
