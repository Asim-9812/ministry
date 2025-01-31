




import 'package:ministry/src/features/utilities/domain/model/bmr_model.dart';

class ActivityLevel{


  static List<BmrModel> activityLevels({required double calories}) {


    List<BmrModel> activityList = [
      BmrModel(
          activityLevel: 'Sedentary: little or no exercise',
          calories: '${calories.round() + 300}'
      ),
      BmrModel(
          activityLevel: 'Exercise 1-3 times/week',
          calories: '${calories.round() + 673}'
      ),
      BmrModel(
          activityLevel: 'Exercise 4-5 times/week',
          calories: '${calories.round() + 836}'
      ),
      BmrModel(
          activityLevel: 'Daily exercise or intense exercise 3-4 times/week',
          calories: '${calories.round() + 990}'
      ),
      BmrModel(
          activityLevel: 'Intense exercise 6-7 times/week',
          calories: '${calories.round() + 1307}'
      ),
      BmrModel(
          activityLevel: 'Very intense exercise daily, or physical job',
          calories: '${calories.round() + 1624}'
      ),
    ];

    return activityList;

  }

}