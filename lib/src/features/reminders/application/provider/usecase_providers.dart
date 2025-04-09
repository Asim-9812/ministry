



import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ministry/src/features/reminders/domain/usecases/get_reminder_by_id.dart';
import '../../domain/usecases/get_reminders.dart';
import 'reminders_repository_provider.dart';

final getRemindersUseCaseProviders = Provider<GetReminders>((ref) {
  final repository = ref.watch(reminderRepositoryProvider);
  return GetReminders(repository);
});


final getReminderByIdUseCaseProviders = Provider<GetReminderById>((ref) {
  final repository = ref.watch(reminderRepositoryProvider);
  return GetReminderById(repository);
});
