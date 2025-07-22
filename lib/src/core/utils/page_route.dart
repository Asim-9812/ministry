




import 'package:flutter/material.dart';

void routeTo(BuildContext context, Widget widget){
  Navigator.push(context, MaterialPageRoute(builder: (context)=>widget));
}

void routeResetTo(BuildContext context, Widget widget){
  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>widget),(route) => false,);
}