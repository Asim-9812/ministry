


import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ministry/src/features/reminders/presentation/ui/widgets/add_widgets/general/time_list.dart';

import '../../../../../../../core/resources/color_manager.dart';
import '../../../../../../../core/resources/font_manager.dart';
import '../../../../../../../core/resources/gap_manager.dart';
import '../../../../../application/controller/general/add_general_controller.dart';

class GeneralTimePicker extends ConsumerWidget {
  const GeneralTimePicker({super.key});

  @override
  Widget build(BuildContext context, ref) {

    final controller = ref.watch(addGeneralController);

    final hour = controller.hour.toString();
    final min = controller.min.toString();
    final period = controller.period;

    final hrController = controller.hourController;
    final minController = controller.minuteController;
    final perController = controller.periodController;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: Center(child: Text('Hour',style: gr1,)),
              ),
              Expanded(
                child: Center(child: Text('Min',style: gr1,)),
              ),
              Expanded(
                child: Center(child: Text('Period',style: gr1,)),
              ),
            ],
          ),
        ),
        Container(
          // color: MyColors.red,
          height: 200,
          width: double.infinity,
          padding: EdgeInsets.all(16),
          child: Stack(
            children: [
              Center(
                child: Container(
                  height: 40,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: MyColors.green.withValues(alpha: 200),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: MyColors.green)
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: ListWheelScrollView.useDelegate(
                      itemExtent: 40,
                      controller: hrController,
                      physics: FixedExtentScrollPhysics(),
                      onSelectedItemChanged: (index) {
                        ref.read(addGeneralController.notifier).changeHour(hourList[index]);
                      },
                      childDelegate: ListWheelChildBuilderDelegate(
                        builder: (context, index) {
                          return Center(
                              child: Text(hourList[index], style: bh1)
                          );
                        },
                        childCount: hourList.length,
                      ),
                    ),
                  ),
                  VerticalDivider(
                    color: MyColors.grey,
                  ),
                  Expanded(
                    child: ListWheelScrollView.useDelegate(
                      itemExtent: 40,
                      perspective: 0.005,
                      controller: minController,
                      physics: FixedExtentScrollPhysics(),
                      onSelectedItemChanged: (index) {
                        ref.read(addGeneralController.notifier).changeMinute(minList[index]);
                      },
                      childDelegate: ListWheelChildBuilderDelegate(
                        builder: (context, index) {
                          return Center(child: Text(minList[index], style: bh1));
                        },
                        childCount: minList.length,
                      ),
                    ),
                  ),
                  VerticalDivider(
                    color: MyColors.grey,
                  ),
                  Expanded(
                    child: ListWheelScrollView.useDelegate(
                      itemExtent: 40,
                      perspective: 0.005,
                      controller: perController,
                      physics: FixedExtentScrollPhysics(),
                      onSelectedItemChanged: (index) {
                        ref.read(addGeneralController.notifier).changePeriod(periodList[index]);
                      },
                      childDelegate: ListWheelChildBuilderDelegate(
                        builder: (context, index) {
                          return Center(child: Text(periodList[index], style: bh1));
                        },
                        childCount: periodList.length,
                      ),
                    ),
                  ),
                ],
              ),

            ],
          ),
        ),
        h10,
        Divider(
          color: MyColors.grey,
        ),
        h10,
      ],
    );
  }
}
