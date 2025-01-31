


import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/model/notice_model.dart';
import 'usecase_providers.dart';



final noticeProviders = FutureProvider<List<NoticeModel>>((ref) async {
  final getNoticeUseCase = ref.watch(getNoticesUseCaseProvider);
  return getNoticeUseCase();
});
