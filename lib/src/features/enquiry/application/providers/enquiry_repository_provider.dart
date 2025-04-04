




import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/repositories/enquiry_repository.dart';
import '../../data/repositories/enquiry_repository_impl.dart';

final enquiryRepositoryProvider = Provider<EnquiryRepository>((ref) {
  return EnquiryRepositoryImpl();
});
