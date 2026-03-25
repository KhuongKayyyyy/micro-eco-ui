import 'package:ecommerce_app/model/faq_model.dart';

class FaqService {
  static List<FaqModel> _filterByType(String type) {
    if (type == 'all') return faqs;
    return faqs.where((faq) => faq.type == type).toList();
  }

  static Future<List<FaqModel>> getFaqs(int page, int limit) async {
    await Future.delayed(const Duration(seconds: 2));
    return faqs.skip((page - 1) * limit).take(limit).toList();
  }

  static Future<List<FaqModel>> getFaqsByType(
    String type,
    int page,
    int limit,
  ) async {
    await Future.delayed(const Duration(seconds: 2));
    final filtered = _filterByType(type);
    return filtered.skip((page - 1) * limit).take(limit).toList();
  }

  static Future<List<FaqModel>> searchFaqs(String query) async {
    await Future.delayed(const Duration(seconds: 2));
    return faqs.where((faq) => faq.question.contains(query)).toList();
  }

  static Future<List<FaqModel>> searchFaqsByType(
    String query,
    String type,
  ) async {
    await Future.delayed(const Duration(seconds: 2));
    final filtered = _filterByType(type);
    return filtered
        .where((faq) => faq.question.contains(query))
        .toList();
  }
}
