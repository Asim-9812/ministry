// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'patient_document_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PatientDocumentModelAdapter extends TypeAdapter<PatientDocumentModel> {
  @override
  final int typeId = 12;

  @override
  PatientDocumentModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PatientDocumentModel(
      documentID: fields[0] as int,
      userID: fields[1] as String,
      code: fields[2] as dynamic,
      documentTypeID: fields[3] as int,
      folderName: fields[4] as String,
      patientAttachmentID: fields[5] as int,
      patientAttachment: fields[6] as String,
      documentTitle: fields[7] as String,
      documentDescription: fields[8] as String,
      duration: fields[9] as int,
      durationType: fields[10] as dynamic,
      completedDate: fields[11] as DateTime,
      attachmentsData: fields[12] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, PatientDocumentModel obj) {
    writer
      ..writeByte(13)
      ..writeByte(0)
      ..write(obj.documentID)
      ..writeByte(1)
      ..write(obj.userID)
      ..writeByte(2)
      ..write(obj.code)
      ..writeByte(3)
      ..write(obj.documentTypeID)
      ..writeByte(4)
      ..write(obj.folderName)
      ..writeByte(5)
      ..write(obj.patientAttachmentID)
      ..writeByte(6)
      ..write(obj.patientAttachment)
      ..writeByte(7)
      ..write(obj.documentTitle)
      ..writeByte(8)
      ..write(obj.documentDescription)
      ..writeByte(9)
      ..write(obj.duration)
      ..writeByte(10)
      ..write(obj.durationType)
      ..writeByte(11)
      ..write(obj.completedDate)
      ..writeByte(12)
      ..write(obj.attachmentsData);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PatientDocumentModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
