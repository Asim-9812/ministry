






import 'package:ministry/src/features/reminders/data/repositories/reminder_repository.dart';
import 'package:ministry/src/features/reminders/domain/model/medicine_reminder_model.dart';
import 'package:ministry/src/features/reminders/domain/model/reminder_model.dart';

class GetReminders {
  final ReminderRepository repository;

  GetReminders(this.repository);

  List<ReminderModel> call({int? type}) {
    return repository.fetchAllReminder(type: type);
  }
}
