



import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ministry/src/core/resources/color_manager.dart';
import 'package:ministry/src/features/dashboard/application/controller/dashboard_controller.dart';
import 'package:ministry/src/features/personal_services/presentation/ui/widgets/personal_services_list.dart';

import '../../../../../core/resources/font_manager.dart';

class BlurredServices extends ConsumerWidget {
  const BlurredServices({super.key});

  @override
  Widget build(BuildContext context, ref) {

    return Stack(
      children: [
        PersonalServicesList(),
        // An invisible container to block interactions
        Positioned.fill(
          child: GestureDetector(
            onTap: () {}, // Block all taps without triggering any action
            child: Container(
              color: Colors.transparent, // Invisible blocker
            ),
          ),
        ),
        ClipRect(
          child: BackdropFilter(
            filter: ui.ImageFilter.blur(
              sigmaX: 8.0,
              sigmaY: 7.0,
            ),
            child: Container(
              height: 300,
              width: double.infinity,
              padding: EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.person,color: MyColors.primary,),
                      TextButton(
                          onPressed: (){
                            ref.read(dashboardController.notifier).changePageIndex(5);
                            ref.read(dashboardController.notifier).changeNavIndex(3);
                          },
                          child: Text('SIGN IN',style: TextStyle(color: MyColors.primary,fontWeight: FontWeight.bold,fontSize: 24),)
                      ),
                    ],
                  ),
                  Text('required to access these services',style: bh2,),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
