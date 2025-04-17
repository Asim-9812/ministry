


import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ministry/src/features/reminders/application/controller/reminder_list_controller.dart';
import 'package:ministry/src/features/reminders/domain/model/reminder_model.dart';
import 'usecase_providers.dart';



final reminderProvider = StateProvider<List<ReminderModel>>((ref) {
  final type = ref.watch(reminderController).reminderType;
  final getRemindersUseCase = ref.watch(getRemindersUseCaseProviders);
  return getRemindersUseCase(type: type);
});

final reminderByIdProvider = StateProvider.family.autoDispose<ReminderModel, int>((ref, reminderId) {
  final getReminderByIdUseCase = ref.watch(getReminderByIdUseCaseProviders);
  return getReminderByIdUseCase(reminderId: reminderId);
});
