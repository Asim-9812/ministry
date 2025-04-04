import 'package:json_annotation/json_annotation.dart';

part 'notice_model.g.dart'; // The generated file will be here.

@JsonSerializable()
class NoticeModel {
  final int? noticeID;
  final int? noticeType;
  final String? type;
  final String? description;
  final String? entryDate;
  final bool? isActive;
  final String? validDate;
  final String? toDate;
  final String? remarks;
  final String? code;
  final String? userID;
  final String? createdBy;
  final String? language;
  final String? flag;
  final String? shortInfo;
  final String? title;
  final String? image;

  NoticeModel({
    this.noticeID,
    this.noticeType,
    this.type,
    this.description,
    this.entryDate,
    this.isActive,
    this.validDate,
    this.toDate,
    this.remarks,
    this.code,
    this.userID,
    this.createdBy,
    this.language,
    this.flag,
    this.shortInfo,
    this.title,
    this.image,
  });

  // Factory constructor for an empty model
  factory NoticeModel.empty() {
    return NoticeModel(
      noticeID: null,
      noticeType: null,
      type: null,
      description: null,
      entryDate: null,
      isActive: null,
      validDate: null,
      toDate: null,
      remarks: null,
      code: null,
      userID: null,
      createdBy: null,
      language: null,
      flag: null,
      shortInfo: null,
      title: null,
      image: null,
    );
  }

  // From JSON
  factory NoticeModel.fromJson(Map<String, dynamic> json) =>
      _$NoticeModelFromJson(json);

  // To JSON
  Map<String, dynamic> toJson() => _$NoticeModelToJson(this);
}
