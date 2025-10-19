enum PaymentType { visa, mastercard, paypal }

class PaymentMethodModel {
  final String id;
  PaymentType type;
  String label;
  String details;

  PaymentMethodModel({
    required this.id,
    required this.type,
    required this.label,
    required this.details,
  });
}

final List<PaymentMethodModel> methods = [
  PaymentMethodModel(
    id: 'pm_1',
    type: PaymentType.visa,
    label: 'Visa',
    details: '**** **** **** 4242',
  ),
  PaymentMethodModel(
    id: 'pm_2',
    type: PaymentType.mastercard,
    label: 'Mastercard',
    details: '**** **** **** 5587',
  ),
  PaymentMethodModel(
    id: 'pm_3',
    type: PaymentType.paypal,
    label: 'PayPal',
    details: 'john.doe@example.com',
  ),
];
