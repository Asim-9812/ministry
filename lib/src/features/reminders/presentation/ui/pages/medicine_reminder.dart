



import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:ministry/src/core/widgets/common_widgets.dart';
import 'package:ministry/src/features/reminders/application/provider/reminders_providers.dart';

import '../../../../../core/resources/color_manager.dart';
import '../../../../../core/resources/font_manager.dart';
import '../../../../../core/resources/gap_manager.dart';
import '../../../application/controller/reminder_notifier.dart';

class MedicineReminderInfo extends ConsumerWidget {
  final int reminderId;
  const MedicineReminderInfo({required this.reminderId, super.key});

  @override
  Widget build(BuildContext context, ref) {

    final medNotifier = ref.watch(reminderNotifier.notifier);

    final reminder = ref.watch(reminderByIdProvider(reminderId));

    final medicine = reminder.medicineReminder!;

    final name = medicine.medicineName;
    final strength = '${medicine.strength} ${medicine.unit.units}';
    final frequency = medicine.frequency.name;
    final meal = medicine.meal.name;
    final scheduledTime = medicine.scheduledTime;
    final totalDays = medicine.totalDays;
    final pattern = medicine.reminderPattern.pattern;
    final days = medicine.reminderPattern.daysOfWeek;
    final interval = medicine.reminderPattern.intervalDays;
    final notes = medicine.note;
    final img = medicine.attachment;
    final dateList = medicine.dateList;

    return Scaffold(
      appBar: commonNavBar('Medicine Info'),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: scheduledTime.map((e) {
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
            ),
            h10,
            Row(
              children: [
                if(img != null)
                Card(
                  margin: EdgeInsets.zero,
                  color: MyColors.white,
                  elevation: 5,
                  child: InkWell(
                    onTap: () async {
                      await showDialog(context: context, builder: (context){
                        return Container(
                            width: double.infinity,
                            height: double.infinity,
                            color: Colors.black,
                            child: Stack(
                              children: [
                                Center(child: Image.memory(img)),
                                Align(
                                  alignment: Alignment.topRight,
                                  child: IconButton(onPressed: ()=>Navigator.pop(context), icon: Icon(Icons.close,color: MyColors.white,)),
                                ),
                              ],
                            ));
                      });
                    },
                    child: Container(
                      width: 60,
                      height: 60,

                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                              color: MyColors.primary
                          ),
                          image: DecorationImage(image: MemoryImage(img), fit: BoxFit.fill)
                      ),
                    ),
                  ),
                ),
                if(img != null)
                w10,
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: MyColors.lightGrey
                    ),
                    padding: EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(name,style: bh2,),
                        rowTile('Strength', strength, br1),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            h10,

            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: MyColors.lightGrey
              ),
              width: double.infinity,
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Duration : $totalDays days', style: bh2,),
                  Text('${intakeLeft(dateList)}', style: bh3,),
                  h06,
                  Text('$frequency - $meal', style: br2,),

                  h10,
                  Text('Interval',style: bh2,),
                  if(days == null && interval == null)
                  Text(pattern,style: br1,),
                  if(days != null || interval != null)
                    h06,
                  if(days != null)
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: days.map((e) {
                          return Container(
                            width: 50,
                            decoration: BoxDecoration(
                                color: MyColors.grey,
                                borderRadius: BorderRadius.circular(12)
                            ),
                            margin: EdgeInsets.only(right: 8),
                            padding: EdgeInsets.all(8),
                            child: Center(child: Text(e.substring(0,3), style: bh3,)),
                          );
                        }
                        ).toList(),
                      ),
                    ),

                  if(interval != null )
                    Text('In interval of $interval days',style: bh3,),
                ],
              ),
            ),
            h10,
            if(notes != null)
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: MyColors.lightGrey
              ),
              width: double.infinity,
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Note', style: bh2,),
                  h10,
                  Text(notes,style: TextStyle(fontSize: 18,fontStyle: FontStyle.italic,fontWeight: FontWeight.w500),)
                ],
              ),
            ),
            h10,
            Row(
              children: [
                Expanded(
                  child: TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: MyColors.red,
                        foregroundColor: MyColors.white,
                        shape: ContinuousRectangleBorder(
                          borderRadius: BorderRadius.circular(18)
                        )
                      ),
                      onPressed: () async {
                        await showDialog(
                            context: context,
                            builder: (context){
                              return Center(
                                  child: ZoomIn(
                                    child: Container(
                                      color: MyColors.white,
                                      padding: EdgeInsets.symmetric(vertical: 8,horizontal: 16),
                                      child: Material(
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Text('Confirm Delete',style: bh2,),
                                            Divider(),
                                            Text('Are you sure you want to delete the reminder?',style: bh3,),
                                            h20,
                                            Row(
                                              children: [
                                                Expanded(
                                                  child: TextButton(
                                                      style: TextButton.styleFrom(
                                                          backgroundColor: MyColors.grey,
                                                          foregroundColor: MyColors.black,
                                                          shape: ContinuousRectangleBorder(
                                                              borderRadius: BorderRadius.circular(18)
                                                          )
                                                      ),
                                                      onPressed: ()=>Navigator.pop(context),
                                                      child: Text('No')),
                                                ),
                                                w10,
                                                Expanded(
                                                  child: TextButton(
                                                      style: TextButton.styleFrom(
                                                          backgroundColor: MyColors.red,
                                                          foregroundColor: MyColors.white,
                                                          shape: ContinuousRectangleBorder(
                                                              borderRadius: BorderRadius.circular(18)
                                                          )
                                                      ),
                                                      onPressed: () async {
                                                        await medNotifier.delReminder(reminderId: reminder.reminderId).whenComplete((){
                                                          ref.refresh(reminderProvider);
                                                          Navigator.pop(context);
                                                          Navigator.pop(context);
                                                        });
                                                      },
                                                      child: Text('Yes')),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  )
                              );
                            }
                        );

                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.delete,color: MyColors.white,),
                          w08,
                          Text('Delete'),
                        ],
                      )),
                ),
                w10,
                Expanded(
                  child: TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: MyColors.primary,
                        foregroundColor: MyColors.white,
                        shape: ContinuousRectangleBorder(
                          borderRadius: BorderRadius.circular(18)
                        )
                      ),
                      onPressed: (){},
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.edit,color: MyColors.white,),
                          w08,
                          Text('Edit'),
                        ],
                      )),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
  
  
  Row rowTile(String key, String value, TextStyle style){
    
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(key,style: style,),
        w10,
        Text(':',style: style,),
        w10,
        Text(value,style: style),
      ],
    );
    
  }

  String intakeLeft(List<DateTime> dates){

    final now = DateTime.now();
    final leftDates = [];
    int intakes = 0;

    for(DateTime date in dates){
      if(date.isAfter(now)){
        leftDates.add(date);
      }
    }

    intakes = leftDates.length;

    return '$intakes intakes left';

  }
  
}
