import 'dart:collection';
import 'package:flutter/foundation.dart';

class AddressModel {
  final String id;
  String name;
  String line1;
  String city;
  String state;
  String zip;
  String phone;
  bool isDefault;

  AddressModel({
    required this.id,
    required this.name,
    required this.line1,
    required this.city,
    required this.state,
    required this.zip,
    required this.phone,
    this.isDefault = false,
  });
}

class AddressController extends ChangeNotifier {
  final List<AddressModel> _items = [
    AddressModel(
      id: 'addr_home',
      name: 'Home',
      line1: '325 15th Eighth Avenue',
      city: 'New York',
      state: 'NY',
      zip: '10011',
      phone: '+1 212 555 7890',
      isDefault: true,
    ),
    AddressModel(
      id: 'addr_office',
      name: 'Office',
      line1: '71 5th Avenue',
      city: 'New York',
      state: 'NY',
      zip: '10003',
      phone: '+1 212 555 1011',
    ),
  ];

  UnmodifiableListView<AddressModel> get items => UnmodifiableListView(_items);

  void add(AddressModel address) {
    if (_items.isEmpty) address.isDefault = true;
    _items.add(address);
    notifyListeners();
  }

  void update(AddressModel updated) {
    final idx = _items.indexWhere((a) => a.id == updated.id);
    if (idx != -1) {
      final wasDefault = _items[idx].isDefault;
      _items[idx] = updated..isDefault = updated.isDefault || wasDefault;
      notifyListeners();
    }
  }

  void remove(String id) {
    final wasDefault = _items.firstWhere((a) => a.id == id, orElse: () => AddressModel(id: '', name: '', line1: '', city: '', state: '', zip: '', phone: '')).isDefault;
    _items.removeWhere((a) => a.id == id);
    if (wasDefault && _items.isNotEmpty) {
      _items[0].isDefault = true;
    }
    notifyListeners();
  }

  void setDefault(String id) {
    for (final a in _items) {
      a.isDefault = a.id == id;
    }
    notifyListeners();
  }
}

