

import 'package:flutter/material.dart';
import 'package:ministry/src/core/resources/color_manager.dart';
import 'package:ministry/src/core/resources/font_manager.dart';
import 'package:ministry/src/core/widgets/common_widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ministry/src/features/reminders/presentation/ui/widgets/fab/fab_widgets.dart';
import '../../../../core/resources/gap_manager.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';


class Reminders extends StatelessWidget {
  const Reminders({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> tags = ['All', 'Medicine', 'General', 'Notes'];
    return Scaffold(
      appBar: commonAppBar('Reminders'),
      floatingActionButtonLocation: ExpandableFab.location,
      floatingActionButton: ReminderFab(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: tags.map((tag){
                  return Container(
                    decoration: BoxDecoration(
                        color: tag == 'All' ? MyColors.primary: MyColors.grey,
                        borderRadius: BorderRadius.circular(12)
                    ),
                    margin: EdgeInsets.only(right: 4),
                    padding: EdgeInsets.symmetric(vertical: 8,horizontal: 16),
                    child: Text(tag,style:tag == 'All' ?wr2: br2,),
                  );
                }).toList(),
              ),
            ),
            h20,
            ListTile(
              shape: ContinuousRectangleBorder(
                  borderRadius: BorderRadius.circular(24)
              ),
              tileColor: MyColors.primary.withValues(alpha: 200),
              leading: FaIcon(FontAwesomeIcons.pills,color: MyColors.primary,),
              title: Text('CTZ',style: bh2,),
              subtitle: Text('once',style: bh4,),
              trailing: Container(
                  decoration: BoxDecoration(
                      color: MyColors.primary,
                      borderRadius: BorderRadius.circular(12)
                  ),
                  padding: EdgeInsets.all(8),
                  child: Text('06:45 AM',style: wh4,)),
            ),
            h10,
            ListTile(
              shape: ContinuousRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
              tileColor: MyColors.green.withValues(alpha: 200),
              leading: FaIcon(FontAwesomeIcons.stopwatch,color: MyColors.green,),
              title: Text('That task',style: bh2,),
              subtitle: Text('Once',style: bh4,),
              trailing: Container(
                  decoration: BoxDecoration(
                      color: MyColors.green,
                      borderRadius: BorderRadius.circular(12)
                  ),
                  padding: EdgeInsets.all(8),
                  child: Text('06:00 AM',style: wh4,)),
              // trailing: Text('06:45 AM',style: bh3,),
            ),
            h10,
            ListTile(
              shape: ContinuousRectangleBorder(
                  borderRadius: BorderRadius.circular(24)
              ),
              tileColor: MyColors.yellow.withValues(alpha: 2003),
              leading: FaIcon(FontAwesomeIcons.solidNoteSticky,color: MyColors.yellow,),
              title: Text('Sample Title',style: bh2,),
              subtitle: Text('This is a sample text note for a user to see when the note is in...',style: bh4,),
              // trailing: Text('06:45 AM',style: bh3,),
            ),
          ],
        ),
      ),
    );
  }
}
