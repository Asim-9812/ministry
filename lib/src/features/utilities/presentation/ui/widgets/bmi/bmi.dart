



import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ministry/src/core/resources/color_manager.dart';
import 'package:ministry/src/features/utilities/application/bmi_controllers/bmi_controller.dart';
import '../../../../../../core/resources/font_manager.dart';
import '../../../../../../core/resources/gap_manager.dart';
import '../../../../../../core/widgets/common_widgets.dart';
import 'bmi_widgets/bmi_button.dart';
import 'bmi_widgets/bmi_slider.dart';
import 'bmi_widgets/bmi_user_stats.dart';

class Bmi extends ConsumerWidget {
  const Bmi({super.key});

  @override
  Widget build(BuildContext context, ref) {

    final gender = ref.watch(bmiController).genderIndex;
    final height = ref.watch(bmiController).height;

    return Scaffold(
      appBar: commonNavBar('BMI'),
      body: GestureDetector(
        onTap: (){
          FocusScope.of(context).unfocus();
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BmiUserStats(),
                    w10,
                    Expanded(
                      flex: 2,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: MyColors.lightGrey,
                        ),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('Height',style: bh2,),
                            ),
                            Expanded(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  BmiSlider(),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                                      child: Image.asset(
                                        gender == 0
                                            ? 'assets/icons/man.png'
                                            : 'assets/icons/woman.png',
                                        // width: 110,
                                        height: height < 91
                                            ? (91 * 91 / 120)
                                            : height > 243
                                            ? (243 * 243 / 120)
                                            : (height * height / 120),
                                        fit: BoxFit.fitHeight,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              h10,
              BmiButton(),
              h10,
            ],
          ),
        ),
      )
    );
  }
}
