





import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ministry/src/features/enquiry/application/providers/usecase_provider.dart';
import 'package:ministry/src/features/enquiry/domain/model/enquiry_model.dart';

import '../../domain/model/medical_agency_model.dart';

final medicalAgenciesProvider = FutureProvider.family<List<MedicalAgencyModel>, int>((ref, id) async {
  final getMedicalAgencyUseCase = ref.watch(getMedicalAgencyUseCaseProviders);
  return getMedicalAgencyUseCase(provinceId: id);
});

final medicalAgenciesByCodeProvider = FutureProvider.family<MedicalAgencyModel?, String>((ref, code) async {
  final getMedicalAgencyByCodeUseCase = ref.watch(getMedicalAgencyByCodeUseCaseProviders);
  return getMedicalAgencyByCodeUseCase(code: code);
});


final countriesProvider = FutureProvider<List<String>>((ref) async {
  final getCountriesUseCase = ref.watch(getCountriesUseCaseProviders);
  return getCountriesUseCase();
});


final availableCountriesProvider = FutureProvider<List<dynamic>>((ref) async {
  final getCountriesUseCase = ref.watch(getAvailableCountriesUseCaseProviders);
  return getCountriesUseCase();
});

final provinceProvider = FutureProvider<List<dynamic>>((ref) async {
  final getProvinceUseCase = ref.watch(getProvinceUseCaseProviders);
  return getProvinceUseCase();
});

final districtProvider = FutureProvider.family<List<dynamic>, int?>((ref, provinceId) async {
  final getDistrictUseCase = ref.watch(getDistrictUseCaseProviders);
  return getDistrictUseCase(provinceId: provinceId);
});

final enquiryListProvider = FutureProvider.family<List<EnquiryModel>, String>((ref, passportNo) async {
  final getEnquiryListUseCase = ref.watch(getEnquiryListUseCaseProviders);
  return getEnquiryListUseCase(passportNo: passportNo);
});
