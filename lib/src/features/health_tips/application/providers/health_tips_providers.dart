


import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ministry/src/features/health_tips/domain/model/health_tips_model.dart';
import 'usecase_providers.dart';



final healthTipsProvider = FutureProvider<List<HealthTipsModel>>((ref) async {
  final getHealthTipsUseCase = ref.watch(getHealthTipsUseCaseProviders);
  return getHealthTipsUseCase();
});
