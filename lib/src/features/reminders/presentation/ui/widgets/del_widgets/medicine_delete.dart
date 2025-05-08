


import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

import '../../../../../../core/resources/color_manager.dart';
import '../../../../../../core/resources/font_manager.dart';
import '../../../../../../core/resources/gap_manager.dart';
import '../../../../application/controller/medicine/medicine_reminder_notifier.dart';
import '../../../../application/provider/reminders_providers.dart';

Future<void> delMedicineDialog(BuildContext context, ref,int reminderId) async {

  final medNotifier = ref.watch(reminderNotifier.notifier);

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
                                  await medNotifier.delMedReminder(reminderId: reminderId).whenComplete((){
                                    ref.refresh(reminderProvider);
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

}
Future<void> delGeneralDialog(BuildContext context, ref,int reminderId) async {

  final genNotifier = ref.watch(reminderNotifier.notifier);

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
                                  await genNotifier.delGenReminder(reminderId: reminderId).whenComplete((){
                                    ref.refresh(reminderProvider);
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

}