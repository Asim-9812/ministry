


import 'package:ministry/src/features/enquiry/domain/model/medical_agency_model.dart';

abstract class EnquiryRepository{

  Future<List<MedicalAgencyModel>> fetchMedicalAgencies({required int provinceId});
  Future<List<String>> fetchCountriesList();
  Future<List<dynamic>> fetchAvailableCountriesList();
  Future<List<dynamic>> fetchProvinces();
  Future<bool> insertEnquiry({required Map<String, dynamic> data});

}