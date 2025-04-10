




import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:ministry/src/core/utils/page_route.dart';
import 'package:ministry/src/features/reminders/application/controller/reminder_notifier.dart';
import 'package:ministry/src/features/reminders/application/provider/reminders_providers.dart';
import 'package:ministry/src/features/reminders/domain/model/reminder_model.dart';
import 'package:ministry/src/features/reminders/presentation/ui/pages/medicine_reminder.dart';

import '../../../../../core/resources/color_manager.dart';
import '../../../../../core/resources/font_manager.dart';

class ReminderListTile extends ConsumerWidget {
  final ReminderModel reminder;
  const ReminderListTile({required this.reminder, super.key});

  @override
  Widget build(BuildContext context, ref) {
    final medNotifier = ref.watch(reminderNotifier.notifier);
    final medIcon = FaIcon(FontAwesomeIcons.pills,color: MyColors.primary,);
    final genIcon = FaIcon(FontAwesomeIcons.stopwatch,color: MyColors.green,);
    final noteIcon = FaIcon(FontAwesomeIcons.solidNoteSticky,color: MyColors.yellow,);
    final icon = reminder.reminderType == 1 ? medIcon : reminder.reminderType == 2 ? genIcon : noteIcon;
    final trailColor = reminder.reminderType == 1 ? MyColors.primary : MyColors.green;
    final subTitle = reminder.reminderType == 3 ? reminder.notes!.notes : reminder.reminderType == 1 ? reminder.medicineReminder!.reminderPattern.pattern : reminder.generalReminder!.pattern.pattern;
    final tileColor = reminder.reminderType == 1
        ? MyColors.primary.withValues(alpha: 220)
        : reminder.reminderType == 2
        ? MyColors.green.withValues(alpha: 220)
        : MyColors.yellow.withValues(alpha: 220);
    final trailDate = reminder.reminderType == 1 ? displayedTime(reminder.medicineReminder!.dateList) : DateFormat('HH:mm a').format(reminder.generalReminder!.startDate);
    final title = reminder.reminderType == 1 ? reminder.medicineReminder!.medicineName : reminder.reminderType == 2 ? reminder.generalReminder!.title : reminder.notes!.title;
    final widget = reminder.reminderType == 1 ? MedicineReminderInfo(reminderId: reminder.reminderId) : null;
    return ListTile(
      onTap: ()=>routeTo(context, widget!),
      onLongPress: () async {
        await showModalBottomSheet(
            context: context,
            builder: (context){
              return Container(
                constraints: BoxConstraints(
                  minHeight: 150
                ),
                color: MyColors.white,
                padding: EdgeInsets.all(16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListTile(title: Text(reminder.generalReminder?.title ?? reminder.medicineReminder?.medicineName ?? reminder.notes?.title ?? '',style:  bh1,)),
                    Divider(),
                    ListTile(
                      leading: Icon(Icons.edit, color: MyColors.primary,),
                      title: Text('Edit'),
                    ),
                    Divider(),
                    ListTile(
                      onTap: () async {
                       await medNotifier.delReminder(reminderId: reminder.reminderId).whenComplete((){
                         ref.refresh(reminderProvider);
                         Navigator.pop(context);
                       });
                      },
                      leading: Icon(Icons.delete, color: MyColors.primary,),
                      title: Text('Delete'),
                    ),
                  ],
                ),
              );
            }
        );
      },
      shape: ContinuousRectangleBorder(
          borderRadius: BorderRadius.circular(24)
      ),
      tileColor: tileColor,
      leading: icon,
      title: Text(title,style: bh2,),
      subtitle: Text(subTitle!, style: br3, maxLines: 1,),
      trailing: reminder.reminderType == 3
          ? null
          : Container(
          decoration: BoxDecoration(
              color: trailColor,
              borderRadius: BorderRadius.circular(12)
          ),
          padding: EdgeInsets.all(8),
          child: Text(trailDate,style: wh4,)),
    );
  }

  String displayedTime(List<DateTime> dateList){
    final now = DateTime.now();
    final filteredTime = dateList.where((e)=>e.isAfter(now)).toList();
    filteredTime.sort((a,b)=>a.compareTo(b));
    final selectedDate = filteredTime.first;
    final displayDate = DateFormat('HH:mm a').format(selectedDate);
    return displayDate;
  }


}
