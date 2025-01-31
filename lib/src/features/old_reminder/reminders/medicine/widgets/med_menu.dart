




import 'dart:io';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:workmanager/workmanager.dart';
import '../../../../../core/resources/color_manager.dart';
import '../../../../../core/resources/gap_manager.dart';
import '../../../providers/image_providers.dart';
import '../../../utils/old_common_utils.dart';
import '../controller/medicine_providers.dart';
import '../domain/model/medicine_model.dart';
import '../domain/services/medicine_services.dart';
import '../presentation/medicine_details.dart';
import 'update_reminder.dart';



void showMedMenu({required BuildContext context, required WidgetRef ref,required MedicineModel medicine,required bool isFromDetail}) async {
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
            leading: Icon(FontAwesomeIcons.pills,size: 16,color: MyColors.black,),
            title: Text(medicine.medicineName,style: TextStyle(fontWeight: FontWeight.w500,fontSize: 20),),
          ),
          h10,
          Divider(),
          if(!isFromDetail)
          ListTile(
            onTap: () async {
              if(medicine.attachment!=null){
                final uint8list = medicine.attachment;
                final tempDir = await getTemporaryDirectory();
                final filePath = '${tempDir.path}/Image';
                final file = File(filePath);
                await file.writeAsBytes(uint8list!);
                // return file;
                ref.read(imageProvider.notifier).isImage(image: file);
              }
              Navigator.pop(context);

              Future.delayed(Duration(milliseconds: 200),(){

                Navigator.push(context, routeTo(context, MedicineDetails(medicineId: medicine.reminderId)));
              });
            },
            leading: Icon(Icons.info),
            title: Text('Details'),
          ),
          if(!isFromDetail)
          Divider(),
          ListTile(
            onTap: () async {
              Navigator.pop(context);
              Navigator.push(context, routeTo(context, UpdateMedReminder(medicine: medicine)));
              if(medicine.attachment!=null){
                final uint8list = medicine.attachment;
                final tempDir = await getTemporaryDirectory();
                final filePath = '${tempDir.path}/Image';
                final file = File(filePath);
                await file.writeAsBytes(uint8list!);
                // return file;
                ref.read(imageProvider.notifier).isImage(image: file);
              }
            },
            leading: Icon(Icons.edit),
            title: Text('Edit'),
          ),
          Divider(),
          ListTile(
            onTap: (){
              Navigator.pop(context);
              _delReminder(context, ref, medicine,isFromDetail);
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


void _delReminder(context,ref,MedicineModel medicine,bool isFromDetail) async{

  await showDialog(context: context, builder: (context){
    return AlertDialog(
      title: Text('Confirm Delete'),
      content: Text('${medicine.medicineName} reminder will be deleted.'),
      actions: [
        regularTextButton(text: 'Cancel', onPressed: ()=>Navigator.pop(context)),
        regularTextButton(bgColor: MyColors.red, color: MyColors.white, text: 'Delete', onPressed: () async {

          for(int i in medicine.notificationIds){
            await AwesomeNotifications().cancel(i);
          }
          await Workmanager().cancelByUniqueName('1-${medicine.reminderId}');

          ref.read(medicineReminderNotifier.notifier).delReminder(medicine).then((value){
            ref.refresh(medReminderProvider);
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