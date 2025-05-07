



import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../../../../core/resources/color_manager.dart';
import '../../../../../../../core/resources/font_manager.dart';
import '../../../../../../../core/resources/gap_manager.dart';
import '../../../../../application/controller/medicine/add_medicine_controller.dart';
import '../../../../../data/medicine_data/unit_list.dart';
import '../../../../../domain/model/medicine_reminder_model.dart';

class StrengthUnit extends ConsumerWidget {
  const StrengthUnit({super.key});

  @override
  Widget build(BuildContext context,ref) {
    final medNotifier = ref.read(addMedicineController.notifier);
    final selectedUnitId = ref.watch(addMedicineController).unitId;
    final strengthController = ref.watch(addMedicineController).strengthController;
    final unitError = ref.watch(addMedicineController).unitError;
    final selectedUnit = medicineUnitList.singleWhere((e)=>e.unitId == selectedUnitId,orElse: ()=>MedicineUnit(unitId: 0, units: 'Unit'));

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
            child: TextFormField(
              controller: strengthController,
              decoration: InputDecoration(
                isDense: true,
                border: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: MyColors.primary
                    ),
                    borderRadius: BorderRadius.circular(8)
                ),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: MyColors.primary
                    ),
                    borderRadius: BorderRadius.circular(8)
                ),
                prefixIcon: Icon(FontAwesomeIcons.glassWaterDroplet,color: MyColors.primary,),
                labelText: 'Strength',
                labelStyle: bh3,
              ),
              validator: (value){
                if(value!.trim().isEmpty){
                  return 'Strength is required';
                }
                try{
                  double.parse(value);
                }catch(e){
                  return 'Invalid Type';
                }

                return null;
              },
              autovalidateMode: AutovalidateMode.onUserInteraction,

            )),
        w06,
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                  color: unitError ? MyColors.red : MyColors.primary
              )
          ),
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 8),
          child: PopupMenuButton(
            initialValue: selectedUnit,
            position: PopupMenuPosition.under,
            constraints: BoxConstraints(
                maxHeight: 200
            ),
            popUpAnimationStyle: AnimationStyle.noAnimation,
            child: Row(
              children: [
                Text(selectedUnit.units,style: bh3,),
                Icon(Icons.arrow_drop_down)
              ],
            ),
            itemBuilder: (context) => medicineUnitList.map((e)=>
                PopupMenuItem(
                    onTap: (){
                      medNotifier.changeUnit(e.unitId);
                      ref.read(addMedicineController.notifier).unitHasError(false);
                    },
                    child: Text(e.units)
                )).toList(),
          ),
        ),
      ],
    );
  }
}
