import 'dart:collection';
import 'package:flutter/foundation.dart';
import 'package:flutter_woocommerce/features/profile/data/models/payment_method_model.dart';

class PaymentMethodsProvider extends ChangeNotifier {
  UnmodifiableListView<PaymentMethodModel> get items =>
      UnmodifiableListView(methods);

  void add(PaymentMethodModel method) {
    methods.add(method);
    notifyListeners();
  }

  void update(PaymentMethodModel method) {
    final idx = methods.indexWhere((m) => m.id == method.id);
    if (idx != -1) {
      methods[idx] = method;
      notifyListeners();
    }
  }

  void remove(String id) {
    methods.removeWhere((m) => m.id == id);
    notifyListeners();
  }
}
