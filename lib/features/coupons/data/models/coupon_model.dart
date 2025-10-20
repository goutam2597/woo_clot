import 'package:flutter/foundation.dart';

enum CouponType { percent, fixed, freeShipping }

@immutable
class CouponModel {
  final String code;
  final String title;
  final String? description;
  final CouponType type;
  final double amount; // for percent: 0..100, for fixed: currency amount
  final DateTime? expiry;

  const CouponModel({
    required this.code,
    required this.title,
    this.description,
    required this.type,
    required this.amount,
    this.expiry,
  });
}

