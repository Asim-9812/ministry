



import 'package:dio/dio.dart';
import 'package:ministry/src/features/sign_up/data/repositories/signup_repository.dart';

import '../../../../core/api/api.dart';

class SignupRepositoryImpl extends SignupRepository{

  final dio = Dio();


  @override
  Future<bool> signUp({required Map<String, dynamic> data}) async {
    try{
      final response = await dio.post(Api.signup,
          data: data);
      if (response.statusCode == 200) {
        return true;
      }
      else {
        throw Exception('Failed to fetch data');
      }
    }on DioException catch(e){
      if(e.response?.statusCode == 400){
        throw Exception('User already exists');
      }
      else{
        throw Exception('${e.response?.statusCode} : Unable to sign up.');
      }

    }
  }
}