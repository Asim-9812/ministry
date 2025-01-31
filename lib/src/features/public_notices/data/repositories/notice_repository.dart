

import '../../domain/model/notice_model.dart';

abstract class NoticeRepository {
  Future<List<NoticeModel>> fetchNotices();
}
