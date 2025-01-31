import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@HiveType(typeId: 0)
@JsonSerializable()
class UserModel {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String userName;

  @HiveField(2)
  final bool verify;

  @HiveField(3)
  final String createdDate;

  @HiveField(4)
  final String firstName;

  @HiveField(5)
  final String lastName;

  @HiveField(6)
  final int gender;

  @HiveField(7)
  final String email;

  @HiveField(8)
  final String contact;

  @HiveField(9)
  final String? key;

  @HiveField(10)
  final String orgId;

  @HiveField(11)
  final String? flag;

  @HiveField(12)
  final String? token;

  @HiveField(13)
  final int typeID;

  @HiveField(14)
  final String userID;

  @HiveField(15)
  final String companyName;

  @HiveField(16)
  final String mailingName;

  @HiveField(17)
  final String companyFullAddress;

  @HiveField(18)
  final String userCode;

  @HiveField(19)
  final String patientFullName;

  @HiveField(20)
  final String? patientPhoto;

  @HiveField(21)
  final String patientFullAddress;

  @HiveField(22)
  final String ageGender;

  @HiveField(23)
  final String? bloodGroup;

  @HiveField(24)
  final String? cardWatermark;

  @HiveField(25)
  final String? colorCode;

  @HiveField(26)
  final String? phGroup;

  @HiveField(27)
  final String? imagePhoto;

  UserModel({
    required this.id,
    required this.userName,
    required this.verify,
    required this.createdDate,
    required this.firstName,
    required this.lastName,
    required this.gender,
    required this.email,
    required this.contact,
    this.key,
    required this.orgId,
    this.flag,
    required this.token,
    required this.typeID,
    required this.userID,
    required this.companyName,
    required this.mailingName,
    required this.companyFullAddress,
    required this.userCode,
    required this.patientFullName,
    this.patientPhoto,
    required this.patientFullAddress,
    required this.ageGender,
    this.bloodGroup,
    this.cardWatermark,
    this.colorCode,
    this.phGroup,
    this.imagePhoto,
  });

  // From JSON
  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);

  // To JSON
  Map<String, dynamic> toJson() => _$UserModelToJson(this);

  /// Empty Model
  factory UserModel.empty() => UserModel(
    id: 0,
    userName: '',
    verify: false,
    createdDate: '',
    firstName: '',
    lastName: '',
    gender: 0,
    email: '',
    contact: '',
    key: null,
    orgId: '',
    flag: null,
    token: null,
    typeID: 0,
    userID: '',
    companyName: '',
    mailingName: '',
    companyFullAddress: '',
    userCode: '',
    patientFullName: '',
    patientPhoto: null,
    patientFullAddress: '',
    ageGender: '',
    bloodGroup: null,
    cardWatermark: null,
    colorCode: null,
    phGroup: null,
    imagePhoto: null,
  );

}
