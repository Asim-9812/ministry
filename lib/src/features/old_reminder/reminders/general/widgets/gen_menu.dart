




import 'dart:io';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../core/resources/gap_manager.dart';
import '../../../providers/image_providers.dart';
import '../../../utils/old_common_utils.dart';
import '../controller/general_reminder_providers.dart';
import 'package:path_provider/path_provider.dart';
import 'package:workmanager/workmanager.dart';
import '../../../../../core/resources/color_manager.dart';
import '../domain/model/general_model.dart';
import '../domain/services/general_services.dart';
import 'update_general_reminder.dart';




void showGenMenu({required BuildContext context, required WidgetRef ref,required GeneralModel generalModel,required bool isFromDetail}) async {
  await showModalBottomSheet(context: context, builder: (context){
    return Container(
      padding: allPadding,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          h10,
          ListTile(
            leading: Icon(generalModel.isReminder ? Icons.alarm : Icons.note_alt_sharp,color: MyColors.black,),
            title: Text(generalModel.title,style: TextStyle(fontWeight: FontWeight.w500,fontSize: 20),),
          ),
          h10,
          Divider(),

          if(!isFromDetail)
          ListTile(
            onTap: () async {
              Navigator.pop(context);

              Navigator.push(context, routeTo(context, UpdateGeneralReminder(generalModel: generalModel)));


              Future.delayed(Duration(milliseconds: 200),() async {
                if(generalModel.attachment!=null){
                  List<File> tempFiles = [];

                  for(var i in generalModel.attachment!){
                    int count = 1;
                    //print(count);
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
            leading: Icon(Icons.edit),
            title: Text('Edit'),
          ),
          if(!isFromDetail)
          Divider(),
          ListTile(
            onTap: (){
              Navigator.pop(context);
              _delReminder(context, ref, generalModel,isFromDetail);


            },
            leading: Icon(Icons.delete_forever_rounded),
            title: Text('Delete'),
          ),
          h50
        ],
      ),
    );
  });
}


void _delReminder(context,ref,GeneralModel generalModel,bool isFromDetail) async{
  await showDialog(context: context, builder: (context){
    return AlertDialog(
      title: Text('Confirm Delete'),
      content: Text('${generalModel.title} reminder will be deleted.'),
      actions: [
        regularTextButton(text: 'Cancel', onPressed: ()=>Navigator.pop(context)),
        regularTextButton(
          bgColor: MyColors.red,
            color: MyColors.white,
            text: 'Delete', onPressed: () async {

          await AwesomeNotifications().cancel(generalModel.reminderId);
          await AwesomeNotifications().cancel(generalModel.reminderId*100);
          await Workmanager().cancelByUniqueName('2-${generalModel.reminderId}');
          ref.read(generalReminderNotifier.notifier).delMedReminder(generalModel).then((value){
            ref.refresh(genReminderProvider);
            Navigator.pop(context);
            if(isFromDetail){
              Navigator.pop(context);
            }
          });
        })
      ],
    );
  });

}