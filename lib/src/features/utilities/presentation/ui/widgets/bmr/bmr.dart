



import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ministry/src/core/resources/color_manager.dart';
import '../../../../../../core/resources/font_manager.dart';
import '../../../../../../core/resources/gap_manager.dart';
import '../../../../../../core/widgets/common_widgets.dart';
import '../../../../application/bmr_controllers/bmr_controller.dart';
import 'bmr_widgets/bmr_button.dart';
import 'bmr_widgets/bmr_slider.dart';
import 'bmr_widgets/bmr_user_stats.dart';


class Bmr extends ConsumerWidget {
  const Bmr({super.key});

  @override
  Widget build(BuildContext context, ref) {

    final gender = ref.watch(bmrController).genderIndex;
    final height = ref.watch(bmrController).height;

    return Scaffold(
        appBar: commonNavBar('BMR'),
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
                      BmrUserStats(),
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
                                    BmrSlider(),
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                                        child: Image.asset(
                                          gender == 0
                                              ? 'assets/icons/man.png'
                                              : 'assets/icons/woman.png',
                                          // width: 110,
                                          height: height < 91
                                              ? (91 * 91 / 150)
                                              : height > 243
                                              ? (243 * 243 / 90)
                                              : height > 210 ? (height * height / 90)
                                              : 170 < height && height < 210? (height * height / 85)
                                              : 60 < height && height < 170? (height * height / 75)
                                              : (height * height / 80),
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
                BmrButton(),
                h10,
              ],
            ),
          ),
        )
    );
  }
}
