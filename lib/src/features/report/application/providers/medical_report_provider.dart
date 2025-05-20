



import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ministry/src/core/providers/user_info_provider.dart';
import 'package:ministry/src/features/health_tips/domain/model/health_tips_model.dart';
import 'usecase_providers.dart';



final medicalReportProvider = FutureProvider.autoDispose<String>((ref) async {
  final id = ref.read(userInfoProvider).userName;
  final token = ref.read(userInfoProvider).token;
  final getMedicalReportUseCase = ref.watch(getMedicalReportUseCaseProviders);
  return getMedicalReportUseCase(id: id, token: token!);
});
