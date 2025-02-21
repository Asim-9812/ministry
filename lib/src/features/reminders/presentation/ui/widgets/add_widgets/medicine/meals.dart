

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../../core/resources/color_manager.dart';
import '../../../../../../../core/resources/font_manager.dart';
import '../../../../../../../core/resources/gap_manager.dart';
import '../../../../../data/add_medicine_controller.dart';
import '../../../../../data/medicine_data/meal_list.dart';

class MealTabs extends ConsumerWidget {
  const MealTabs({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final medNotifier = ref.read(addMedicineController.notifier);
    final selectedMeal = ref.watch(addMedicineController).mealId;
    return Row(
      children: [
        Expanded(
            child: ListTile(
              onTap: (){
                medNotifier.changeMealType(1);
              },
              shape: ContinuousRectangleBorder(
                side: BorderSide(
                    color: selectedMeal == mealList[0].id? MyColors.primary : MyColors.white
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              tileColor: selectedMeal == mealList[0].id? MyColors.primaryLight : MyColors.lightGrey,
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.set_meal,color: selectedMeal == mealList[0].id? MyColors.primary : MyColors.black,),
                  h10,
                  Text('Before Meal',style: bh3,),
                ],
              ),
            )
        ),
        w10,
        Expanded(
            child: ListTile(
              onTap: (){
                medNotifier.changeMealType(2);
              },
              shape: ContinuousRectangleBorder(
                side: BorderSide(
                    color: selectedMeal == mealList[1].id? MyColors.primary : MyColors.white
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              tileColor: selectedMeal == mealList[1].id? MyColors.primaryLight : MyColors.lightGrey,
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.set_meal,color: selectedMeal == mealList[1].id? MyColors.primary : MyColors.black,),
                  h10,
                  Text('After Meal',style: bh3,),
                ],
              ),
            )
        ),
      ],
    );
  }
}
