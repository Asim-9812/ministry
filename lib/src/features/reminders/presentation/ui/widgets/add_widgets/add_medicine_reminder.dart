
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ministry/src/features/reminders/presentation/ui/widgets/add_widgets/medicine/save_medicine.dart';
import '../../../../../../core/resources/color_manager.dart';
import '../../../../../../core/resources/font_manager.dart';
import '../../../../../../core/resources/gap_manager.dart';
import '../../../../../../core/widgets/common_widgets.dart';
import 'medicine/duration_date.dart';
import 'medicine/medicine_image.dart';
import 'medicine/medicine_notes.dart';
import 'medicine/reminder_pattern.dart';
import 'medicine/strength_unit.dart';
import 'medicine/meals.dart';
import 'medicine/route_name.dart';
import 'medicine/frequency_time.dart';

class AddMedicineReminder extends ConsumerWidget {
  const AddMedicineReminder({super.key});

  @override
  Widget build(BuildContext context, ref) {
    return GestureDetector(
      onTap: ()=>FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: commonNavBar('Add medicine'),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0,horizontal: 16),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MealTabs(),
                h10,
                RouteName(),
                h10,
                StrengthUnit(),
                h10,
                FrequencyTime(),
                h10,
                DurationDate(),
                h10,
                MedicinePattern(),
                h10,
                MedicineImage(),
                h10,
                MedicineNotes(),
                h10,
                SaveMedicineButton()
              ],
            ),
          ),
        ),
      ),
    );

  }



}
