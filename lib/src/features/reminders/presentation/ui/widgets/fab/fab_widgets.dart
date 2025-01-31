

import 'package:flutter/material.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../add_widgets/add_general_reminder.dart';
import '../add_widgets/add_medicine_reminder.dart';
import '../add_widgets/add_notes.dart';
import 'fab_children_widget.dart';

import '../../../../../../core/resources/color_manager.dart';



class ReminderFab extends StatelessWidget {
  const ReminderFab({super.key});

  @override
  Widget build(BuildContext context) {
    return ExpandableFab(
      // key: _key,
      type: ExpandableFabType.up,
      childrenAnimation: ExpandableFabAnimation.none,
      distance: 70,
      overlayStyle: ExpandableFabOverlayStyle(
        color: MyColors.white.withValues(alpha: 50),
      ),
      openButtonBuilder: RotateFloatingActionButtonBuilder(
        child: const Icon(Icons.add),
        fabSize: ExpandableFabSize.regular,
        foregroundColor: MyColors.white,
        backgroundColor: MyColors.primary,
      ),
      closeButtonBuilder: DefaultFloatingActionButtonBuilder(
        child: const Icon(Icons.close),
        fabSize: ExpandableFabSize.small,
        foregroundColor: MyColors.primary,
        backgroundColor: MyColors.primaryLight,
        shape: const CircleBorder(),
      ),

      childrenOffset: Offset(-4, 0),
      children: const [
        FabChildrenWidget(name: 'Notes', icon: FontAwesomeIcons.noteSticky, pageRoute: AddNotes(),),
        FabChildrenWidget(name: 'General', icon: FontAwesomeIcons.stopwatch, pageRoute: AddGeneralReminder(),),
        FabChildrenWidget(name: 'Medicine', icon: FontAwesomeIcons.pills, pageRoute: AddMedicineReminder(),)
      ],

    );
  }
}
