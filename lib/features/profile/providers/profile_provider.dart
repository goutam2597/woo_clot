import 'package:flutter/foundation.dart';
import 'package:flutter_woocommerce/app/assets_path.dart';

class ProfileProvider extends ChangeNotifier {
  String name = 'WooClot';
  String email = 'wooclot@example.com';
  String phone = '+1 212 555 2222';
  DateTime? dob;
  String gender = 'Male';
  String country = 'United States';
  String avatar = AssetsPath.userSvg;

  void update({
    String? name,
    String? email,
    String? phone,
    DateTime? dob,
    String? gender,
    String? country,
    String? avatar,
  }) {
    if (name != null) this.name = name;
    if (email != null) this.email = email;
    if (phone != null) this.phone = phone;
    if (dob != null) this.dob = dob;
    if (gender != null) this.gender = gender;
    if (country != null) this.country = country;
    if (avatar != null) this.avatar = avatar;
    notifyListeners();
  }
}
