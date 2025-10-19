import 'package:flutter/foundation.dart';

class BottomNavController extends ChangeNotifier {
  int _index = 0;

  int get index => _index;

  void goTo(int i) {
    if (i == _index) return;
    _index = i;
    notifyListeners();
  }
}

