



import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:ministry/src/core/models/user_model.dart';
import 'package:ministry/src/features/login/data/repositories/login_repository.dart';

import '../../../../core/api/api.dart';
import '../../../status_page/domain/model/user_model.dart';



class LoginRepositoryImpl implements LoginRepository{
  final dio = Dio();

  @override
  Future<UserModel> login({required String username, required String password}) async {
    try{
      final response = await dio.post(Api.login,
        data: {
          "id": 0,
          "userName": username,
          "password": password,
          "flag": "string",
          "token": "string",
          "key": "wL65|[R7+VGB7-m"
        }
      );
      if (response.statusCode == 200) {
        final data = response.data['result'] as Map<String, dynamic>;

        if(data['id'] == 0){
          throw ('Username or password is incorrect.');
        }
        else{
          final user = UserModel.fromJson(data);

          // Save the user in Hive for persistence
          final box = await Hive.box<UserModel>('users');
          await box.put('user', user);

          return user;
        }


      }
      else {
        throw Exception('Failed to fetch data');
      }
    }on DioException catch(err){
      throw Exception('Failed to fetch data');
    }
  }


  Future<UserModel?> getSavedUser() async {
    final box = await Hive.box<UserModel>('users');
    return box.get('user');
  }

  Future<void> logout() async {
    final box = await Hive.box<UserModel>('users');
    await box.delete('user');
  }

}
