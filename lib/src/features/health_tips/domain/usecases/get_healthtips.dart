



import 'package:ministry/src/features/banners/data/repositories/banner_repository.dart';
import 'package:ministry/src/features/banners/domain/model/banner_model.dart';
import 'package:ministry/src/features/health_tips/domain/model/health_tips_model.dart';

import '../../data/repositories/health_tips_repository.dart';

class GetHealthTips {
  final HealthTipsRepository repository;

  GetHealthTips(this.repository);

  Future<List<HealthTipsModel>> call() {
    return repository.fetchHealthTips();
  }
}
