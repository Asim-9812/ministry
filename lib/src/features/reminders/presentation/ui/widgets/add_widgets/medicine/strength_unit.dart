



import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../../../../core/resources/color_manager.dart';
import '../../../../../../../core/resources/font_manager.dart';
import '../../../../../../../core/resources/gap_manager.dart';
import '../../../../../data/add_medicine_controller.dart';
import '../../../../../data/medicine_data/unit_list.dart';
import '../../../../../domain/medicine_reminder_model.dart';

class StrengthUnit extends ConsumerWidget {
  const StrengthUnit({super.key});

  @override
  Widget build(BuildContext context,ref) {
    final medNotifier = ref.read(addMedicineController.notifier);
    final selectedUnitId = ref.watch(addMedicineController).unitId;
    final selectedUnit = medicineUnitList.singleWhere((e)=>e.id == selectedUnitId,orElse: ()=>MedicineUnit(id: 0, name: 'Unit'));

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
            child: TextFormField(
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
                  return 'Invalid value';
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
                  color: MyColors.primary
              )
          ),
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 8),
          child: PopupMenuButton(
            position: PopupMenuPosition.under,
            constraints: BoxConstraints(
                maxHeight: 200
            ),
            popUpAnimationStyle: AnimationStyle.noAnimation,
            child: Row(
              children: [
                Text(selectedUnit.name,style: bh3,),
                Icon(Icons.arrow_drop_down)
              ],
            ),
            itemBuilder: (context) => medicineUnitList.map((e)=>
                PopupMenuItem(
                    onTap: (){
                      medNotifier.changeUnit(e.id);
                    },
                    child: Text(e.name)
                )).toList(),
          ),
        ),
      ],
    );
  }
}
