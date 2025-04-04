



import 'package:dio/dio.dart';
import 'package:ministry/src/core/api/api.dart';
import 'package:ministry/src/features/enquiry/domain/model/medical_agency_model.dart';

import 'enquiry_repository.dart';

class EnquiryRepositoryImpl extends EnquiryRepository{

  final dio = Dio();

  @override
  Future<List<MedicalAgencyModel>> fetchMedicalAgencies() async {
    try{
      final response = await dio.get(Api.getMedicalAgency);
      if(response.statusCode == 200){
        final data = response.data['result'] as List<dynamic>;
        final medicalAgencies = data.map((e)=>MedicalAgencyModel.fromJson(e)).toList();
        return medicalAgencies;
      }
      else{
        throw Exception('Unable to fetch data.');
      }
    }on DioException catch(e){
      print(e);
      throw Exception('Unable to fetch data.');
    }
  }

  @override
  Future<List<String>> fetchCountriesList() async {
    try{
      final response = await dio.get(Api.getAllCountries);
      if(response.statusCode == 200){
        final data = response.data['data'] as List<dynamic>;
        final countries = data.map((e)=>e['country'].toString()).toList();
        return countries;
      }
      else{
        throw Exception('Unable to fetch data.');
      }
    }on DioException catch(e){
      print(e);
      throw Exception('Unable to fetch data.');
    }
  }

  @override
  Future<bool> insertEnquiry({required Map<String, dynamic> data}) async {
    try{
      final response = await dio.post(Api.insertEnquiry,
        data: data
      );
      if(response.statusCode == 200){
        return true;
      }
      else{
        throw Exception('Unable to fetch data.');
      }
    }on DioException catch(e){
      print(e);
      throw Exception('Unable to fetch data.');
    }
  }
}