import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ministry/src/core/utils/toaster.dart';

import '../../core/resources/color_manager.dart';
import '../../core/resources/font_manager.dart';
import '../../core/resources/gap_manager.dart';

class QuickServices extends StatelessWidget {
  const QuickServices({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          w16,
          ServiceCard(name: 'E-Ticket', color: MyColors.primary, icon: CupertinoIcons.tickets),
          ServiceCard(name: 'Online\nConsultation', color: MyColors.green, icon: Icons.computer),
          ServiceCard(name: 'Second\nOpinion', color: MyColors.yellow, icon: Icons.group),
          w12,
        ],
      ),
    );
  }
  
  Card ServiceCard({
    required String name,
    required Color color,
    required IconData icon
  }){
      return Card(
        margin: EdgeInsets.only(right: 4),
        elevation: 0,
        child: InkWell(
          onTap: (){
            Toaster.comingSoon();
          },
          child: Container(
            decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(10)
            ),
            height: 70,
            padding: EdgeInsets.only(right: 36,left: 18),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(icon,color: MyColors.white,size: 30,),
                w10,
                Text(name,style: wr1,)
              ],
            ),
          ),
        ),
      );
  }  
  
}
