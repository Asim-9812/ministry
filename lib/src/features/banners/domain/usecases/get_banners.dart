



import 'package:ministry/src/features/banners/data/repositories/banner_repository.dart';
import 'package:ministry/src/features/banners/domain/model/banner_model.dart';


class GetBanners {
  final BannerRepository repository;

  GetBanners(this.repository);

  Future<List<BannerModel>> call() {
    return repository.fetchBanners();
  }
}
