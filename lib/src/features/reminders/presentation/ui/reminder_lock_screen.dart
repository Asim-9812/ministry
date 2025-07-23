

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ministry/src/core/resources/color_manager.dart';
import 'package:ministry/src/core/resources/gap_manager.dart';
import 'package:ministry/src/core/widgets/common_widgets.dart';
import 'package:ministry/src/features/dashboard/application/controller/dashboard_controller.dart';

class ReminderLockScreen extends ConsumerWidget {
  const ReminderLockScreen({super.key});

  @override
  Widget build(BuildContext context, ref) {

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.lock,size: 84,color: MyColors.grey,),
            h10,
            TextButton(
                style: TextButton.styleFrom(
                    backgroundColor: MyColors.primary,
                    foregroundColor: MyColors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)
                    )
                ),
                onPressed: (){
                  ref.read(dashboardController.notifier).changeNavIndex(3);
                  ref.read(dashboardController.notifier).changePageIndex(5);
                },
                child: Text('Please Log in to use the reminder'))
          ],
        ),
      ),
    );
  }
}
