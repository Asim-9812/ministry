
import 'package:flutter/material.dart';
import 'package:ministry/src/core/utils/toaster.dart';

import '../../core/resources/color_manager.dart';
import '../../core/resources/font_manager.dart';
import '../../core/resources/gap_manager.dart';

class QuickServices extends StatelessWidget {
  const QuickServices({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: ServiceCard(name: 'Nearby\nhospital', color: MyColors.primary, icon: Icons.emergency)),
          w10,
          Expanded(child: ServiceCard(name: 'Get\nAppointments', color: MyColors.green, icon: Icons.add_call)),
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
        margin: EdgeInsets.zero,
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
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(icon,color: MyColors.white),
                  w10,
                  Text(name,style: wr1,maxLines: 2,)
                ],
              ),
            ),
          ),
        ),
      );
  }  
  
}
