import 'package:string_similarity/string_similarity.dart';
import 'offline_content_manager.dart';

/// Handles user queries when internet is offline.
/// Uses fuzzy matching to find answers in local Hive database.
class OfflineQueryHandler {
  final OfflineContentManager _contentManager;

  OfflineQueryHandler(this._contentManager);

  /// Process a query and return a best-match answer.
  /// Returns null if no good match found.
  Future<String?> handleQuery(String query, String langCode) async {
    // 1. Get all FAQs for language
    final faqs = await _contentManager.getFaqs(langCode);
    if (faqs.isEmpty) return null;

    // 2. Extract questions for matching
    final questions = faqs.map((f) => f['question'] as String).toList();

    // 3. Find best match using Dice coefficient (string_similarity package)
    final bestMatch = StringSimilarity.findBestMatch(query, questions);

    // 4. Check rating threshold (e.g., 0.4 for loose match, 0.6 for strict)
    if ((bestMatch.bestMatch.rating ?? 0) > 0.4) {
      final index = bestMatch.bestMatchIndex;
      return faqs[index]['answer'] as String;
    }

    // 5. Check for specific keywords (Emergency)
    if (query.toLowerCase().contains('ambulance') ||
        query.toLowerCase().contains('police') ||
        query.toLowerCase().contains('help')) {
      final numbers = await _contentManager.getEmergencyNumbers(langCode);
      if (numbers.isNotEmpty) {
        final buffer = StringBuffer();
        if (langCode == 'hi') {
          buffer.write('Emergency numbers yeh hain: ');
        } else {
          buffer.write('Here are emergency numbers: ');
        }

        for (var num in numbers) {
          buffer.write('${num['title']}: ${num['number']}. ');
        }
        return buffer.toString();
      }
    }

    return null;
  }
}
