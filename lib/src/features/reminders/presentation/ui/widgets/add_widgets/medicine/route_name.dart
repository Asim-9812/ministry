



import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../../../../core/resources/color_manager.dart';
import '../../../../../../../core/resources/font_manager.dart';
import '../../../../../../../core/resources/gap_manager.dart';
import '../../../../../application/controller/add_medicine_controller.dart';
import '../../../../../data/medicine_data/route_list.dart';
import '../../../../../domain/model/medicine_reminder_model.dart';


class RouteName extends ConsumerWidget {
  const RouteName({super.key});

  @override
  Widget build(BuildContext context,ref) {
    final medNotifier = ref.read(addMedicineController.notifier);
    final medNameController = ref.watch(addMedicineController).medName;
    final selectedRouteId = ref.watch(addMedicineController).routeId;
    final routeError = ref.watch(addMedicineController).routeError;
    final selectedRoute = medicineRouteList.singleWhere((e)=>e.id == selectedRouteId,orElse: ()=>MedicineRoute(id: 0, name: 'Route'));

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                  color: routeError ? MyColors.red : MyColors.primary
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
                Text(selectedRoute.name,style: bh3,),
                Icon(Icons.arrow_drop_down)
              ],
            ),
            itemBuilder: (context) => medicineRouteList.map((e)=>
                PopupMenuItem(
                    onTap: (){
                      medNotifier.changeRouteType(e.id);
                      ref.read(addMedicineController.notifier).routeHasError(false);
                    },
                    child: Text(e.name)
                )).toList(),
          ),
        ),
        w06,
        Expanded(
          child: TextFormField(
            controller: medNameController,
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
                prefixIcon: Icon(FontAwesomeIcons.pills,color: MyColors.primary,),
                labelText: 'Medicine Name',
                labelStyle: bh3,
            ),
            validator: (value) {
              if(value == null || value.trim().isEmpty){
                return 'Name is required';
              }
              return null;
            },
            autovalidateMode: AutovalidateMode.onUserInteraction,
          ),
        ),

      ],
    );
  }
}
