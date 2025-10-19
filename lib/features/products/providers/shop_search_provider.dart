import 'package:flutter/foundation.dart';

class ShopSearchProvider extends ChangeNotifier {
  String _query = '';

  String get query => _query;

  void setQuery(String value) {
    final v = value.trim();
    if (_query == v) return;
    _query = v;
    notifyListeners();
  }

  void clear() {
    setQuery('');
  }
}

