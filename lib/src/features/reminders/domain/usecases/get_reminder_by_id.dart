






import 'package:ministry/src/features/reminders/data/repositories/reminder_repository.dart';
import 'package:ministry/src/features/reminders/domain/model/reminder_model.dart';

class GetReminderById {
  final ReminderRepository repository;

  GetReminderById(this.repository);

  ReminderModel call({required int reminderId}) {
    return repository.fetchReminderById(reminderId: reminderId);
  }
}
