


import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ministry/src/features/banners/domain/model/banner_model.dart';
import 'usecase_providers.dart';



final bannerProviders = FutureProvider<List<BannerModel>>((ref) async {
  final getBannersUseCase = ref.watch(getBannerUseCaseProviders);
  return getBannersUseCase();
});
