



import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ministry/src/features/report/data/medical_report_repository_impl.dart';

import '../../data/medical_report_repository.dart';

final medicalReportRepositoryProvider = Provider<MedicalReportRepository>((ref) {
  return MedicalReportRepositoryImpl();
});
