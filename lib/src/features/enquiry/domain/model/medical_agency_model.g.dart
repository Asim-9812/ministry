// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'medical_agency_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MedicalAgencyModel _$MedicalAgencyModelFromJson(Map<String, dynamic> json) =>
    MedicalAgencyModel(
      code: json['code'] as String,
      organizationname: json['organizationname'] as String,
      fullAddress: json['fullAddress'] as String,
      contact: json['contact'] as String?,
      email: json['email'] as String?,
    );

Map<String, dynamic> _$MedicalAgencyModelToJson(MedicalAgencyModel instance) =>
    <String, dynamic>{
      'code': instance.code,
      'organizationname': instance.organizationname,
      'fullAddress': instance.fullAddress,
      'contact': instance.contact,
      'email': instance.email,
    };
