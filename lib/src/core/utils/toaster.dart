


import 'package:fluttertoast/fluttertoast.dart';
import 'package:ministry/src/core/resources/color_manager.dart';

class Toaster{

  static void success(String text){
    Fluttertoast.showToast(
        msg: text,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: MyColors.green,
        textColor: MyColors.white,
        fontSize: 16.0
    );
  }

  static void error(String text){
    Fluttertoast.showToast(
        msg: text,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: MyColors.red,
        textColor: MyColors.white,
        fontSize: 16.0
    );
  }

  static void comingSoon(){
    Fluttertoast.showToast(
        msg: 'Coming soon...',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: MyColors.grey,
        textColor: MyColors.black,
        fontSize: 16.0
    );
  }

}