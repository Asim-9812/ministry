// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaymentListModel _$PaymentListModelFromJson(Map<String, dynamic> json) =>
    PaymentListModel(
      paymentid: (json['paymentid'] as num).toInt(),
      paymentName: json['paymentName'] as String,
      PaymentLogo: json['PaymentLogo'] as String,
      organizationId: (json['organizationId'] as num).toInt(),
    );

Map<String, dynamic> _$PaymentListModelToJson(PaymentListModel instance) =>
    <String, dynamic>{
      'paymentid': instance.paymentid,
      'paymentName': instance.paymentName,
      'PaymentLogo': instance.PaymentLogo,
      'organizationId': instance.organizationId,
    };

PaymentCredModel _$PaymentCredModelFromJson(Map<String, dynamic> json) =>
    PaymentCredModel(
      paymentCredentialId: (json['paymentCredentialId'] as num).toInt(),
      serviceId: (json['serviceId'] as num).toInt(),
      paymentTypeId: (json['paymentTypeId'] as num).toInt(),
      userId: json['userId'] as String,
      merchantUserName: json['merchantUserName'] as String?,
      merchantPassword: json['merchantPassword'] as String?,
      secretkey: json['secretkey'] as String,
      publickey: json['publickey'] as String,
      apiUrl: json['apiUrl'] as String?,
      responseUrl: json['responseUrl'] as String?,
      isActive: json['isActive'] as bool,
      roleId: (json['roleId'] as num).toInt(),
      entryDate: DateTime.parse(json['entryDate'] as String),
      extra1: json['extra1'] as String?,
      extra2: json['extra2'] as String?,
    );

Map<String, dynamic> _$PaymentCredModelToJson(PaymentCredModel instance) =>
    <String, dynamic>{
      'paymentCredentialId': instance.paymentCredentialId,
      'serviceId': instance.serviceId,
      'paymentTypeId': instance.paymentTypeId,
      'userId': instance.userId,
      'merchantUserName': instance.merchantUserName,
      'merchantPassword': instance.merchantPassword,
      'secretkey': instance.secretkey,
      'publickey': instance.publickey,
      'apiUrl': instance.apiUrl,
      'responseUrl': instance.responseUrl,
      'isActive': instance.isActive,
      'roleId': instance.roleId,
      'entryDate': instance.entryDate.toIso8601String(),
      'extra1': instance.extra1,
      'extra2': instance.extra2,
    };
