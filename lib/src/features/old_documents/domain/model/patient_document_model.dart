import 'package:hive/hive.dart';

part 'patient_document_model.g.dart';

@HiveType(typeId: 12)
class PatientDocumentModel extends HiveObject {
  @HiveField(0)
  int documentID;

  @HiveField(1)
  String userID;

  @HiveField(2)
  dynamic code;

  @HiveField(3)
  int documentTypeID;

  @HiveField(4)
  String folderName;

  @HiveField(5)
  int patientAttachmentID;

  @HiveField(6)
  String patientAttachment;

  @HiveField(7)
  String documentTitle;

  @HiveField(8)
  String documentDescription;

  @HiveField(9)
  int duration;

  @HiveField(10)
  dynamic durationType;

  @HiveField(11)
  DateTime completedDate;

  @HiveField(12)
  String? attachmentsData;

  PatientDocumentModel({
    required this.documentID,
    required this.userID,
    required this.code,
    required this.documentTypeID,
    required this.folderName,
    required this.patientAttachmentID,
    required this.patientAttachment,
    required this.documentTitle,
    required this.documentDescription,
    required this.duration,
    required this.durationType,
    required this.completedDate,
    required this.attachmentsData,
  });

  factory PatientDocumentModel.fromJson(Map<String, dynamic> json) {
    return PatientDocumentModel(
      documentID: json['documentID'],
      userID: json['userID'],
      code: json['code'],
      documentTypeID: json['documentTypeID'],
      folderName: json['folderName'],
      patientAttachmentID: json['patientAttachmentID'],
      patientAttachment: json['patientAttachment'],
      documentTitle: json['documentTitle'],
      documentDescription: json['documentDescription'],
      duration: json['duration'],
      durationType: json['durationType'],
      completedDate: DateTime.parse(json['completedDate']),
      attachmentsData: json['attachmentsData'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['documentID'] = this.documentID;
    data['userID'] = this.userID;
    data['code'] = this.code;
    data['documentTypeID'] = this.documentTypeID;
    data['folderName'] = this.folderName;
    data['patientAttachmentID'] = this.patientAttachmentID;
    data['patientAttachment'] = this.patientAttachment;
    data['documentTitle'] = this.documentTitle;
    data['documentDescription'] = this.documentDescription;
    data['duration'] = this.duration;
    data['durationType'] = this.durationType;
    data['completedDate'] = this.completedDate.toIso8601String();
    data['attachmentsData'] = this.attachmentsData;
    return data;
  }
}
