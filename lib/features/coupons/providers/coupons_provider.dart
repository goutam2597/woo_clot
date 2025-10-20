import 'package:flutter/foundation.dart';
import 'package:flutter_woocommerce/app/app_config.dart';
import 'package:flutter_woocommerce/features/coupons/data/models/coupon_model.dart';

class CouponsProvider extends ChangeNotifier {
  final List<CouponModel> _available = [];
  final List<CouponModel> _saved = [];

  List<CouponModel> get available => List.unmodifiable(_available);
  List<CouponModel> get saved => List.unmodifiable(_saved);

  void seedDummy() {
    if (_available.isNotEmpty) return;
    if (!AppConfig.useDummyData) return;
    _available.addAll([
      const CouponModel(
        code: 'SAVE10',
        title: 'Save 10% on orders over \$50',
        type: CouponType.percent,
        amount: 10,
      ),
      const CouponModel(
        code: 'FREESHIP',
        title: 'Free shipping on all items',
        type: CouponType.freeShipping,
        amount: 0,
      ),
      const CouponModel(
        code: 'WELCOME15',
        title: '15% off for new users',
        type: CouponType.percent,
        amount: 15,
      ),
      const CouponModel(
        code: 'FLAT5',
        title: 'Flat \$5 off',
        type: CouponType.fixed,
        amount: 5,
      ),
    ]);
  }

  void save(CouponModel c) {
    if (_saved.any((e) => e.code == c.code)) return;
    _saved.add(c);
    notifyListeners();
  }

  void unsave(String code) {
    _saved.removeWhere((e) => e.code == code);
    notifyListeners();
  }

  bool isSaved(String code) => _saved.any((e) => e.code == code);

  CouponModel? findByCode(String code) {
    try {
      return _available.firstWhere((e) => e.code.toUpperCase() == code.toUpperCase());
    } catch (_) {
      try {
        return _saved.firstWhere((e) => e.code.toUpperCase() == code.toUpperCase());
      } catch (_) {
        return null;
      }
    }
  }
}

