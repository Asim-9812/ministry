// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'banner_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BannerModel _$BannerModelFromJson(Map<String, dynamic> json) => BannerModel(
      sliderId: (json['sliderId'] as num).toInt(),
      title: json['title'] as String,
      shortInfo: json['shortInfo'] as String,
      description: json['description'] as String,
      url: json['url'] as String,
      fromDate: DateTime.parse(json['fromDate'] as String),
      toDate: DateTime.parse(json['toDate'] as String),
      imagePath: json['imagePath'] as String,
      categoryId: (json['categoryId'] as num).toInt(),
      category: json['category'] as String,
      isActive: json['isActive'] as bool,
      entryDate: DateTime.parse(json['entryDate'] as String),
      remarks: json['remarks'] as String,
      flag: json['flag'] as String?,
    );

Map<String, dynamic> _$BannerModelToJson(BannerModel instance) =>
    <String, dynamic>{
      'sliderId': instance.sliderId,
      'title': instance.title,
      'shortInfo': instance.shortInfo,
      'description': instance.description,
      'url': instance.url,
      'fromDate': instance.fromDate.toIso8601String(),
      'toDate': instance.toDate.toIso8601String(),
      'imagePath': instance.imagePath,
      'categoryId': instance.categoryId,
      'category': instance.category,
      'isActive': instance.isActive,
      'entryDate': instance.entryDate.toIso8601String(),
      'remarks': instance.remarks,
      'flag': instance.flag,
    };
