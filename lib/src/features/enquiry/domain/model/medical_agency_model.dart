import 'package:json_annotation/json_annotation.dart';

part 'medical_agency_model.g.dart';

@JsonSerializable()
class MedicalAgencyModel {
  final String code;
  final String organizationname;
  final String fullAddress;
  final String? contact;
  final String? email;

  MedicalAgencyModel({
    required this.code,
    required this.organizationname,
    required this.fullAddress,
    this.contact,
    this.email,
  });

  factory MedicalAgencyModel.fromJson(Map<String, dynamic> json) => _$MedicalAgencyModelFromJson(json);

  Map<String, dynamic> toJson() => _$MedicalAgencyModelToJson(this);

  // Empty model
  static final empty = MedicalAgencyModel(
    code: '',
    organizationname: '',
    fullAddress: '',
    contact: null,
    email: null,
  );
}
