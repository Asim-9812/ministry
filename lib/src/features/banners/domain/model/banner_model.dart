

import 'package:json_annotation/json_annotation.dart';

part 'banner_model.g.dart';

@JsonSerializable()
class BannerModel {
  final int sliderId;
  final String title;
  final String shortInfo;
  final String description;
  final String url;
  final DateTime fromDate;
  final DateTime toDate;
  final String imagePath;
  final int categoryId;
  final String category;
  final bool isActive;
  final DateTime entryDate;
  final String remarks;
  final String? flag;

  BannerModel({
    required this.sliderId,
    required this.title,
    required this.shortInfo,
    required this.description,
    required this.url,
    required this.fromDate,
    required this.toDate,
    required this.imagePath,
    required this.categoryId,
    required this.category,
    required this.isActive,
    required this.entryDate,
    required this.remarks,
    this.flag,
  });

  /// Factory to create an empty model
  factory BannerModel.empty() {
    return BannerModel(
      sliderId: 0,
      title: '',
      shortInfo: '',
      description: '',
      url: '',
      fromDate: DateTime(1970, 1, 1),
      toDate: DateTime(1970, 1, 1),
      imagePath: '',
      categoryId: 0,
      category: '',
      isActive: false,
      entryDate: DateTime(1970, 1, 1),
      remarks: '',
      flag: null,
    );
  }

  /// Factory for JSON deserialization
  factory BannerModel.fromJson(Map<String, dynamic> json) => _$BannerModelFromJson(json);

  /// Method for JSON serialization
  Map<String, dynamic> toJson() => _$BannerModelToJson(this);
}
