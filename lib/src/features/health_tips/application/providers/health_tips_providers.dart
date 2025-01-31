


import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ministry/src/features/banners/domain/model/banner_model.dart';
import 'package:ministry/src/features/health_tips/domain/model/health_tips_model.dart';
import 'usecase_providers.dart';



final healthTipsProvider = FutureProvider<List<HealthTipsModel>>((ref) async {
  final getBannersUseCase = ref.watch(getHealthTipsUseCaseProviders);
  return getBannersUseCase();
});
