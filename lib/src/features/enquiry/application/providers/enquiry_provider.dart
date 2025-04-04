





import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ministry/src/features/enquiry/application/providers/usecase_provider.dart';

import '../../domain/model/medical_agency_model.dart';

final medicalAgenciesProvider = FutureProvider<List<MedicalAgencyModel>>((ref) async {
  final getMedicalAgencyUseCase = ref.watch(getMedicalAgencyUseCaseProviders);
  return getMedicalAgencyUseCase();
});


final countriesProvider = FutureProvider<List<String>>((ref) async {
  final getCountriesUseCase = ref.watch(getCountriesUseCaseProviders);
  return getCountriesUseCase();
});
