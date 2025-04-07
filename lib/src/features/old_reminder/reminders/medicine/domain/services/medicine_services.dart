



import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';

import '../../../../../../core/api/api.dart';
import '../model/medicine_model.dart';


final medRoutesProvider = FutureProvider.family((ref, String token) => MedicineServices.getRoutes(token: token));
final medUnitsProvider = FutureProvider.family((ref, String token) => MedicineServices.getUnits(token: token));
final medReminderProvider = StateProvider((ref) => MedicineServices.getMedicineList());
final medicineProvider = StateProvider.family((ref,int id) => MedicineServices.getMedById(id));


class MedicineServices{




  static const getMedUnit = 'https://schoolapi.meroupachar.com/api/MedicinePackage/GetUnitList';
  static const getFrequencyRoutes = 'https://schoolapi.meroupachar.com/api/PatientMedication/GetList';

  static List<MedicineModel> getMedicineList(){

    final medicineList = Hive.box<MedicineModel>('medicines').values.toList();

    return medicineList ;

  }


  static MedicineModel getMedById(int id){

    final medicineList = Hive.box<MedicineModel>('medicines').values.toList();

    final medicine = medicineList.firstWhere((element) => element.reminderId == id);

    return medicine ;

  }


  static Either<String, String> addMedicine({required MedicineModel medicine}){

    try{
      final medicineBox = Hive.box<MedicineModel>('medicines');

      medicineBox.add(medicine);

      return Right('Reminder added');

    } catch(e){
      return Left('$e');
    }

  }

  static Either<String, String> editMedicine({required MedicineModel medicine}){

    try{
      final medicineBox = Hive.box<MedicineModel>('medicines');

      final medicineList = Hive.box<MedicineModel>('medicines').values.toList();

      final updateIndex = medicineList.indexWhere((element) => element.reminderId == medicine.reminderId);

      medicineBox.putAt(updateIndex, medicine);

      return Right('Reminder Updated');

    } catch(e){
      return Left('$e');
    }

  }


  static Either<String, String> delMedicine({required MedicineModel medicine}){

    try{
      final medicineBox = Hive.box<MedicineModel>('medicines');

      final medicineList = Hive.box<MedicineModel>('medicines').values.toList();

      final updateIndex = medicineList.indexWhere((element) => element.reminderId == medicine.reminderId);

      medicineBox.deleteAt(updateIndex);

      return Right('Reminder Deleted');

    } catch(e){
      return Left('$e');
    }

  }






  static Future<List<MedicineRoute>> getRoutes({required String token}) async {
    try{

      final dio = Dio();
      dio.options.headers['Authorization']='Bearer $token';
      final response = await dio.get(getFrequencyRoutes);
      if(response.statusCode == 200){
        final data = response.data['item2'] as List<dynamic>;
        final routes = data.map((e) => MedicineRoute.fromJson(e)).toList();
        return routes;
      }else{
        throw Exception('${response.statusCode} ${response.statusMessage ?? 'Something went wrong'}');
      }


    } on DioException catch(e){
      throw Exception('${e.response?.statusCode} ${e.response?.statusMessage ?? 'Something went wrong'}');
    }

  }

  static Future<List<MedicineUnit>> getUnits({required String token}) async {
    try{
      final dio = Dio();
     
      dio.options.headers['Authorization']='Bearer $token';
      final response = await dio.get(getMedUnit);
      if(response.statusCode == 200){
        final data = response.data['result'] as List<dynamic>;
        final units = data.map((e) => MedicineUnit.fromJson(e)).toList();
        return units;
      }else{
        throw Exception('${response.statusCode} ${response.statusMessage ?? 'Something went wrong'}');
      }


    } on DioException catch(e){
      throw Exception('${e.response?.statusCode} ${e.response?.statusMessage ?? 'Something went wrong'}');
    }

  }

}