

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
import 'package:ministry/src/features/reminders/presentation/ui/reminder_lock_screen.dart';
import 'package:ministry/src/features/reminders/presentation/ui/widgets/fab/fab_widgets.dart';
import 'package:ministry/src/features/reminders/presentation/ui/widgets/no_items.dart';
import 'package:ministry/src/features/reminders/presentation/ui/widgets/reminder_list_tile.dart';
import '../../../../core/resources/gap_manager.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';

import '../../../login/application/login_notifier.dart';


class Reminders extends ConsumerWidget {
  const Reminders({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final type = ref.watch(reminderController).reminderType;
    final reminderList = ref.watch(reminderProvider);
    final authState = ref.watch(loginNotifierProvider);
    return Scaffold(
      appBar: commonAppBar('Reminders'),
      floatingActionButtonLocation: ExpandableFab.location,
      floatingActionButton: authState.user == null ? null : ReminderFab(),
      body: authState.user == null
          ? ReminderLockScreen()

          : Padding(
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


}
