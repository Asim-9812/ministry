


import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ministry/src/core/resources/color_manager.dart';
import 'package:ministry/src/core/utils/page_route.dart';
import 'package:ministry/src/core/utils/toaster.dart';
import 'package:ministry/src/features/banners/presentation/ui/banners.dart';
import 'package:ministry/src/features/dashboard/application/controller/dashboard_controller.dart';
import 'package:ministry/src/features/health_tips/presentation/ui/health_tips.dart';
import 'package:ministry/src/features/personal_services/presentation/ui/personal_services.dart';
import 'package:ministry/src/features/public_notices/presentation/ui/widget/public_notice_marquee.dart';
import 'package:ministry/src/features/quick_services/services.dart';
import 'package:ministry/src/features/support/presentation/ui/support.dart';
import '../../../../core/resources/gap_manager.dart';
import '../../../scanner/presentation/ui/scanner.dart';




class Homepage extends ConsumerWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context,ref) {

    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        heroTag: 'homeFloat',
        backgroundColor: MyColors.primary,
        onPressed: ()=>routeTo(context, Support()),
        child: Icon(Icons.support_agent,color: MyColors.white,),
      ),
      body: SafeArea(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: MyColors.primary,
                  image: DecorationImage(image: AssetImage('assets/images/cover.png'),alignment: Alignment.bottomRight,fit: BoxFit.contain)
                ),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children:[
                      Image.asset('assets/images/logo.png',width: 80,height: 80,),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.start,
                      //   crossAxisAlignment: CrossAxisAlignment.center,
                      //   children: [
                      //     Text('Take',style: TextStyle(fontSize: 40,color: MyColors.primary,fontWeight: FontWeight.w500,fontFamily: 'Josefin',letterSpacing: -1),),
                      //     Text('Care',style: TextStyle(fontSize: 40,color: MyColors.secondary,fontWeight: FontWeight.w500,fontFamily: 'Josefin',letterSpacing: -1),),
                      //   ],
                      // ),
                      InkWell(
                        onTap: (){
                          ref.read(dashboardController.notifier).changeNavIndex(3);
                          ref.read(dashboardController.notifier).changePageIndex(5);
                        },
                        child: Card(
                          margin: EdgeInsets.only(right: 8),
                          elevation: 0,
                          shape: CircleBorder(
                              side: BorderSide(
                                  width: 2,
                                  color: MyColors.lightBlue
                              )
                          ),
                          child: CircleAvatar(
                            backgroundColor: MyColors.white,
                            radius: 24,
                            child: Icon(Icons.person,color: MyColors.primary,),
                          ),
                        ),
                      )
                    ]
                ),
              ),
              PublicNoticeMarquee(),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      h10,
                      Banners(),
                      h20,
                      QuickServices(),
                      h20,
                      HealthTips(),
                      h10,
                      PersonalServices(),
                      h100
                    ],
                  ),
                ),
              )
            ],
          )
      ),

    );
  }
}
