



import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ministry/src/features/public_notices/application/providers/notice_repository_provider.dart';

import '../../domain/usecases/get_notices.dart';



final getNoticesUseCaseProvider = Provider<GetNotices>((ref) {
  final repository = ref.watch(noticeRepositoryProvider);
  return GetNotices(repository);
});
