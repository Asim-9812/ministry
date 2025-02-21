




import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import '../../../../../../../core/resources/color_manager.dart';
import '../../../../../../../core/resources/font_manager.dart';
import '../../../../../../../core/resources/gap_manager.dart';
import '../../../../../data/add_medicine_controller.dart';

class DurationDate extends ConsumerWidget {
  const DurationDate({super.key});

  @override
  Widget build(BuildContext context,ref) {
    final medDurationController = ref.watch(addMedicineController).medDuration;
    final startDateController = ref.watch(addMedicineController).startDate;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: TextFormField(
            controller: medDurationController,
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
                prefixIcon: Icon(FontAwesomeIcons.stopwatch,color: MyColors.primary,),
                labelText: 'Medicine Duration',
                labelStyle: bh3
            ),
            validator: (value){
              if(value!.trim().isEmpty){
                return 'Duration is required';
              }
              try{
                int.parse(value);
              }catch(e){
                return 'Invalid value';
              }

              return null;
            },
            autovalidateMode: AutovalidateMode.onUserInteraction,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly
            ],
          ),
        ),
        w06,
        Expanded(
          child: TextFormField(
            controller: startDateController,
            decoration: InputDecoration(
                isDense: true,
                border: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: MyColors.primary
                    ),
                    borderRadius: BorderRadius.circular(8)
                ),
                focusedBorder: OutlineInputBorder(
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
                prefixIcon: Icon(FontAwesomeIcons.calendarDay,color: MyColors.primary,),
                labelText: 'Start Date',
                labelStyle: bh3
            ),
            readOnly: true,
            onTap: () async {
              final now = DateTime.now();
              DateTime? selectedDate = await showDatePicker(
                  context: context,
                  firstDate: now,
                  lastDate: now.add(Duration(days: 365))
              );
              if(selectedDate != null){
                final date = DateFormat('yyyy-MM-dd').format(selectedDate);
                startDateController.text = date;
              }
            },
          ),
        ),
      ],
    );
  }
}
