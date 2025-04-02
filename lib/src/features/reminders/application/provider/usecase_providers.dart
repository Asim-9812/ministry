



import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/usecases/get_reminders.dart';
import 'reminders_repository_provider.dart';

final getRemindersUseCaseProviders = Provider<GetReminders>((ref) {
  final repository = ref.watch(reminderRepositoryProvider);
  return GetReminders(repository);
});
