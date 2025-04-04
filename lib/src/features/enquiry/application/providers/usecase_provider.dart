





import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/usecase/get_countries.dart';
import '../../domain/usecase/get_medical_agency.dart';
import 'enquiry_repository_provider.dart';

final getMedicalAgencyUseCaseProviders = Provider<GetMedicalAgency>((ref) {
  final repository = ref.watch(enquiryRepositoryProvider);
  return GetMedicalAgency(repository);
});


final getCountriesUseCaseProviders = Provider<GetCountries>((ref) {
  final repository = ref.watch(enquiryRepositoryProvider);
  return GetCountries(repository);
});
