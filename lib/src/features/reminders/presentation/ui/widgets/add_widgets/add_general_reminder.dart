

import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:ministry/src/core/resources/color_manager.dart';
import 'package:ministry/src/core/widgets/common_widgets.dart';
import 'package:ministry/src/features/reminders/application/controller/general/add_general_controller.dart';
import 'package:ministry/src/features/reminders/application/controller/medicine/medicine_reminder_notifier.dart';
import 'package:ministry/src/features/reminders/domain/model/general_reminder_model.dart';
import 'package:ministry/src/features/reminders/presentation/ui/widgets/add_widgets/general/general_time_picker.dart';
import 'package:ministry/src/features/reminders/presentation/ui/widgets/add_widgets/general/time_list.dart';

import '../../../../../../core/resources/font_manager.dart';
import '../../../../../../core/resources/gap_manager.dart';
import '../../../../../../core/utils/toaster.dart';
import '../../../../application/provider/reminders_providers.dart';
import '../../../../data/general_data/pattern_list.dart';

class AddGeneralReminder extends ConsumerWidget {
  const AddGeneralReminder({super.key});

  @override
  Widget build(BuildContext context, ref) {

    final controller = ref.watch(addGeneralController);

    final remId = controller.reminderId;

    final reminderPattern = generalPatternList;
    final patternId = controller.patternId;
    final patternError = controller.patternError;

    final hour = controller.hour;
    final min = controller.min;
    final startDate = controller.startDate;
    final formattedDate = DateFormat('EEE, MMM dd, yyy').format(startDate);
    final selectedDays = controller.selectedDaysOfWeek;


    final formKey = controller.formKey;
    final labelController = controller.labelController;
    final descController = controller.descController;
    final intervalController = controller.intervalController;

    final remindState = ref.watch(reminderNotifier);
    final genNotifier = ref.read(reminderNotifier.notifier);



    return GestureDetector(
      onTap: ()=>FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: commonNavBar('Add Reminder',color: MyColors.green),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0,horizontal: 16),
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  GeneralTimePicker(),
                  TextFormField(
                    controller: labelController,
                    decoration: InputDecoration(
                      isDense: true,
                      border: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: MyColors.green
                          ),
                          borderRadius: BorderRadius.circular(8)
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: MyColors.green
                          ),
                          borderRadius: BorderRadius.circular(8)
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: MyColors.green
                          ),
                          borderRadius: BorderRadius.circular(8)
                      ),
                      prefixIcon: Icon(Icons.title,color: MyColors.green,),
                      labelText: 'Label',
                      labelStyle: bh3,
                    ),
                    validator: (value) {
                      if(value == null || value.trim().isEmpty){
                        return 'Name is required';
                      }
                      return null;
                    },
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(30)
                    ],
                  ),
                  h10,
                  TextFormField(
                    readOnly: true,
                    onTap: ()async{
                      DateTime? selectedDate = await showDatePicker(
                          context: context,
                          firstDate: DateTime.now(),
                          lastDate: DateTime.now().add(Duration(days: 365)),
                        initialDate: startDate,
                      );
                      if(selectedDate != null){
                        ref.read(addGeneralController.notifier).changeStartDate(selectedDate);
                      }
                    },
                    decoration: InputDecoration(
                      isDense: true,
                      border: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: MyColors.green
                          ),
                          borderRadius: BorderRadius.circular(8)
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: MyColors.green
                          ),
                          borderRadius: BorderRadius.circular(8)
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: MyColors.green
                          ),
                          borderRadius: BorderRadius.circular(8)
                      ),
                      // prefixIcon: Icon(FontAwesomeIcons.calendarDay,color: MyColors.green,),
                      prefixIcon: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Row(
                                children: [
                                  Icon(FontAwesomeIcons.calendarDay,color: MyColors.green,),
                                  w14,
                                  Text('Starting Date',style: bh3,),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(formattedDate,style: br3,),
                                  w10,
                                  Icon(Icons.chevron_right,color: MyColors.grey,),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  h10,
                  Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: DropdownMenu(
                          initialSelection: patternId,
                          errorText: patternError,
                          width: double.infinity,
                          inputDecorationTheme: InputDecorationTheme(
                              isDense: true,
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide(
                                      color: MyColors.green
                                  )
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide(
                                      color: MyColors.green
                                  )
                              ),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide(
                                      color: MyColors.green
                                  )
                              )
                          ),
                          leadingIcon: Icon(FontAwesomeIcons.calendarDays,color: MyColors.green,),
                          label: Text('Repeat Pattern', style: bh3,maxLines: 1,),
                          textStyle: bh3,
                          onSelected: (value) {
                            if(value != null) {
                              ref
                                  .read(addGeneralController.notifier)
                                  .changePattern(value);
                            }
                            else{
                              ref.read(addGeneralController.notifier).patternHasError('Please select a pattern');
                            }

                          },
                          menuStyle: MenuStyle(
                            backgroundColor: WidgetStateColor.resolveWith((states) => MyColors.white,),
                            alignment: Alignment.bottomCenter,
                            padding: WidgetStatePropertyAll(EdgeInsets.zero),
                          ),
                          dropdownMenuEntries: reminderPattern.map((e)=>DropdownMenuEntry(value: e.id, label: e.pattern)).toList(),
                        ),
                      ),
                      if(patternId == 4)
                      w06,
                      if(patternId == 4)
                      Expanded(
                        flex: 1,
                        child: TextFormField(
                          controller: intervalController,
                          decoration: InputDecoration(
                              isDense: true,
                              contentPadding: EdgeInsets.symmetric(horizontal: 8,vertical: 18),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: MyColors.green
                                  ),
                                  borderRadius: BorderRadius.circular(8)
                              ),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: MyColors.green
                                  ),
                                  borderRadius: BorderRadius.circular(8)
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: MyColors.green
                                  ),
                                  borderRadius: BorderRadius.circular(8)
                              ),
                              labelText: 'Interval',
                              labelStyle: bh3
                          ),
                          validator: (value){
                            if(value!.trim().isEmpty){
                              return 'Interval is required';
                            }
                            try{
                              int.parse(value);
                            }catch(e){
                              return 'Invalid value';
                            }

                            return null;
                          },
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                        ),
                      )
                    ],
                  ),
                  if(patternId == 3)
                  h10,
                  if(patternId == 3)
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: daysOfWeek.map((e){
                        final selectedDay = selectedDays.contains(e.toLowerCase());
                        return InkWell(
                          onTap: (){
                            ref.read(addGeneralController.notifier).updateDaysList(e.toLowerCase());
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: selectedDay ? MyColors.green : MyColors.grey,
                                borderRadius: BorderRadius.circular(8)
                            ),
                            padding: EdgeInsets.symmetric(horizontal: 16,vertical: 8),
                            margin: EdgeInsets.only(right: 4),
                            child: Text(e.substring(0,3),style: selectedDay? wh4: bh4,),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  h10,
                  TextFormField(
                    controller: descController,
                    decoration: InputDecoration(
                        isDense: true,
                        border: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: MyColors.green
                            ),
                            borderRadius: BorderRadius.circular(8)
                        ),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: MyColors.green
                            ),
                            borderRadius: BorderRadius.circular(8)
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: MyColors.green
                            ),
                            borderRadius: BorderRadius.circular(8)
                        ),
                        prefixIcon: Icon(FontAwesomeIcons.notesMedical,color: MyColors.green,),
                        labelText: 'Notes (Optional)',
                        labelStyle: bh3
                    ),
                    maxLines: null,
                  ),
                  h10,
                  Row(
                    children: [
                      Expanded(
                        child: TextButton(
                            style: TextButton.styleFrom(
                                backgroundColor: MyColors.green,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8)
                                )
                            ),
                            onPressed: remindState.isLoading ? null : () async {
                              if (!formKey.currentState!.validate()) {
                                Toaster.error('Please fill all the necessary fields.');
                                return;
                              }

                              final errors = <String, VoidCallback>{
                               if (patternId == 0) 'Pattern is required.': () => ref.read(addGeneralController.notifier).patternHasError('Pattern is required.'),
                              };

                              if (errors.isNotEmpty) {
                                errors.forEach((_, callback) => callback()); // Trigger all error handlers
                                Toaster.error('Please fill all the necessary fields.');
                                return;
                              }

                              final genId = remId ?? Random().nextInt(100) + 2000;
                              final title = labelController.text.trim();
                              final desc = descController.text.trim().isNotEmpty? descController.text.trim() : null;
                              final finalDate = DateTime(startDate.year, startDate.month, startDate.day, hour, min);
                              final pattern = generalPatternList.singleWhere((e)=>e.id == patternId);
                              final reminderPattern = GeneralReminderPattern(
                                  id: pattern.id,
                                  pattern: pattern.pattern,
                                  intervalDays: patternId == 4 ? int.parse(intervalController.text.trim()) : null,
                                  daysOfWeek: patternId == 3 ? selectedDays : null
                              );

                              final generalReminder = GeneralReminderModel(
                                  id: genId,
                                  title: title,
                                  startDate: finalDate,
                                  description: desc,
                                  pattern: reminderPattern
                              );

                              await genNotifier.addGeneralReminder(generalReminder: generalReminder).whenComplete((){
                                ref.refresh(reminderProvider);
                                ref.refresh(reminderByIdProvider(genId));
                                Navigator.pop(context);
                              });

                            },
                            child: remindState.isLoading
                                ? SpinKitDualRing(color: MyColors.white,size: 16,)
                                :Text('Save',style: wh2,)
                        )
                      ),
                    ],
                  )

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
