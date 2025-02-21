



import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../../../../core/resources/color_manager.dart';
import '../../../../../../../core/resources/font_manager.dart';
import '../../../../../../../core/resources/gap_manager.dart';
import '../../../../../data/add_medicine_controller.dart';
import '../../../../../data/medicine_data/pattern_list.dart';

class MedicinePattern extends ConsumerWidget {
  const MedicinePattern({super.key});

  @override
  Widget build(BuildContext context,ref) {
    final medNotifier = ref.read(addMedicineController.notifier);
    final patternId = ref.watch(addMedicineController).patternId;
    final selectedDays = ref.watch(addMedicineController).selectedDaysOfWeek;
    final intervalController = ref.watch(addMedicineController).interval;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              flex: 3,
              child: DropdownMenu(
                width: double.infinity,
                inputDecorationTheme: InputDecorationTheme(
                    isDense: true,
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(
                            color: MyColors.primary
                        )
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(
                            color: MyColors.primary
                        )
                    )
                ),
                leadingIcon: Icon(FontAwesomeIcons.calendarDays,color: MyColors.primary,),
                label: Text('Pattern', style: bh3,maxLines: 1,),
                textStyle: bh3,
                onSelected: (value) {
                  if(value != null){
                    medNotifier.changePattern(value);
                  }
                },
                menuStyle: MenuStyle(
                  alignment: Alignment.bottomCenter,
                  padding: WidgetStatePropertyAll(EdgeInsets.zero),
                ),
                dropdownMenuEntries: patternList.map((e)=>DropdownMenuEntry(value: e.id, label: e.pattern)).toList(),
              ),
            ),
            if(patternId == 3)
              w06,
            if(patternId == 3)
              Expanded(
                flex: 1,
                child: TextFormField(
                  controller: intervalController,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(horizontal: 8,vertical: 18),
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
                      labelText: 'Interval',
                      labelStyle: bh3
                  ),
                  validator: (value){
                    if(value!.trim().isEmpty){
                      return 'Interval is required';
                    }
                    try{
                      int.parse(value);
                    }catch(e){
                      return 'Invalid value';
                    }

                    return null;
                  },
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                ),
              )
          ],
        ),
        if(patternId == 2)
        h10,
        if(patternId == 2)
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: daysOfWeek.map((e){
                final selectedDay = selectedDays.contains(e.toLowerCase());
                return InkWell(
                  onTap: (){
                    medNotifier.updateDaysList(e.toLowerCase());
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: selectedDay ? MyColors.primary : MyColors.grey,
                      borderRadius: BorderRadius.circular(12)
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 16,vertical: 8),
                    margin: EdgeInsets.only(right: 4),
                    child: Text(e.substring(0,3),style: selectedDay? wh4: bh4,),
                  ),
                );
              }).toList(),
            ),
          )


          
      ],
    );
  }
}
