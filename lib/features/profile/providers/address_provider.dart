import 'dart:collection';
import 'package:flutter/foundation.dart';
import 'package:flutter_woocommerce/features/profile/data/models/address_model.dart'
    as am;

class AddressProvider extends ChangeNotifier {
  UnmodifiableListView<am.AddressModel> get items =>
      UnmodifiableListView(_addressList);
  final List<am.AddressModel> _addressList = [];

  void add(am.AddressModel address) {
    if (_addressList.isEmpty) address.isDefault = true;
    _addressList.add(address);
    notifyListeners();
  }

  void update(am.AddressModel updated) {
    final idx = _addressList.indexWhere((a) => a.id == updated.id);
    if (idx != -1) {
      final wasDefault = _addressList[idx].isDefault;
      _addressList[idx] = updated..isDefault = updated.isDefault || wasDefault;
      notifyListeners();
    }
  }

  void remove(String id) {
    final wasDefault = _addressList
        .firstWhere(
          (a) => a.id == id,
          orElse: () => am.AddressModel(
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
    _addressList.removeWhere((a) => a.id == id);
    if (wasDefault && _addressList.isNotEmpty) {
      _addressList[0].isDefault = true;
    }
    notifyListeners();
  }

  void setDefault(String id) {
    for (final a in _addressList) {
      a.isDefault = a.id == id;
    }
    notifyListeners();
  }

  void seedDummy() {
    if (_addressList.isNotEmpty) return;
    try {
      for (final a in am.items) {
        _addressList.add(
          am.AddressModel(
            id: a.id,
            name: a.name,
            line1: a.line1,
            city: a.city,
            state: a.state,
            zip: a.zip,
            phone: a.phone,
            isDefault: a.isDefault,
          ),
        );
      }
      notifyListeners();
    } catch (_) {}
  }
}
