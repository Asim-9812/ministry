





import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ministry/src/features/reminders/application/controller/add_medicine_controller.dart';

import '../../../../../../../core/resources/color_manager.dart';
import '../../../../../../../core/resources/font_manager.dart';

class MedicineNotes extends ConsumerWidget {
  const MedicineNotes({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final controller = ref.watch(addMedicineController).notes;
    return TextFormField(
      controller: controller,
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
          prefixIcon: Icon(FontAwesomeIcons.notesMedical,color: MyColors.primary,),
          labelText: 'Notes (Optional)',
          labelStyle: bh3
      ),
      maxLines: null,
    );
  }
}
