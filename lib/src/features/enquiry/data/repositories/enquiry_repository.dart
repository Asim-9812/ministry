


import 'package:ministry/src/features/enquiry/domain/model/medical_agency_model.dart';
import 'package:ministry/src/features/enquiry/domain/model/payment_model.dart';

import '../../domain/model/enquiry_model.dart';

abstract class EnquiryRepository{

  Future<List<MedicalAgencyModel>> fetchMedicalAgencies({required int provinceId});
  Future<MedicalAgencyModel?> fetchMedicalAgenciesByCode({required String code});
  Future<List<String>> fetchCountriesList();
  Future<List<dynamic>> fetchAvailableCountriesList();
  Future<List<dynamic>> fetchProvinces();
  Future<List<dynamic>> fetchDistricts({required int? provinceId});
  Future<String?> insertEnquiry({required Map<String, dynamic> data});
  Future<bool> insertPaymentInfo({required Map<String, dynamic> data});

  Future<List<PaymentListModel>> fetchPaymentList({required String code});
  Future<PaymentCredModel> fetchPaymentCred({required String code, required int paymentId});
  Future<List<EnquiryModel>> enquiryList({required String passportNo});

  Future<EnquiryModel?> getEnquiry({required String passportNo, required String date});
  Future<String?> getEnquiryReport({required String passportNo, required String code});

}