// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notice_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NoticeModel _$NoticeModelFromJson(Map<String, dynamic> json) => NoticeModel(
      noticeID: (json['noticeID'] as num?)?.toInt(),
      noticeType: (json['noticeType'] as num?)?.toInt(),
      type: json['type'] as String?,
      description: json['description'] as String?,
      entryDate: json['entryDate'] as String?,
      isActive: json['isActive'] as bool?,
      validDate: json['validDate'] as String?,
      toDate: json['toDate'] as String?,
      remarks: json['remarks'] as String?,
      code: json['code'] as String?,
      userID: json['userID'] as String?,
      createdBy: json['createdBy'] as String?,
      language: json['language'] as String?,
      flag: json['flag'] as String?,
      shortInfo: json['shortInfo'] as String?,
      title: json['title'] as String?,
      image: json['image'] as String?,
    );

Map<String, dynamic> _$NoticeModelToJson(NoticeModel instance) =>
    <String, dynamic>{
      'noticeID': instance.noticeID,
      'noticeType': instance.noticeType,
      'type': instance.type,
      'description': instance.description,
      'entryDate': instance.entryDate,
      'isActive': instance.isActive,
      'validDate': instance.validDate,
      'toDate': instance.toDate,
      'remarks': instance.remarks,
      'code': instance.code,
      'userID': instance.userID,
      'createdBy': instance.createdBy,
      'language': instance.language,
      'flag': instance.flag,
      'shortInfo': instance.shortInfo,
      'title': instance.title,
      'image': instance.image,
    };
