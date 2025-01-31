


import 'package:ministry/src/features/health_tips/domain/model/health_tips_model.dart';

abstract class HealthTipsRepository {
  Future<List<HealthTipsModel>> fetchHealthTips();
}
