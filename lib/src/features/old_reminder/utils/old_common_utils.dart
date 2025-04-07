


import 'package:share_plus/share_plus.dart';
import 'package:shimmer/shimmer.dart';
import 'package:flutter/material.dart';
import '../../../core/resources/color_manager.dart';
import '../../../core/resources/font_manager.dart';
import '../../../core/resources/gap_manager.dart';

unFocus(BuildContext context) =>  FocusScope.of(context).unfocus();

MaterialPageRoute routeTo(context,widget){
  return MaterialPageRoute(builder: (context)=>widget);
}




ElevatedButton regularTextButton({
  String? text,
  Widget? child,
  required VoidCallback onPressed,
  Color? color,
  double? fontSize,
  Color? bgColor,
  double? radius
}){

  return ElevatedButton(
      style: ElevatedButton.styleFrom(
        // padding: EdgeInsets.zero,
          elevation: 0,
          backgroundColor: bgColor ?? MyColors.white,
          shape: ContinuousRectangleBorder(
              borderRadius: BorderRadius.circular(radius??16)
          )
      ),
      onPressed: onPressed,
      child: text != null
          ? Text(text,style: TextStyle(color: color ?? MyColors.black,fontSize: fontSize),)
          : child
  );

}



IconButton regularIconButton({
  required IconData icon,
  required VoidCallback onPressed,
  Color? color
}){

  return IconButton(

      onPressed: onPressed, icon: Icon(icon,color:color?? MyColors.black));

}


Image noFiles = Image.asset('assets/images/empty/noFiles.png');
Image noReminder = Image.asset('assets/images/empty/noReminder.png');


Shimmer loadingShimmer({required Widget child}){

  return Shimmer.fromColors(
    period: Duration(seconds: 1),
    baseColor: MyColors.grey,
    highlightColor: MyColors.darkGrey,
    child: child,
  );
}


class ShareExternal{


  static Future<void> share({required String link}) async {


    // Share the app link and message using the share dialog

    Share.share(link,subject: 'MOLESS');
  }


}


EdgeInsets horizontalPadding = const EdgeInsets.symmetric(horizontal: 16);
EdgeInsets eightPadding = const EdgeInsets.symmetric(horizontal: 8);
EdgeInsets allEightPadding = const EdgeInsets.symmetric(horizontal: 8,vertical: 8);
EdgeInsets allPadding = const EdgeInsets.symmetric(horizontal: 16,vertical: 12);


Widget NoFileWidget({
  required String text,
  required int type
}){
  return Center(
    child: SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          type == 1 ? noFiles : noReminder,
          h10,
          Text(text,style: bh2,)
        ],
      ),
    ),
  );
}


AppBar CommonBar({
  required String text,
  required bool backButton,
  required BuildContext context,
  List<Widget>? action
}){
  return AppBar(
    backgroundColor: MyColors.primaryLight,
    automaticallyImplyLeading: backButton,
    leading: backButton ? regularIconButton(
        icon: Icons.chevron_left,
        color: MyColors.primary,
        onPressed: (){
          Navigator.pop(context);
        }
    ) : null,
    centerTitle: true,
    title: Text(text,style: bh2,),
    actions: action ?? null,
  );
}