import 'package:flutter/foundation.dart';
import 'package:flutter_woocommerce/app/assets_path.dart';

class ProfileController extends ChangeNotifier {
  String name = 'Mark Adam';
  String email = 'Sunny_Koelpin45@hotmail.com';
  String phone = '+1 212 555 2222';
  DateTime? dob; // null -> not set
  String gender = 'Male'; // Male, Female, Other
  String country = 'United States';
  String avatar = AssetsPath.dummy2; // asset path or URL

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
