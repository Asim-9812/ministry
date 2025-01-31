


import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../../../core/resources/color_manager.dart';
import '../../../../core/resources/gap_manager.dart';
import '../../providers/image_providers.dart';
import '../../utils/old_common_utils.dart';
import 'domain/services/general_services.dart';
import 'widgets/gen_menu.dart';
import 'widgets/update_general_reminder.dart';

class GeneralList extends ConsumerStatefulWidget {
  const GeneralList({super.key});

  @override
  ConsumerState<GeneralList> createState() => _GeneralListState();
}

class _GeneralListState extends ConsumerState<GeneralList> {

  int selectedTab = 0;


  @override
  Widget build(BuildContext context) {
    final generalData = ref.watch(genReminderProvider);
    final generalList = selectedTab == 0? generalData : selectedTab == 1? generalData.where((element) => element.isReminder == true).toList() : generalData.where((element) => element.isReminder == false).toList();

    final hasBoth = generalData.any((element) => element.isReminder == true) &&
        generalData.any((element) => element.isReminder == false);

    if(generalList.isEmpty){
      return NoFileWidget(text: 'No Reminders', type: 2);
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8,vertical: 12),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if(hasBoth)
             h06,
            if(hasBoth)
            Padding(
              padding: const EdgeInsets.only(left: 8),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: (){
                        setState(() {
                          selectedTab = 0;
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 8,horizontal: 16),
                        decoration: BoxDecoration(
                          color: selectedTab == 0? MyColors.secondary : MyColors.white,
                          borderRadius: BorderRadius.circular(10)
                        ),
                        margin: EdgeInsets.only(right: 8),
                        child: Text('All',style: TextStyle(color: selectedTab == 0? MyColors.white : MyColors.black),),
                      ),
                    )  ,
                    InkWell(
                      onTap: (){
                        setState(() {
                          selectedTab = 1;
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 8,horizontal: 16),
                        decoration: BoxDecoration(
                          color: selectedTab == 1? MyColors.secondary: MyColors.white,
                          borderRadius: BorderRadius.circular(10)
                        ),
                        margin: EdgeInsets.only(right: 8),
                        child: Text('Reminders',style: TextStyle(color: selectedTab == 1 ? MyColors.white : MyColors.black),),
                      ),
                    )  ,
                    InkWell(
                        onTap: (){
                          setState(() {
                            selectedTab = 2;
                          });
                        },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 8,horizontal: 16),
                        decoration: BoxDecoration(
                          color:selectedTab == 2? MyColors.secondary : MyColors.white,
                          borderRadius: BorderRadius.circular(10)
                        ),
                        margin: EdgeInsets.only(right: 8),
                        child: Text('Notes',style: TextStyle(color:selectedTab == 2? MyColors.white: MyColors.black),),
                      ),
                    )  ,
                  ],
                ),
              ),
            ),
            h10,
            ListView.builder(
              shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: generalList.length,
                itemBuilder: (context,index){
                  final general = generalList[index];
                  final date = DateFormat('MMMM dd, yyyy').format(general.createdDate);
                  final isReminder = general.isReminder;
                  final reminderDate = isReminder ? DateFormat('HH:mm a').format(general.startDate!) : null;
                  return Card(
                    elevation: 0,
                    color: MyColors.white,
                    child: ListTile(
                      onLongPress: (){
                        showGenMenu(context: context, ref: ref, generalModel: general, isFromDetail: false);
                      },
                      onTap: (){
                        Navigator.push(context, routeTo(context, UpdateGeneralReminder(generalModel: general)));

                        Future.delayed(Duration(milliseconds: 200),() async {
                          if(general.attachment!=null){
                            List<File> tempFiles = [];

                            int count = 1;
                            for(var i in general.attachment!){

                              // print(count);
                              final uint8list = i;
                              final tempDir = await getTemporaryDirectory();
                              final filePath = '${tempDir.path}/Image$count';
                              final file = File(filePath);
                              await file.writeAsBytes(uint8list);
                              tempFiles.add(file);
                              count++;
                            }
                            ref.read(imageListProvider.notifier).isImageList(image: tempFiles);


                          }

                        });
                      },
                      shape: ContinuousRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      tileColor: MyColors.white,
                      leading: isReminder ? Icon(Icons.alarm,color: MyColors.secondary,) : Icon(Icons.note_alt_rounded,color: MyColors.secondary,),
                      title: Text(general.title,style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500),maxLines: 1,),
                      subtitle: Text(date,style: TextStyle(fontSize: 12,color: MyColors.darkGrey),),
                      trailing: isReminder? Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: MyColors.secondary
                        ),
                        child: Text(reminderDate!,style: TextStyle(color: MyColors.white),),
                      ) : null,
                    ),
                  );
                }
            ),
          ],
        ),
      ),
    );

  }
}
