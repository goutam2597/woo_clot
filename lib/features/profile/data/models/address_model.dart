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

final List<AddressModel> items = [
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
