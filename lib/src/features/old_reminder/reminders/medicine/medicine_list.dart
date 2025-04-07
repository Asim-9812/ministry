



import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../../../core/resources/color_manager.dart';
import '../../providers/image_providers.dart';
import '../../utils/old_common_utils.dart';
import 'domain/services/medicine_services.dart';
import 'presentation/medicine_details.dart';
import 'widgets/med_menu.dart';


class MedicineList extends ConsumerWidget {
  const MedicineList({super.key});

  @override
  Widget build(BuildContext context,ref) {

    final medicines = ref.watch(medReminderProvider);

    final now = DateTime.now();

    if(medicines.isEmpty){
      return NoFileWidget(text: 'No Reminders', type: 2);
    }
    return Container(
      // decoration: BoxDecoration(
      //   color: MyColors.grey,
      //   borderRadius: BorderRadius.circular(20),
      // ),
      padding: EdgeInsets.symmetric(horizontal: 8,vertical: 12),
      child: ListView.builder(
        itemCount: medicines.length,
          itemBuilder: (context , index){
          final medicine = medicines[index];
          final detail ='${medicine.strength} ${medicine.unit.units} - ${medicine.meal.mealTime}';
          final sortDate = medicine.scheduleTime.map((e) => DateTime(now.year,now.month,now.day,e.hour,e.minute)).toList();

          final date = sortDate.firstWhere((element) => element.isAfter(now),orElse:()=> sortDate.first);

          final time = DateFormat('HH:mm a').format(date);

          return Card(
            elevation: 0,
            color: MyColors.white,
            child: ListTile(
              onTap: () async {
               // final list =await AwesomeNotifications().listScheduledNotifications();
               // for(var i in list){
               //   print(i.schedule?.toMap());
               // }
                Navigator.push(context, routeTo(context, MedicineDetails(medicineId: medicine.reminderId)));

                Future.delayed(Duration(milliseconds: 200),() async {
                  if(medicine.attachment!=null){
                    final uint8list = medicine.attachment;
                    final tempDir = await getTemporaryDirectory();
                    final filePath = '${tempDir.path}/Image';
                    final file = File(filePath);
                    await file.writeAsBytes(uint8list!);
                    // return file;
                    ref.read(imageProvider.notifier).isImage(image: file);
                  }
                });
              },
              onLongPress: ()=>showMedMenu(context: context, ref: ref, medicine: medicine,isFromDetail: false),
              shape: ContinuousRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              tileColor: MyColors.white,
              leading: Icon(Icons.alarm,color: MyColors.primary,),
              title: Text(medicine.medicineName,style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
              subtitle: Text(detail,style: TextStyle(color: MyColors.darkGrey,fontSize: 12),),
              trailing: Container(
                decoration: BoxDecoration(
                  color: MyColors.primary,
                  borderRadius: BorderRadius.circular(10)
                ),
                padding: EdgeInsets.all(8),
                child: Text(time,style: TextStyle(color: MyColors.white,fontSize: 12),),),
            ),
          );
        }
      ),
    );
  }
}
