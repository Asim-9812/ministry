





import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ministry/src/features/enquiry/application/providers/usecase_provider.dart';
import 'package:ministry/src/features/enquiry/domain/model/enquiry_model.dart';
import 'package:ministry/src/features/enquiry/domain/model/payment_model.dart';
import 'package:ministry/src/features/login/application/login_notifier.dart';

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

final sectorProvider = FutureProvider<List<dynamic>>((ref) async {
  final getSectorUseCase = ref.watch(getSectorUseCaseProviders);
  return getSectorUseCase();
});

final districtProvider = FutureProvider.family<List<dynamic>, int?>((ref, provinceId) async {
  final getDistrictUseCase = ref.watch(getDistrictUseCaseProviders);
  return getDistrictUseCase(provinceId: provinceId);
});

final enquiryListProvider = FutureProvider.family.autoDispose<List<EnquiryModel>, int>((ref, filter) async {
  final passportNo = ref.read(loginNotifierProvider).user!.passportNo;
  final userId = ref.read(loginNotifierProvider).user!.id;
  final getEnquiryListUseCase = ref.watch(getEnquiryListUseCaseProviders);
  return getEnquiryListUseCase(passportNo: passportNo!, userId: userId.toString(), filter: filter);
});


final paymentListProvider = FutureProvider.family<List<PaymentListModel>, String>((ref, code) async {
  final getPaymentListUseCase = ref.watch(getPaymentListUseCaseProviders);
  return getPaymentListUseCase(code: code);
});


