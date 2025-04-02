


import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/repositories/reminder_repository.dart';
import '../../data/repositories/reminder_repository_impl.dart';




final reminderRepositoryProvider = Provider<ReminderRepository>((ref) {
  return ReminderRepositoryImpl();
});
