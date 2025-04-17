


import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ministry/src/features/health_tips/data/repositories/health_tips_repository_impl.dart';

import '../../data/repositories/health_tips_repository.dart';




final healthRepositoryProvider = Provider<HealthTipsRepository>((ref) {
  return HealthTipsRepositoryImpl();
});
