import 'package:flutter/foundation.dart';

class ShopSearchProvider extends ChangeNotifier {
  String _query = '';
  String? _category; // selected category filter (by title)

  String get query => _query;
  String? get category => _category;

  void setQuery(String value) {
    final v = value.trim();
    if (_query == v) return;
    _query = v;
    notifyListeners();
  }

  void setCategory(String? value) {
    final v = value?.trim();
    if (_category == v) return;
    _category = (v == null || v.isEmpty) ? null : v;
    notifyListeners();
  }

  void clearCategory() => setCategory(null);

  void clear() {
    setQuery('');
    // keep category as-is when clearing query only
  }

  void resetAll() {
    _query = '';
    _category = null;
    notifyListeners();
  }
}

