import 'package:json_annotation/json_annotation.dart';

part 'notice_model.g.dart'; // The generated file will be here.

@JsonSerializable()
class NoticeModel {
  final int noticeID;
  final int noticeType;
  final String type;
  final String description;
  final String entryDate;
  final bool isActive;
  final String validDate;
  final String toDate;
  final String remarks;
  final String code;
  final String userID;
  final String createdBy;
  final String language;
  final String? flag;
  final String shortInfo;
  final String title;
  final String? image;

  NoticeModel({
    required this.noticeID,
    required this.noticeType,
    required this.type,
    required this.description,
    required this.entryDate,
    required this.isActive,
    required this.validDate,
    required this.toDate,
    required this.remarks,
    required this.code,
    required this.userID,
    required this.createdBy,
    required this.language,
    this.flag,
    required this.shortInfo,
    required this.title,
    this.image,
  });

  // Factory constructor for an empty model
  factory NoticeModel.empty() {
    return NoticeModel(
      noticeID: 0,
      noticeType: 0,
      type: '',
      description: '',
      entryDate: '',
      isActive: false,
      validDate: '',
      toDate: '',
      remarks: '',
      code: '',
      userID: '',
      createdBy: '',
      language: '',
      flag: null,
      shortInfo: '',
      title: '',
      image: null,
    );
  }


  // From JSON
  factory NoticeModel.fromJson(Map<String, dynamic> json) =>
      _$NoticeModelFromJson(json);

  // To JSON
  Map<String, dynamic> toJson() => _$NoticeModelToJson(this);
}
