

import 'package:ministry/src/features/banners/domain/model/banner_model.dart';

abstract class BannerRepository {
  Future<List<BannerModel>> fetchBanners();
}
