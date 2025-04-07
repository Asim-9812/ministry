



import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';

import '../model/general_model.dart';





final genReminderProvider = StateProvider((ref) => GeneralReminderServices.getGeneralList());
final generalProvider = StateProvider.family((ref,int id) => GeneralReminderServices.getGeneralById(id));


class GeneralReminderServices{



  static List<GeneralModel> getGeneralList(){

    final generalList = Hive.box<GeneralModel>('generals').values.toList();

    return generalList ;

  }


  static GeneralModel getGeneralById(int id){

    final generalList = Hive.box<GeneralModel>('generals').values.toList();

    final general = generalList.firstWhere((element) => element.reminderId == id);

    return general ;

  }


  static Either<String, String> addGeneral({required GeneralModel general}){

    try{
      final generalBox = Hive.box<GeneralModel>('generals');

      generalBox.add(general);

      return Right('Reminder added');

    } catch(e){
      return Left('$e');
    }

  }

  static Either<String, String> editGeneral({required GeneralModel general}){

    try{
      final generalBox = Hive.box<GeneralModel>('generals');

      final generalList = Hive.box<GeneralModel>('generals').values.toList();

      final updateIndex = generalList.indexWhere((element) => element.reminderId == general.reminderId);

      generalBox.putAt(updateIndex, general);

      return Right('Reminder Updated');

    } catch(e){
      return Left('$e');
    }

  }


  static Either<String, String> delGeneral({required GeneralModel general}){

    try{
      final generalBox = Hive.box<GeneralModel>('generals');

      final generalList = Hive.box<GeneralModel>('generals').values.toList();

      final updateIndex = generalList.indexWhere((element) => element.reminderId == general.reminderId);

      generalBox.deleteAt(updateIndex);

      return Right('Reminder Deleted');

    } catch(e){
      return Left('$e');
    }

  }


}