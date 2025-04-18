




import 'package:ministry/src/features/report/data/medical_report_repository.dart';

class GetMedicalReport{

  final MedicalReportRepository repository;

  GetMedicalReport(this.repository);

  Future<String> call({required String id}) {
    return repository.getMedicalReport(id: id);
  }

}