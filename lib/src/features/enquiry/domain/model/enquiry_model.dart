import 'package:json_annotation/json_annotation.dart';

part 'enquiry_model.g.dart';

@JsonSerializable()
class EnquiryModel {
  @JsonKey(name: 'Id')
  final int id;

  @JsonKey(name: 'FullName')
  final String fullName;

  @JsonKey(name: 'Contact')
  final String contact;

  @JsonKey(name: 'EmailID')
  final String emailID;

  @JsonKey(name: 'PassportNumber')
  final String passportNumber;

  @JsonKey(name: 'AppliedFor')
  final String appliedForRaw;

  @JsonKey(name: 'MedicalAgency')
  final String medicalAgency;

  @JsonKey(name: 'Queries')
  final String queries;

  @JsonKey(name: 'AppointmentDate')
  final DateTime appointmentDate;

  @JsonKey(name: 'EntryDate')
  final DateTime entryDate;

  @JsonKey(name: 'extra1')
  final dynamic extra1;

  @JsonKey(name: 'appliedfor')
  final String appliedForFormatted;

  EnquiryModel({
    required this.id,
    required this.fullName,
    required this.contact,
    required this.emailID,
    required this.passportNumber,
    required this.appliedForRaw,
    required this.medicalAgency,
    required this.queries,
    required this.appointmentDate,
    required this.entryDate,
    required this.extra1,
    required this.appliedForFormatted,
  });

  factory EnquiryModel.fromJson(Map<String, dynamic> json) =>
      _$EnquiryModelFromJson(json);

  Map<String, dynamic> toJson() => _$EnquiryModelToJson(this);
}
