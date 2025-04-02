


// The notifier that handles the state of the leave request process
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ministry/src/features/reminders/data/repositories/reminder_repository.dart';
import 'package:ministry/src/features/reminders/data/repositories/reminder_repository_impl.dart';

import '../../domain/model/load_state.dart';
import '../../domain/model/medicine_reminder_model.dart';

class ReminderNotifier extends StateNotifier<LoadState> {
  final ReminderRepository reminderRepository;

  ReminderNotifier({required this.reminderRepository}) : super(LoadState());


  Future<void> addMedicineReminder({required MedicineReminderModel medicine}) async {
    state = LoadState(isLoading: true);  // Set loading state

    try {
      bool result = await reminderRepository.addMedicineReminder(medicine: medicine);
      if (result) {
        state = LoadState(isLoading: false, isSuccess: true);  // Success state
      } else {
        state = LoadState(isLoading: false, error: 'Unable to add the reminder.');  // Error state
      }
    } catch (error) {
      state = LoadState(isLoading: false, error: error.toString());  // Handle exception
    }
  }


  Future<void> delReminder({required int reminderId}) async {
    state = LoadState(isLoading: true);  // Set loading state

    try {
      bool result = await reminderRepository.delReminder(reminderId: reminderId);
      if (result) {
        state = LoadState(isLoading: false, isSuccess: true);  // Success state
      } else {
        state = LoadState(isLoading: false, error: 'Unable to delete the reminder.');  // Error state
      }
    } catch (error) {
      state = LoadState(isLoading: false, error: error.toString());  // Handle exception
    }
  }



}


final reminderNotifier = StateNotifierProvider<ReminderNotifier, LoadState>((ref) {
  final reminderRepository = ReminderRepositoryImpl();  // Provide an instance of the repository
  return ReminderNotifier(reminderRepository: reminderRepository);
});
