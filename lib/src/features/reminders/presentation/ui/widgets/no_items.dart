



import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/widgets/common_widgets.dart';
import '../../../application/provider/reminders_providers.dart';

class NoReminderItems extends ConsumerWidget {
  const NoReminderItems({super.key});

  @override
  Widget build(BuildContext context, ref) {

    return RefreshIndicator(
      onRefresh: () {
        ref.refresh(reminderProvider);
        return Future.value(true);
      },
      child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: noItems()
      ),
    );
  }
}
