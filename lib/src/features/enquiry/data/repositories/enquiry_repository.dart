


import 'package:ministry/src/features/enquiry/domain/model/medical_agency_model.dart';

import '../../domain/model/enquiry_model.dart';

abstract class EnquiryRepository{

  Future<List<MedicalAgencyModel>> fetchMedicalAgencies({required int provinceId});
  Future<MedicalAgencyModel?> fetchMedicalAgenciesByCode({required String code});
  Future<List<String>> fetchCountriesList();
  Future<List<dynamic>> fetchAvailableCountriesList();
  Future<List<dynamic>> fetchProvinces();
  Future<bool> insertEnquiry({required Map<String, dynamic> data});
  Future<List<EnquiryModel>> enquiryList({required String passportNo});

}