



import 'package:flutter/material.dart';
import 'package:ministry/src/core/resources/color_manager.dart';

import '../../../../../core/resources/font_manager.dart';

void showQrDetails(context,String values) async{

  await showModalBottomSheet(context: context, builder: (context){

    return Container(
      constraints: BoxConstraints(
        minHeight: 200
      ),
      decoration: BoxDecoration(
        color: MyColors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(12))
      ),
      padding: EdgeInsets.symmetric(horizontal: 16,vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Result',style: bh2,),
          Text(values,style: br1,),
        ],
      ),
    );

  });

}