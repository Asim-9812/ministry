
import 'package:json_annotation/json_annotation.dart';

part 'payment_model.g.dart';

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
  PaymentModel(id: 1, name: 'Esewa', icon: 'assets/icons/esewa.png'),
  PaymentModel(id: 2, name: 'Khalti', icon: 'assets/icons/khalti.png')
];



@JsonSerializable()
class PaymentListModel {
  final int paymentid;
  final String paymentName;
  final String PaymentLogo;
  final int organizationId;

  PaymentListModel({
    required this.paymentid,
    required this.paymentName,
    required this.PaymentLogo,
    required this.organizationId,
  });

  factory PaymentListModel.fromJson(Map<String, dynamic> json) =>
      _$PaymentListModelFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentListModelToJson(this);
}


@JsonSerializable()
class PaymentCredModel {
  final int paymentCredentialId;
  final int serviceId;
  final int paymentTypeId;
  final String userId;
  final String? merchantUserName;
  final String? merchantPassword;
  final String secretkey;
  final String publickey;
  final String? apiUrl;
  final String? responseUrl;
  final bool isActive;
  final int roleId;
  final DateTime entryDate;
  final String? extra1;
  final String? extra2;

  PaymentCredModel({
    required this.paymentCredentialId,
    required this.serviceId,
    required this.paymentTypeId,
    required this.userId,
    this.merchantUserName,
    this.merchantPassword,
    required this.secretkey,
    required this.publickey,
    this.apiUrl,
    this.responseUrl,
    required this.isActive,
    required this.roleId,
    required this.entryDate,
    this.extra1,
    this.extra2,
  });

  factory PaymentCredModel.fromJson(Map<String, dynamic> json) =>
      _$PaymentCredModelFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentCredModelToJson(this);
}


// id
// orgid
// paymentmethod
// uniquereferenceid
// totalamt
// ledger
// txnid
// appointmentid
// entrydate
// payment
// extra1
// extra2