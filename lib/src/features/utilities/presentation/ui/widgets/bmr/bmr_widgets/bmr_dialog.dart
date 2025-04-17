
import 'package:flutter/material.dart';
import 'package:ministry/src/core/resources/color_manager.dart';
import 'package:ministry/src/features/utilities/domain/model/bmr_model.dart';

import '../../../../../../../core/resources/font_manager.dart';
import '../../../../../../../core/resources/gap_manager.dart';




class BmrDialog extends StatelessWidget {
  final double bmr;
  final List<BmrModel> activityList;
  const BmrDialog({required this.bmr, required this.activityList,super.key});

  @override
  Widget build(BuildContext context) {


    return Center(
      child: Container(
        padding: EdgeInsets.all(16),
        margin: EdgeInsets.symmetric(vertical: 24),
        color: MyColors.white,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Your BMR: ${bmr.round()} Kcal/day',style: bh2,),
            h10,
            Text('According to your lifestyle and activities your bmr may vary to one of the following :',style: bh3,),

            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: activityList.map((e){
                    return Column(
                      children: [
                        Material(
                          child: ListTile(
                            tileColor: MyColors.white,
                            title: Text(e.activityLevel,style: bh3,),
                            subtitle: Text('${e.calories} Kcal/day',style: bh2,),
                          ),
                        ),
                        Divider(
                          indent: 24,
                          endIndent: 24,
                          thickness: 0.5,
                          height: 0,
                        )
                      ],
                    );
                  }).toList(),
                ),
              ),
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
                    },
                    child: Text('OK',style: wh3,)
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
