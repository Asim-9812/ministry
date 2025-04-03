

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../core/controllers/notification_controller.dart';
import '../../../../../core/resources/color_manager.dart';
import '../../../../../core/resources/font_manager.dart';
import '../../../../../core/resources/gap_manager.dart';

void askPermissionDialog(BuildContext context) async {

  final prefs = await SharedPreferences.getInstance();
  bool hasAskedPermission = prefs.getBool('hasAskedNotificationPermission') ?? false;

  if (!hasAskedPermission) {
    bool userAuthorized = false;
    final hasPermission = await NotificationController.checkPermission();

    if(!hasPermission){

      await showDialog(
        context: context,
        builder: (BuildContext ctx) {
          return Center(
            child: Container(
              color: MyColors.white,
              padding: EdgeInsets.symmetric(horizontal: 16,vertical: 8),
              child: Material(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Enable Notifications', style: bh2,),
                    Divider(),
                    Text('Please enable notifications to receive important reminders and reports in a timely manner.', style: br1,),
                    h20,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                            style: TextButton.styleFrom(
                                shape: ContinuousRectangleBorder(
                                    borderRadius: BorderRadius.circular(24)
                                ),
                                backgroundColor: MyColors.red,
                                foregroundColor: MyColors.white
                            ),
                            onPressed: (){
                              prefs.setBool('hasAskedNotificationPermission', true);
                              Navigator.pop(context);
                            },
                            child: Text('Deny')
                        ),
                        w10,
                        TextButton(
                            style: TextButton.styleFrom(
                                shape: ContinuousRectangleBorder(
                                    borderRadius: BorderRadius.circular(24)
                                ),
                                backgroundColor: MyColors.primary,
                                foregroundColor: MyColors.white
                            ),
                            onPressed: (){
                              userAuthorized = true;
                              prefs.setBool('hasAskedNotificationPermission', true);
                              Navigator.pop(context);
                            },
                            child: Text('Allow')
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        },
      );

      if(userAuthorized) await NotificationController.requestPermission();



    }
  }

  else{
    await NotificationController.startListeningNotificationEvents();
  }

}
