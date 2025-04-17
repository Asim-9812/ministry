





import 'package:dio/dio.dart';
import 'package:ministry/src/features/health_tips/data/sample_data.dart';
import 'package:ministry/src/features/health_tips/domain/model/health_tips_model.dart';

import '../../../../core/api/api.dart';
import 'health_tips_repository.dart';

class HealthTipsRepositoryImpl implements HealthTipsRepository{
  final dio = Dio();

  @override
  Future<List<HealthTipsModel>> fetchHealthTips() async {
    try{
      final sampleData = sampleHealthTips;
      final response = await dio.get(Api.healthTipList);
      if (response.statusCode == 200) {
        final data = response.data['result'] as List<dynamic>;
        // No real data in api right now.
        // if(data.isNotEmpty){
        //   return data.map((json) {
        //     final dto = HealthTipsModel.fromJson(json);
        //     return dto;
        //   }).toList();
        // }
        // else{
        //   return sampleData.map((json) {
        //     final dto = HealthTipsModel.fromJson(json);
        //     return dto;
        //   }).toList();
        // }
        return sampleData.map((json) {
          final dto = HealthTipsModel.fromJson(json);
          return dto;
        }).toList();

      }
      else {
        throw Exception('Failed to fetch data');
      }
    }on DioException catch(err){
      print(err);
      throw Exception('Failed to fetch data');
    }
  }
}
