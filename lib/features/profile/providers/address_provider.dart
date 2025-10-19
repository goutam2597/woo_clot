import 'dart:collection';
import 'package:flutter/foundation.dart';
import 'package:flutter_woocommerce/features/profile/data/models/address_model.dart';

class AddressProvider extends ChangeNotifier {
  UnmodifiableListView<AddressModel> get items =>
      UnmodifiableListView(_addressList);
  final List<AddressModel> _addressList = [];

  void add(AddressModel address) {
    if (items.isEmpty) address.isDefault = true;
    items.add(address);
    notifyListeners();
  }

  void update(AddressModel updated) {
    final idx = items.indexWhere((a) => a.id == updated.id);
    if (idx != -1) {
      final wasDefault = items[idx].isDefault;
      items[idx] = updated..isDefault = updated.isDefault || wasDefault;
      notifyListeners();
    }
  }

  void remove(String id) {
    final wasDefault = items
        .firstWhere(
          (a) => a.id == id,
          orElse: () => AddressModel(
            id: '',
            name: '',
            line1: '',
            city: '',
            state: '',
            zip: '',
            phone: '',
          ),
        )
        .isDefault;
    items.removeWhere((a) => a.id == id);
    if (wasDefault && items.isNotEmpty) {
      items[0].isDefault = true;
    }
    notifyListeners();
  }

  void setDefault(String id) {
    for (final a in items) {
      a.isDefault = a.id == id;
    }
    notifyListeners();
  }
}
