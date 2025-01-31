// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'health_tips_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HealthTipsModel _$HealthTipsModelFromJson(Map<String, dynamic> json) =>
    HealthTipsModel(
      healthTipsID: (json['healthTipsID'] as num).toInt(),
      type: json['type'] as String,
      description: json['description'] as String,
      isActive: json['isActive'] as bool,
      flag: json['flag'] as String?,
      language: json['language'] as String,
      toDate: json['toDate'] as String,
      validDate: json['validDate'] as String,
      remarks: json['remarks'] as String,
      userID: json['userID'] as String,
      createdBy: json['createdBy'] as String,
      shortInfo: json['shortInfo'] as String,
      title: json['title'] as String,
      image: json['image'] as String?,
    );

Map<String, dynamic> _$HealthTipsModelToJson(HealthTipsModel instance) =>
    <String, dynamic>{
      'healthTipsID': instance.healthTipsID,
      'type': instance.type,
      'description': instance.description,
      'isActive': instance.isActive,
      'flag': instance.flag,
      'language': instance.language,
      'toDate': instance.toDate,
      'validDate': instance.validDate,
      'remarks': instance.remarks,
      'userID': instance.userID,
      'createdBy': instance.createdBy,
      'shortInfo': instance.shortInfo,
      'title': instance.title,
      'image': instance.image,
    };
