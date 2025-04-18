



import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/usecases/get_medical_report.dart';
import 'medical_report_repository_provider.dart';



final getMedicalReportUseCaseProviders = Provider<GetMedicalReport>((ref) {
  final repository = ref.watch(medicalReportRepositoryProvider);
  return GetMedicalReport(repository);
});
