

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:ministry/src/core/resources/color_manager.dart';
import 'package:ministry/src/core/resources/font_manager.dart';
import 'package:ministry/src/core/widgets/common_widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ministry/src/features/reminders/application/controller/reminder_list_controller.dart';
import 'package:ministry/src/features/reminders/application/provider/reminders_providers.dart';
import 'package:ministry/src/features/reminders/domain/model/reminder_model.dart';
import 'package:ministry/src/features/reminders/domain/model/reminder_tag_model.dart';
import 'package:ministry/src/features/reminders/presentation/ui/widgets/fab/fab_widgets.dart';
import 'package:ministry/src/features/reminders/presentation/ui/widgets/no_items.dart';
import 'package:ministry/src/features/reminders/presentation/ui/widgets/reminder_list_tile.dart';
import '../../../../core/resources/gap_manager.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';


class Reminders extends ConsumerWidget {
  const Reminders({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final type = ref.watch(reminderController).reminderType;
    final reminderList = ref.watch(reminderProvider);
    return Scaffold(
      appBar: commonAppBar('Reminders'),
      floatingActionButtonLocation: ExpandableFab.location,
      floatingActionButton: ReminderFab(),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: reminderTagList.map((tag){
                  return InkWell(
                    onTap: (){
                      ref.read(reminderController.notifier).changeReminderType(tag.typeId);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: tag.typeId == type ? MyColors.primary: MyColors.grey,
                          borderRadius: BorderRadius.circular(12)
                      ),
                      margin: EdgeInsets.only(right: 4),
                      padding: EdgeInsets.symmetric(vertical: 8,horizontal: 16),
                      child: Text(tag.typeName,style:tag.typeId == type ?wr2: br2,),
                    ),
                  );
                }).toList(),
              ),
            ),
            h20,
            reminderList.isEmpty
                ? Center(child: NoReminderItems())
                : Expanded(
                  child: ListView.separated(
                  itemBuilder: (context,index)=>ReminderListTile(reminder: reminderList[index]),
                  separatorBuilder: (context, index) => h10,
                  itemCount: reminderList.length
                  ),
                )
          ],
        ),
      ),
    );
  }


  ListTile item(ReminderModel reminder){
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
    final trailDate = reminder.reminderType == 1 ? displayedTime(reminder.medicineReminder!.scheduledTime) : displayedTime([reminder.generalReminder!.startDate]);
    final title = reminder.reminderType == 1 ? reminder.medicineReminder!.medicineName : reminder.reminderType == 2 ? reminder.generalReminder!.title : reminder.notes!.title;
    return ListTile(
      onLongPress: () async {
        // await showModalBottomSheet(
        //     context: context,
        //     builder: (context){
        //       return Container(
        //
        //       )
        //     }
        // );
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

  String displayedTime(List<DateTime> scheduleTime){
    final now = DateTime.now();
    final filteredTime = scheduleTime.where((e)=>e.isAfter(now)).toList();
    filteredTime.sort((a,b)=>a.compareTo(b));
    final selectedDate = filteredTime.first;
    final displayDate = DateFormat('HH:mm a').format(selectedDate);
    return displayDate;
  }

}
