


import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/repositories/notice_repository.dart';
import '../../data/repositories/notices_repository_impl.dart';




final noticeRepositoryProvider = Provider<NoticeRepository>((ref) {
  return NoticesRepositoryImpl();
});
