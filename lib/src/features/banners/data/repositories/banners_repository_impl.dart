


import 'package:dio/dio.dart';
import 'package:ministry/src/features/banners/domain/model/banner_model.dart';

import '../../../../core/api/api.dart';
import '../../../health_tips/data/repositories/health_tips_repository.dart';
import 'banner_repository.dart';

class BannersRepositoryImpl implements BannerRepository{
  final dio = Dio();

  @override
  Future<List<BannerModel>> fetchBanners() async {
    try{
      final response = await dio.get(Api.sliderList);
      if (response.statusCode == 200) {
        final data = response.data['result'] as List<dynamic>;
        return data.map((json) {
          final dto = BannerModel.fromJson(json);
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
