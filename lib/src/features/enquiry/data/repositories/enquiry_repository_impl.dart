



import 'package:dio/dio.dart';
import 'package:ministry/src/core/api/api.dart';
import 'package:ministry/src/features/enquiry/domain/model/enquiry_model.dart';
import 'package:ministry/src/features/enquiry/domain/model/medical_agency_model.dart';

import 'enquiry_repository.dart';

class EnquiryRepositoryImpl extends EnquiryRepository{

  final dio = Dio();

  @override
  Future<List<MedicalAgencyModel>> fetchMedicalAgencies({required int provinceId}) async {
    try{
      final response = await dio.get(Api.getMedicalAgency);
      if(response.statusCode == 200){
        final data = response.data['result'] as List<dynamic>;
        final medicalAgencies = data.map((e)=>MedicalAgencyModel.fromJson(e)).toList();
        final filteredMedicalAgencies = medicalAgencies.where((e)=>e.fullAddress.split(',').first == provinceId.toString()).toList();
        return filteredMedicalAgencies;
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
  Future<MedicalAgencyModel?> fetchMedicalAgenciesByCode({required String code}) async {
    final response = await dio.get(Api.getMedicalAgency);
    if(response.statusCode == 200){
      final data = response.data['result'] as List<dynamic>;
      final medicalAgencies = data.map((e)=>MedicalAgencyModel.fromJson(e)).toList();
      final medicalAgency = medicalAgencies.singleWhere((e)=>e.code.toLowerCase() == code.toLowerCase(), orElse: ()=> MedicalAgencyModel(code: '-1', organizationname: '', fullAddress: ''));

      if(medicalAgency.code == '-1'){
        return null;
      }
      else{
        return medicalAgency;
      }

    }
    else{
      return null;
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
  Future<List<dynamic>> fetchAvailableCountriesList() async {
    try{
      final response = await dio.get(Api.getAvailableCountry);
      if(response.statusCode == 200){
        final data = response.data['data'] as List<dynamic>;
        return data;
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
  Future<List<dynamic>> fetchProvinces() async {
    try{
      final response = await dio.get(Api.getProvince);
      if(response.statusCode == 200){
        final data = response.data['data'] as List<dynamic>;
        return data;
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
      print(data);
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

  @override
  Future<List<EnquiryModel>> enquiryList({required String passportNo}) async {
    try{
      print(Api.getEnquiryList);
      final response = await dio.post(Api.getEnquiryList,
        data: {
          "tableName": "GetEnquiryByPassportNo",
          "parameter": {
            "passportNumber": "$passportNo",
            "flag": "getprintlist"
          }
        }
      );
      if(response.statusCode == 200){
        final data = response.data['data'] as List<dynamic>;
        final enquiryList = data.map((e)=>EnquiryModel.fromJson(e)).toList();
        print(enquiryList.length);
        enquiryList.sort((a,b)=>b.entryDate.compareTo(a.entryDate));
        return enquiryList;
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