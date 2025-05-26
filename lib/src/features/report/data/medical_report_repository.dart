


abstract class MedicalReportRepository{

  Future<String> getMedicalReport({required String id, required String token});
  Future<List<Map<String, dynamic>>> getMedicalReportList({required String id, required String token});

}