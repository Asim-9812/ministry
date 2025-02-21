

import 'package:flutter/material.dart';
import 'package:ministry/src/core/resources/color_manager.dart';

import '../../../../../../../core/resources/font_manager.dart';

class SaveMedicineButton extends StatelessWidget {
  const SaveMedicineButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextButton(
              style: TextButton.styleFrom(
                backgroundColor: MyColors.primary,
                shape: ContinuousRectangleBorder(
                  borderRadius: BorderRadius.circular(12)
                )
              ),
              onPressed: (){}, 
              child: Text('Save',style: wh2,)),
        ),
      ],
    );
  }
}
