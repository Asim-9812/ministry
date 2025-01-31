

import '../../data/repositories/notice_repository.dart';
import '../model/notice_model.dart';

class GetNotices {
  final NoticeRepository repository;

  GetNotices(this.repository);

  Future<List<NoticeModel>> call() {
    return repository.fetchNotices();
  }
}
