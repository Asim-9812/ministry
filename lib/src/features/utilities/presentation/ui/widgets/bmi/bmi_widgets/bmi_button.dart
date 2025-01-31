


import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ministry/src/core/utils/toaster.dart';
import 'package:ministry/src/features/utilities/data/bmi/bmi_calculator.dart';

import '../../../../../../../core/resources/color_manager.dart';
import '../../../../../../../core/resources/font_manager.dart';
import '../../../../../application/bmi_controllers/bmi_controller.dart';
import 'bmi_dialog.dart';

class BmiButton extends ConsumerWidget {
  const BmiButton({super.key});

  @override
  Widget build(BuildContext context, ref) {

    final height = ref.watch(bmiController).height;
    final weight = ref.watch(bmiController).weight;
    final formKey = ref.watch(bmiController).formKey;

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
                  final calculateBmi = BmiCalculator.calculateBmi(weight: weight, heightInCm: height);

                  await showDialog(
                      context: context,
                      builder: (context){
                        return ZoomIn(
                            child: BmiDialog(bmi: calculateBmi));
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
