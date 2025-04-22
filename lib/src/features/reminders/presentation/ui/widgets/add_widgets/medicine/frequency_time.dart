



import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

import '../../../../../../../core/resources/color_manager.dart';
import '../../../../../../../core/resources/font_manager.dart';
import '../../../../../../../core/resources/gap_manager.dart';
import '../../../../../application/controller/add_medicine_controller.dart';
import '../../../../../data/medicine_data/frequency_list.dart';

class FrequencyTime extends ConsumerWidget {
  const FrequencyTime({super.key});

  @override
  Widget build(BuildContext context,ref) {
    final medNotifier = ref.read(addMedicineController.notifier);
    final timeController = ref.watch(addMedicineController).time;
    final dateController = ref.watch(addMedicineController).startDate;
    final totalDays = ref.watch(addMedicineController).medDuration;
    final selectedFrequency = ref.watch(addMedicineController).frequencyId;
    final frequencyError = ref.watch(addMedicineController).frequencyError;
    final scheduleTimeList = ref.watch(addMedicineController).scheduledTimeList;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 3,
              child: DropdownMenu(
                initialSelection: selectedFrequency == 0 ? null : selectedFrequency,
                width: double.infinity,
                inputDecorationTheme: InputDecorationTheme(
                    isDense: true,
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(
                            color: MyColors.primary
                        )
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(
                            color: MyColors.primary
                        )
                    )
                ),
                leadingIcon: Icon(FontAwesomeIcons.timeline,color: MyColors.primary,),
                label: Text('Frequency', style: bh3,maxLines: 1,),
                textStyle: bh3,
                onSelected: (value) {
                  if(value != null){
                    medNotifier.changeFrequency(value);
                    if(timeController.text.trim().isNotEmpty){
                      final now = DateTime.now();
                      final time = DateFormat('HH:mm a').parse(timeController.text);
                      final scheduledTime = DateTime(now.year, now.month, now.day, time.hour, time.minute);
                      medNotifier.updateSchedule(value, scheduledTime);
                      ref.read(addMedicineController.notifier).frequencyHasError(null);
                    }
                  }
                },
                menuStyle: MenuStyle(
                  alignment: Alignment.bottomCenter,
                  padding: WidgetStatePropertyAll(EdgeInsets.zero),
                ),
                dropdownMenuEntries: frequencyList.map((e)=>DropdownMenuEntry(value: e.id, label: e.name)).toList(),
                errorText: frequencyError,
              ),
            ),
            w06,
            Expanded(
              flex: 2,
              child: TextFormField(
                readOnly: true,
                controller: timeController,
                style: bh3,
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(vertical: 18, horizontal: 8),
                    // isDense: true,
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(
                            color: MyColors.primary
                        )
                    ),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(
                            color: MyColors.primary
                        )
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(
                            color: MyColors.primary
                        )
                    ),
                    prefixIcon: Icon(FontAwesomeIcons.clock,color: MyColors.primary,size: 18,),
                    hintText: 'hh:mm'
                ),
                maxLines: 1,
                onTap: () async {
                  final now = DateTime.now();
                  final currentTime = TimeOfDay.now();
                  final preSelectedTime = scheduleTimeList.isNotEmpty ? TimeOfDay.fromDateTime(scheduleTimeList.first) : currentTime;
                  TimeOfDay? selectedTime = await showTimePicker(
                    context: context,
                    initialTime: preSelectedTime,
                  );
                  if(selectedTime != null){
                    DateTime time = DateTime(now.year, now.month, now.day, selectedTime.hour, selectedTime.minute);
                    timeController.text = DateFormat('HH:mm a').format(time);
                    medNotifier.updateSchedule(selectedFrequency, time);
                  }
                },
                validator: (value){
                  if(value == null || value.trim().isEmpty){
                    return 'Time required.';
                  }
                  else if(dateController.text.trim().isNotEmpty && totalDays.text.trim().isNotEmpty){
                    final now = DateTime.now();
                    final selectedTime = DateFormat('HH:mm a').parse(value);
                    final date = DateTime.parse(dateController.text.trim());
                    final total = int.parse(totalDays.text.trim());
                    final madeDate = DateTime(date.year,date.month,date.day,selectedTime.hour,selectedTime.minute);
                    if(total == 1  && now.isAfter(madeDate)){
                      return 'Scheduled time has passed.';
                    }

                  }
                  return null;
                },
                autovalidateMode: AutovalidateMode.onUserInteraction,
              ),
            )
          ],
        ),
        if(scheduleTimeList.length > 1)
        h10,
        if(scheduleTimeList.length > 1)
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: scheduleTimeList.map((e) {
                final time = DateFormat('HH:mm a').format(e);
                return Container(
                  decoration: BoxDecoration(
                      color: MyColors.primary,
                      borderRadius: BorderRadius.circular(12)
                  ),
                  margin: EdgeInsets.only(right: 8),
                  padding: EdgeInsets.all(8),
                  child: Text(time, style: wh4,),
                );
              }
              ).toList(),
            ),
          )
      ],
    );
  }
}
