import 'package:json_annotation/json_annotation.dart';

part 'health_tips_model.g.dart'; // Generated file will be here

@JsonSerializable()
class HealthTipsModel {
  final int healthTipsID;
  final String type;
  final String description;
  final bool isActive;
  final String? flag;
  final String language;
  final String toDate;
  final String validDate;
  final String remarks;
  final String userID;
  final String createdBy;
  final String shortInfo;
  final String title;
  final String? image;

  HealthTipsModel({
    required this.healthTipsID,
    required this.type,
    required this.description,
    required this.isActive,
    this.flag,
    required this.language,
    required this.toDate,
    required this.validDate,
    required this.remarks,
    required this.userID,
    required this.createdBy,
    required this.shortInfo,
    required this.title,
    this.image,
  });

  // From JSON
  factory HealthTipsModel.fromJson(Map<String, dynamic> json) =>
      _$HealthTipsModelFromJson(json);

  // To JSON
  Map<String, dynamic> toJson() => _$HealthTipsModelToJson(this);

  // Empty Model
  factory HealthTipsModel.empty() => HealthTipsModel(
    healthTipsID: 0,
    type: '',
    description: '',
    isActive: false,
    flag: null,
    language: '',
    toDate: '',
    validDate: '',
    remarks: '',
    userID: '',
    createdBy: '',
    shortInfo: '',
    title: '',
    image: null,
  );
}
