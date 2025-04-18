


import 'package:dio/dio.dart';
import 'package:ministry/src/core/api/api.dart';
import 'package:ministry/src/features/report/data/medical_report_repository.dart';

class MedicalReportRepositoryImpl extends MedicalReportRepository{

  final dio = Dio();

  @override
  Future<String> getMedicalReport({required String id}) async {
    try{
      final response = await dio.get('${Api.getMedicalReport}$id');

      if(response.statusCode == 200){
        final data = response.data['result'] as List<dynamic>;
        if(data.isEmpty){
          return 'No report found';
        }
        else{
          final report = response.data['result'][0]['reports'];
          return report;
        }

      }
      else{
        throw Exception('Unable to fetch report.');
      }

    }on DioException catch(e){
      print(e);
      throw Exception('Unable to fetch report.');
    }
  }

}