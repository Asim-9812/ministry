

class PaymentModel{

  final int id;
  final String name;
  final String icon;

  PaymentModel({
    required this.id,
    required this.name,
    required this.icon,
});

}

final paymentList = [
  PaymentModel(id: 1, name: 'Esewa', icon: 'assets/icons/esewa.png')
];