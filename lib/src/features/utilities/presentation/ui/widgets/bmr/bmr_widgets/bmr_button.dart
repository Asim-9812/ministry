


import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ministry/src/core/utils/toaster.dart';
import 'package:ministry/src/features/utilities/application/bmr_controllers/bmr_controller.dart';
import 'package:ministry/src/features/utilities/data/bmr/bmr_activity_levels.dart';
import 'package:ministry/src/features/utilities/data/bmr/bmr_calculator.dart';

import '../../../../../../../core/resources/color_manager.dart';
import '../../../../../../../core/resources/font_manager.dart';
import 'bmr_dialog.dart';

class BmrButton extends ConsumerWidget {
  const BmrButton({super.key});

  @override
  Widget build(BuildContext context, ref) {

    final genderIndex = ref.watch(bmrController).genderIndex;
    final age = ref.watch(bmrController).age;
    final height = ref.watch(bmrController).height;
    final weight = ref.watch(bmrController).weight;
    final formKey = ref.watch(bmrController).formKey;

    return Row(
      children: [
        Expanded(
          child: TextButton(
              style: TextButton.styleFrom(
                  shape: ContinuousRectangleBorder(
                      borderRadius: BorderRadius.circular(20)
                  ),
                  backgroundColor: MyColors.primary
              ),
              onPressed: () async {


                if(formKey.currentState!.validate()){
                  final calories = BmrCalculator.calculateBmr(genderIndex: genderIndex, weight: weight, height: height, age: age);
                  final activityList = ActivityLevel.activityLevels(calories: calories);

                  await showDialog(
                      context: context,
                      builder: (context){
                        return ZoomIn(
                            child: BmrDialog(bmr: calories, activityList: activityList,));
                      }
                  );
                }
                else{
                  Toaster.error('Invalid Weight Type');
                }


              },
              child: Text('Calculate',style: wh2,)
          ),
        ),
      ],
    );
  }
}
