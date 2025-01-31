


import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ministry/src/features/banners/data/repositories/banners_repository_impl.dart';

import '../../../health_tips/data/repositories/health_tips_repository.dart';
import '../../data/repositories/banner_repository.dart';




final bannerRepositoryProvider = Provider<BannerRepository>((ref) {
  return BannersRepositoryImpl();
});
