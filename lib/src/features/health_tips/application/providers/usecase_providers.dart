



import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ministry/src/features/banners/application/providers/banner_repository_provider.dart';
import 'package:ministry/src/features/banners/domain/usecases/get_banners.dart';
import 'package:ministry/src/features/health_tips/application/providers/healthTips_repository_provider.dart';

import '../../domain/usecases/get_healthtips.dart';



final getHealthTipsUseCaseProviders = Provider<GetHealthTips>((ref) {
  final repository = ref.watch(healthRepositoryProvider);
  return GetHealthTips(repository);
});
