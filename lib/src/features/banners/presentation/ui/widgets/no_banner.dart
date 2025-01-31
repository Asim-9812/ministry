




import 'package:flutter/material.dart';
import '../../../../../core/resources/color_manager.dart';
import '../../../../../core/resources/font_manager.dart';
import '../../../../../core/resources/gap_manager.dart';
import '../../../../../core/utils/toaster.dart';

class NoBanner extends StatelessWidget {
  const NoBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0),
      // color: Colors.black,
      width: double.infinity,
      height: 160,
      child: Stack(
          children: [
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                decoration: BoxDecoration(
                    color: MyColors.primaryLight,
                    borderRadius: BorderRadius.circular(12)
                ),
                width: double.infinity,
                height: 140,
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: ClipRRect(
                      borderRadius: BorderRadius.only(bottomRight:Radius.circular(12)),
                      child: Image.asset('assets/images/banner/wave.png',)),
                ),
              ),
            ),
            // Align(
            //     alignment: Alignment.bottomRight,
            //     child: Image.asset('assets/images/banner/wave.png',)),

            Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: const EdgeInsets.only(right: 20.0),
                  child: Image.asset('assets/images/banner/banner.png',),
                )),
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                // color: Colors.black,
                  width: 250,
                  height: 140,
                  padding: EdgeInsets.only(top: 30,right: 20,left: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Do you have symptoms of Covid-19?',style: bh2,),
                      h10,
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: MyColors.primary,
                          shape: ContinuousRectangleBorder(
                            borderRadius: BorderRadius.circular(30)
                          )
                        ),
                          onPressed: (){
                            Toaster.comingSoon();
                          },
                          child: Text('Contact a doctor',style: wh4,)
                      )
                    ],
                  )
              ),
            )
          ]
      ),
    );
  }
}
