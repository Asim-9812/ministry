

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ministry/src/core/resources/color_manager.dart';
import 'package:ministry/src/core/widgets/common_widgets.dart';
import 'package:ministry/src/features/reminders/application/controller/general/add_general_controller.dart';
import 'package:ministry/src/features/reminders/presentation/ui/widgets/add_widgets/general/general_time_picker.dart';
import 'package:ministry/src/features/reminders/presentation/ui/widgets/add_widgets/general/time_list.dart';

import '../../../../../../core/resources/font_manager.dart';
import '../../../../../../core/resources/gap_manager.dart';

class AddGeneralReminder extends ConsumerWidget {
  const AddGeneralReminder({super.key});

  @override
  Widget build(BuildContext context, ref) {

    final controller = ref.watch(addGeneralController);

    final hour = controller.hour.toString();
    final min = controller.min.toString();
    final period = controller.period;

    final hrController = controller.hourController;
    final minController = controller.minuteController;
    final perController = controller.periodController;


    return Scaffold(
      appBar: commonNavBar('Add Reminder',color: MyColors.green),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0,horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            GeneralTimePicker()
          ],
        ),
      ),
    );
  }
}
