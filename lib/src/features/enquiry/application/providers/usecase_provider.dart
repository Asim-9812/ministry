





import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ministry/src/features/enquiry/domain/usecase/get_enquiry_list.dart';

import '../../domain/usecase/get_countries.dart';
import '../../domain/usecase/get_medical_agency.dart';
import 'enquiry_repository_provider.dart';

final getMedicalAgencyUseCaseProviders = Provider<GetMedicalAgency>((ref) {
  final repository = ref.watch(enquiryRepositoryProvider);
  return GetMedicalAgency(repository);
});

final getMedicalAgencyByCodeUseCaseProviders = Provider<GetMedicalAgencyByCode>((ref) {
  final repository = ref.watch(enquiryRepositoryProvider);
  return GetMedicalAgencyByCode(repository);
});


final getCountriesUseCaseProviders = Provider<GetCountries>((ref) {
  final repository = ref.watch(enquiryRepositoryProvider);
  return GetCountries(repository);
});


final getAvailableCountriesUseCaseProviders = Provider<GetAvailableCountries>((ref) {
  final repository = ref.watch(enquiryRepositoryProvider);
  return GetAvailableCountries(repository);
});


final getProvinceUseCaseProviders = Provider<GetProvinces>((ref) {
  final repository = ref.watch(enquiryRepositoryProvider);
  return GetProvinces(repository);
});

final getDistrictUseCaseProviders = Provider<GetDistricts>((ref) {
  final repository = ref.watch(enquiryRepositoryProvider);
  return GetDistricts(repository);
});


final getEnquiryListUseCaseProviders = Provider<GetEnquiryList>((ref) {
  final repository = ref.watch(enquiryRepositoryProvider);
  return GetEnquiryList(repository);
});


// final getEnquiryReportUseCaseProviders = Provider<GetEnquiryReport>((ref) {
//   final repository = ref.watch(enquiryRepositoryProvider);
//   return GetEnquiryReport(repository);
// });