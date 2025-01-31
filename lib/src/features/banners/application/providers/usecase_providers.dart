



import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ministry/src/features/banners/application/providers/banner_repository_provider.dart';
import 'package:ministry/src/features/banners/domain/usecases/get_banners.dart';



final getBannerUseCaseProviders = Provider<GetBanners>((ref) {
  final repository = ref.watch(bannerRepositoryProvider);
  return GetBanners(repository);
});
