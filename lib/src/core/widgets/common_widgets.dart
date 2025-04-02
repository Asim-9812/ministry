




import 'package:flutter/material.dart';

import '../resources/color_manager.dart';
import '../resources/font_manager.dart';

AppBar commonAppBar(String text){
  return AppBar(
    backgroundColor: MyColors.primary,
    elevation: 0,
    automaticallyImplyLeading: false,
    title: Text(text, style: wh1,),
  );
}

AppBar commonNavBar(String text){
  return AppBar(
    backgroundColor: MyColors.primary,
    elevation: 0,
    iconTheme: IconThemeData(color: MyColors.white),
    automaticallyImplyLeading: true,
    title: Text(text, style: wh1,),
  );
}

Widget noItems(){
  return Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisAlignment: MainAxisAlignment.start,
    mainAxisSize: MainAxisSize.min,
    children: [
      Image.asset('assets/images/empty/noFiles.png'),
      Text('No Reminders',style: bh2,)
    ],
  );
}