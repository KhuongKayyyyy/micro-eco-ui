import 'package:diacritic/diacritic.dart';

/// Normalizes Vietnamese (and Latin) text for accent-insensitive substring search.
/// Example: `"can tho"` matches `"Cần Thơ"`, `"ha noi"` matches `"Hà Nội"`.
String normalizeVietnameseForSearch(String input) {
  var s = input.toLowerCase().trim();
  s = s.replaceAll(RegExp(r'\s+'), ' ');
  s = removeDiacritics(s);
  // Vietnamese đ / Đ are letters, not combining marks — strip stroke for matching "d".
  s = s.replaceAll(RegExp(r'đ'), 'd');
  return s;
}

/// True if [query] matches [text] after normalizing both.
bool matchesVietnameseSearch(String text, String query) {
  final q = query.trim();
  if (q.isEmpty) return true;
  final nText = normalizeVietnameseForSearch(text);
  final nQuery = normalizeVietnameseForSearch(q);
  return nText.contains(nQuery);
}
