import 'dart:collection';
import 'package:flutter/foundation.dart';

enum PaymentType { visa, mastercard, paypal }

class PaymentMethodModel {
  final String id;
  PaymentType type;
  String label; // e.g., Visa, PayPal
  String details; // e.g., **** 4242 or email

  PaymentMethodModel({
    required this.id,
    required this.type,
    required this.label,
    required this.details,
  });
}

class PaymentMethodsController extends ChangeNotifier {
  final List<PaymentMethodModel> _methods = [
    PaymentMethodModel(id: 'pm_1', type: PaymentType.visa, label: 'Visa', details: '**** **** **** 4242'),
    PaymentMethodModel(id: 'pm_2', type: PaymentType.mastercard, label: 'Mastercard', details: '**** **** **** 5587'),
    PaymentMethodModel(id: 'pm_3', type: PaymentType.paypal, label: 'PayPal', details: 'john.doe@example.com'),
  ];

  UnmodifiableListView<PaymentMethodModel> get items => UnmodifiableListView(_methods);

  void add(PaymentMethodModel method) {
    _methods.add(method);
    notifyListeners();
  }

  void update(PaymentMethodModel method) {
    final idx = _methods.indexWhere((m) => m.id == method.id);
    if (idx != -1) {
      _methods[idx] = method;
      notifyListeners();
    }
  }

  void remove(String id) {
    _methods.removeWhere((m) => m.id == id);
    notifyListeners();
  }
}

