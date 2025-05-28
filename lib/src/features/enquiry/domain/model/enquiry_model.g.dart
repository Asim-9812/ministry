// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'enquiry_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EnquiryModel _$EnquiryModelFromJson(Map<String, dynamic> json) => EnquiryModel(
      id: (json['Id'] as num).toInt(),
      fullName: json['FullName'] as String,
      contact: json['Contact'] as String,
      emailID: json['EmailID'] as String,
      passportNumber: json['PassportNumber'] as String,
      appliedForRaw: json['AppliedFor'] as String,
      medicalAgency: json['MedicalAgency'] as String,
      medicalAgencyFullName: json['MedicalAgencyFullName'] as String,
      queries: json['Queries'] as String,
      appointmentDate: DateTime.parse(json['AppointmentDate'] as String),
      entryDate: DateTime.parse(json['EntryDate'] as String),
      extra1: json['extra1'],
      appliedForFormatted: json['appliedfor'] as String,
    );

Map<String, dynamic> _$EnquiryModelToJson(EnquiryModel instance) =>
    <String, dynamic>{
      'Id': instance.id,
      'FullName': instance.fullName,
      'Contact': instance.contact,
      'EmailID': instance.emailID,
      'PassportNumber': instance.passportNumber,
      'AppliedFor': instance.appliedForRaw,
      'MedicalAgency': instance.medicalAgency,
      'MedicalAgencyFullName': instance.medicalAgencyFullName,
      'Queries': instance.queries,
      'AppointmentDate': instance.appointmentDate.toIso8601String(),
      'EntryDate': instance.entryDate.toIso8601String(),
      'extra1': instance.extra1,
      'appliedfor': instance.appliedForFormatted,
    };
