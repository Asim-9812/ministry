


import 'package:ministry/src/features/enquiry/domain/model/medical_agency_model.dart';

abstract class EnquiryRepository{

  Future<List<MedicalAgencyModel>> fetchMedicalAgencies();
  Future<List<String>> fetchCountriesList();
  Future<bool> insertEnquiry({required Map<String, dynamic> data});

}