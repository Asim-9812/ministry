



import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:ministry/src/core/widgets/common_widgets.dart';
import 'package:ministry/src/features/reminders/application/provider/reminders_providers.dart';

import '../../../../../core/resources/color_manager.dart';
import '../../../../../core/resources/font_manager.dart';
import '../../../../../core/resources/gap_manager.dart';

class MedicineReminderInfo extends ConsumerWidget {
  final int reminderId;
  const MedicineReminderInfo({required this.reminderId, super.key});

  @override
  Widget build(BuildContext context, ref) {
    final reminder = ref.watch(reminderByIdProvider(reminderId));

    final medicine = reminder.medicineReminder!;

    final name = medicine.medicineName;
    final strength = '${medicine.strength} ${medicine.unit.units}';
    final frequency = medicine.frequency.name;
    final scheduledTime = medicine.scheduledTime;
    final totalDays = medicine.totalDays;
    final pattern = medicine.reminderPattern.pattern;
    final days = medicine.reminderPattern.daysOfWeek;
    final interval = medicine.reminderPattern.intervalDays;
    final notes = medicine.note;
    final img = medicine.attachment;

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
                  h10,
                  Text('Interval',style: bh2,),
                  if(days == null && interval == null)
                  Text(pattern,style: br1,),
                  if(days != null || interval != null)
                    h10,
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
  
}
