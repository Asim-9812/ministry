// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserModelAdapter extends TypeAdapter<UserModel> {
  @override
  final int typeId = 0;

  @override
  UserModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserModel(
      id: fields[0] as int,
      userName: fields[1] as String,
      verify: fields[2] as bool,
      createdDate: fields[3] as String,
      firstName: fields[4] as String,
      lastName: fields[5] as String,
      gender: fields[6] as int,
      email: fields[7] as String,
      contact: fields[8] as String,
      key: fields[9] as String?,
      orgId: fields[10] as String,
      flag: fields[11] as String?,
      token: fields[12] as String?,
      typeID: fields[13] as int,
      userID: fields[14] as String,
      companyName: fields[15] as String,
      mailingName: fields[16] as String,
      companyFullAddress: fields[17] as String,
      userCode: fields[18] as String,
      patientFullName: fields[19] as String,
      patientPhoto: fields[20] as String?,
      patientFullAddress: fields[21] as String,
      ageGender: fields[22] as String,
      bloodGroup: fields[23] as String?,
      cardWatermark: fields[24] as String?,
      colorCode: fields[25] as String?,
      phGroup: fields[26] as String?,
      imagePhoto: fields[27] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, UserModel obj) {
    writer
      ..writeByte(28)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.userName)
      ..writeByte(2)
      ..write(obj.verify)
      ..writeByte(3)
      ..write(obj.createdDate)
      ..writeByte(4)
      ..write(obj.firstName)
      ..writeByte(5)
      ..write(obj.lastName)
      ..writeByte(6)
      ..write(obj.gender)
      ..writeByte(7)
      ..write(obj.email)
      ..writeByte(8)
      ..write(obj.contact)
      ..writeByte(9)
      ..write(obj.key)
      ..writeByte(10)
      ..write(obj.orgId)
      ..writeByte(11)
      ..write(obj.flag)
      ..writeByte(12)
      ..write(obj.token)
      ..writeByte(13)
      ..write(obj.typeID)
      ..writeByte(14)
      ..write(obj.userID)
      ..writeByte(15)
      ..write(obj.companyName)
      ..writeByte(16)
      ..write(obj.mailingName)
      ..writeByte(17)
      ..write(obj.companyFullAddress)
      ..writeByte(18)
      ..write(obj.userCode)
      ..writeByte(19)
      ..write(obj.patientFullName)
      ..writeByte(20)
      ..write(obj.patientPhoto)
      ..writeByte(21)
      ..write(obj.patientFullAddress)
      ..writeByte(22)
      ..write(obj.ageGender)
      ..writeByte(23)
      ..write(obj.bloodGroup)
      ..writeByte(24)
      ..write(obj.cardWatermark)
      ..writeByte(25)
      ..write(obj.colorCode)
      ..writeByte(26)
      ..write(obj.phGroup)
      ..writeByte(27)
      ..write(obj.imagePhoto);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      id: (json['id'] as num).toInt(),
      userName: json['userName'] as String,
      verify: json['verify'] as bool,
      createdDate: json['createdDate'] as String,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      gender: (json['gender'] as num).toInt(),
      email: json['email'] as String,
      contact: json['contact'] as String,
      key: json['key'] as String?,
      orgId: json['orgId'] as String,
      flag: json['flag'] as String?,
      token: json['token'] as String?,
      typeID: (json['typeID'] as num).toInt(),
      userID: json['userID'] as String,
      companyName: json['companyName'] as String,
      mailingName: json['mailingName'] as String,
      companyFullAddress: json['companyFullAddress'] as String,
      userCode: json['userCode'] as String,
      patientFullName: json['patientFullName'] as String,
      patientPhoto: json['patientPhoto'] as String?,
      patientFullAddress: json['patientFullAddress'] as String,
      ageGender: json['ageGender'] as String,
      bloodGroup: json['bloodGroup'] as String?,
      cardWatermark: json['cardWatermark'] as String?,
      colorCode: json['colorCode'] as String?,
      phGroup: json['phGroup'] as String?,
      imagePhoto: json['imagePhoto'] as String?,
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'id': instance.id,
      'userName': instance.userName,
      'verify': instance.verify,
      'createdDate': instance.createdDate,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'gender': instance.gender,
      'email': instance.email,
      'contact': instance.contact,
      'key': instance.key,
      'orgId': instance.orgId,
      'flag': instance.flag,
      'token': instance.token,
      'typeID': instance.typeID,
      'userID': instance.userID,
      'companyName': instance.companyName,
      'mailingName': instance.mailingName,
      'companyFullAddress': instance.companyFullAddress,
      'userCode': instance.userCode,
      'patientFullName': instance.patientFullName,
      'patientPhoto': instance.patientPhoto,
      'patientFullAddress': instance.patientFullAddress,
      'ageGender': instance.ageGender,
      'bloodGroup': instance.bloodGroup,
      'cardWatermark': instance.cardWatermark,
      'colorCode': instance.colorCode,
      'phGroup': instance.phGroup,
      'imagePhoto': instance.imagePhoto,
    };
