


import 'package:flutter/material.dart';
import 'package:ministry/src/core/widgets/common_widgets.dart';

import '../../../core/resources/color_manager.dart';
import '../utils/old_common_utils.dart';
import 'general/general_list.dart';
import 'general/widgets/create_general_reminder.dart';
import 'medicine/medicine_list.dart';
import 'medicine/widgets/create_reminder.dart';

class OldReminderTab extends StatefulWidget {
  const OldReminderTab({super.key});

  @override
  State<OldReminderTab> createState() => _OldReminderTabState();
}

class _OldReminderTabState extends State<OldReminderTab> with TickerProviderStateMixin{


  late TabController tabController;
  int tabIndex = 0;

  @override
  void initState(){
    super.initState();

    tabController = TabController(length: 2, vsync: this);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBar('Reminders'),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        heroTag: 'for reminders',
        onPressed: (){
          if(tabIndex == 0){
            Navigator.push(context, routeTo(context, CreateMedReminder()));
          }
          else{
            Navigator.push(context, routeTo(context, CreateGeneralReminder()));
          }
        },
        backgroundColor: tabIndex == 0 ? MyColors.primary : MyColors.green,
        child: Icon(Icons.add,color: MyColors.white,),
      ),
      body: Column(
        children: [
          TabBar(
            padding: EdgeInsets.all(8),
            onTap: (index){
              setState(() {
                tabIndex = index;
              });
            },
            indicator: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: tabIndex == 0 ? MyColors.primary : MyColors.green
            ),
            indicatorSize: TabBarIndicatorSize.tab,
            dividerColor: Colors.transparent,
            controller: tabController,
              labelColor: MyColors.white,
              labelPadding: allPadding,
              tabs: [
                Text('Medicine'),
                Text('General')
              ]
          ),
          Expanded(
            child: TabBarView(
              physics: NeverScrollableScrollPhysics(),
              controller: tabController,
                children: [
                 MedicineList(),
                 GeneralList()
                ]
            ),
          )
        ],
      ),
    );
  }
}
