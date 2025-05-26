




import 'package:ministry/src/features/report/data/medical_report_repository.dart';

class GetMedicalReport{

  final MedicalReportRepository repository;

  GetMedicalReport(this.repository);

  Future<String> call({required String id, required String token}) {
    return repository.getMedicalReport(id: id, token: token);
  }

}

class GetMedicalReportList{

  final MedicalReportRepository repository;

  GetMedicalReportList(this.repository);

  Future<List<Map<String,dynamic>>> call({required String id, required String token}) {
    return repository.getMedicalReportList(id: id, token: token);
  }

}