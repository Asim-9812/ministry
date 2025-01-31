
import 'package:flutter/material.dart';
import 'package:ministry/src/core/resources/color_manager.dart';
import 'package:ministry/src/features/utilities/data/bmi/bmi_categories.dart';

import '../../../../../../../core/resources/font_manager.dart';
import '../../../../../../../core/resources/gap_manager.dart';
import '../../../../../domain/model/bmi_models.dart';




class BmiDialog extends StatelessWidget {
  final double bmi;
  const BmiDialog({required this.bmi,super.key});

  @override
  Widget build(BuildContext context) {

    // Find the indicated BMI category
    final indicatedBmi = bmiCategories.firstWhere(
          (e) => bmi >= e.min && bmi <= e.max,
      orElse: () => BmiContainer(
        label: "Not Found",
        min: 0,
        max: 0,
        activeColor: Colors.grey,
        inactiveColor: Colors.grey.withAlpha(128),
        flex: 1,
        desc: "BMI does not match any category.",
      ),
    );

    return Center(
      child: Container(
        padding: EdgeInsets.all(16),
        color: MyColors.white,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Display the bar visualization
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                children: bmiCategories
                    .map((e) => Expanded(
                  flex: e.flex,
                  child: Container(
                    height: 30,
                    color: (bmi >= e.min && bmi <= e.max)
                        ? e.activeColor
                        : e.inactiveColor,
                  ),
                ))
                    .toList(),
              ),
            ),
            h20,
            // Display details for the indicated BMI category,
            Text('BMI: $bmi',style: bh1,),
            Text(
              'Category: ${indicatedBmi.label}',
              style: bh2,
            ),
            h10,
            Text(
              '${indicatedBmi.desc}',
              style: br1,
              textAlign: TextAlign.center,
            ),
            h10,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                    style: TextButton.styleFrom(
                        backgroundColor: MyColors.primary,
                        shape: ContinuousRectangleBorder(
                            borderRadius: BorderRadius.circular(12)
                        )
                    ),
                    onPressed: (){
                      Navigator.pop(context);
                      FocusManager.instance.primaryFocus?.unfocus();
                    }, child: Text('OK',style: wh3,))
              ],
            )
          ],
        ),
      ),
    );
  }
}
