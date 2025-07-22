
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ministry/src/core/utils/page_route.dart';
import 'package:ministry/src/core/utils/toaster.dart';
import 'package:ministry/src/features/enquiry/presentation/ui/enquiry.dart';

import '../../core/resources/color_manager.dart';
import '../../core/resources/font_manager.dart';
import '../../core/resources/gap_manager.dart';
import '../dashboard/application/controller/dashboard_controller.dart';
import '../login/application/login_notifier.dart';

class QuickServices extends ConsumerWidget {
  const QuickServices({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final authState = ref.watch(loginNotifierProvider);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: ListTile(
        tileColor: MyColors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: MyColors.grey)
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 16),
        leading : Icon(Icons.add_call,color: MyColors.primary),
        title : Text('Get an appointment', style : bh2),
        trailing : TextButton(
          style : TextButton.styleFrom(
            backgroundColor : MyColors.primary,
            foregroundColor : MyColors.white,
            shape : RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12)
            )
          ),
          onPressed : (){

            if(authState.user == null){
              ref.read(dashboardController.notifier).changeNavIndex(3);
              ref.read(dashboardController.notifier).changePageIndex(4);
              Toaster.message('Please log in to get an appointment.');

            }
            else{
              routeTo(context, Enquiry());
            }


          },
          // onPressed : () async {
          //   await ConnectIpsService().connectIps();
          // },
          child : Text('Click Here')
        )
      )


      // Row(
      //   mainAxisAlignment: MainAxisAlignment.center,
      //   crossAxisAlignment: CrossAxisAlignment.center,
      //   children: [
      //     Expanded(child: ServiceCard(name: 'Enquire Hospital', color: MyColors.primary, icon: Icons.emergency, onTap: ()=> routeTo(context, CountryPicker()))),
      //     w10,
      //     Expanded(child: ServiceCard(name: 'Get Appointments', color: MyColors.green, icon: Icons.add_call)),
      //   ],
      // ),
    );
  }
  
  Card ServiceCard({
    required String name,
    required Color color,
    required IconData icon,
    VoidCallback? onTap
  }){
      return Card(
        margin: EdgeInsets.zero,
        elevation: 0,
        child: InkWell(
          onTap: onTap ?? ()=>Toaster.comingSoon(),
          child: Container(
            decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(10)
            ),
            padding: EdgeInsets.symmetric(vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon,color: MyColors.white),
                h10,
                Text(name,style: wr1,maxLines: 2,textAlign: TextAlign.center,)
              ],
            ),
          ),
        ),
      );
  }  
  
}
