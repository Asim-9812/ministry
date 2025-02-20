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
  final String? contact; // Nullable

  @HiveField(9)
  final String? key; // Nullable

  @HiveField(10)
  final String orgId;

  @HiveField(11)
  final String? flag; // Nullable

  @HiveField(12)
  final String? token; // Nullable

  @HiveField(13)
  final int typeID;

  @HiveField(14)
  final String userID;

  @HiveField(15)
  final String companyName;

  @HiveField(16)
  final String mailingName;

  @HiveField(17)
  final String? companyFullAddress; // Nullable

  @HiveField(18)
  final String userCode;

  @HiveField(19)
  final String patientFullName;

  @HiveField(20)
  final String? patientPhoto; // Nullable

  @HiveField(21)
  final String? patientFullAddress; // Nullable

  @HiveField(22)
  final String? ageGender; // Nullable

  @HiveField(23)
  final String? bloodGroup; // Nullable

  @HiveField(24)
  final String? cardWatermark; // Nullable

  @HiveField(25)
  final String? colorCode; // Nullable

  @HiveField(26)
  final String? phGroup; // Nullable

  @HiveField(27)
  final String? imagePhoto; // Nullable

  @HiveField(28)
  final String? passportNo; // Added field

  UserModel({
    required this.id,
    required this.userName,
    required this.verify,
    required this.createdDate,
    required this.firstName,
    required this.lastName,
    required this.gender,
    required this.email,
    this.contact,
    this.key,
    required this.orgId,
    this.flag,
    this.token,
    required this.typeID,
    required this.userID,
    required this.companyName,
    required this.mailingName,
    this.companyFullAddress,
    required this.userCode,
    required this.patientFullName,
    this.patientPhoto,
    this.patientFullAddress,
    this.ageGender,
    this.bloodGroup,
    this.cardWatermark,
    this.colorCode,
    this.phGroup,
    this.imagePhoto,
    this.passportNo, // Added field
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
    contact: null,
    key: null,
    orgId: '',
    flag: null,
    token: null,
    typeID: 0,
    userID: '',
    companyName: '',
    mailingName: '',
    companyFullAddress: null,
    userCode: '',
    patientFullName: '',
    patientPhoto: null,
    patientFullAddress: null,
    ageGender: null,
    bloodGroup: null,
    cardWatermark: null,
    colorCode: null,
    phGroup: null,
    imagePhoto: null,
    passportNo: null, // Added field
  );
}
