import 'dart:io';
import 'package:intl/intl.dart';
import 'package:easy_image_viewer/easy_image_viewer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:linear_progress_bar/linear_progress_bar.dart';
import '../../../../../core/resources/color_manager.dart';
import '../../../../../core/resources/gap_manager.dart';
import '../../../providers/image_providers.dart';
import '../../../utils/old_common_utils.dart';
import '../domain/services/medicine_services.dart';
import '../widgets/med_menu.dart';
import 'getIntakesLeft.dart';

class MedicineDetails extends ConsumerWidget {
  final int medicineId;
  MedicineDetails({required this.medicineId, super.key});

  @override
  Widget build(BuildContext context, ref) {
    final medicine = ref.watch(medicineProvider(medicineId));
    final image = ref.watch(imageProvider);

    final totalMedication = (medicine.totalDays * medicine.scheduleTime.length);

    final intake = intakes(dateList: medicine.dateList);

    return Scaffold(
      appBar: CommonBar(
          text: medicine.medicineName,
          backButton: true,
          context: context,
          action: [
            IconButton(
                onPressed: () {
                  showMedMenu(
                      context: context,
                      ref: ref,
                      medicine: medicine,
                      isFromDetail: true);
                },
                icon: Icon(
                  Icons.more_vert,
                  color: MyColors.white,
                ))
          ]
      ),
      body: Padding(
        padding: allPadding,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (image != null)
                  InkWell(
                    onTap: () {
                      final imagePath = FileImage(File(image.path));
                      showImageViewer(context, imagePath,
                          onViewerDismissed: () {});
                    },
                    child: Container(
                      height: 200,
                      width: 100,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                              image: FileImage(File(image.path)),
                              fit: BoxFit.cover)),
                    ),
                  ),
                if (image != null) w10,
                Expanded(
                    child: Container(
                  // padding: allPadding,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: medicine.scheduleTime.map((e) {
                            final date = DateFormat('HH:mm a').format(e);
                            return Container(
                              decoration: BoxDecoration(
                                  color: MyColors.secondary.withOpacity(0.7),
                                  borderRadius: BorderRadius.circular(10)),
                              margin: EdgeInsets.only(right: 4),
                              padding: EdgeInsets.all(8),
                              child: Text(
                                date,
                                style: TextStyle(
                                    color: MyColors.white, fontSize: 12),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                      h10,
                      Container(
                        decoration: BoxDecoration(
                            color: MyColors.grey.withOpacity(0.7),
                            borderRadius: BorderRadius.circular(10)),
                        padding: allPadding,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  'Dose : ',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16),
                                ),
                                Text(
                                  '${medicine.strength} ${medicine.unit.units}',
                                  style: TextStyle(fontSize: 16),
                                ),
                              ],
                            ),
                            h10,
                            Text(
                              '${medicine.meal.mealTime}',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ),
                      h10,
                      Container(
                        decoration: BoxDecoration(
                            color: MyColors.grey.withOpacity(0.7),
                            borderRadius: BorderRadius.circular(10)),
                        padding: allPadding,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  'Pattern : ',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16),
                                ),
                                Text(
                                  '${medicine.reminderPattern.patternName}',
                                  style: TextStyle(fontSize: 16),
                                ),
                              ],
                            ),
                            if (medicine.reminderPattern.patternId == 3) h06,
                            if (medicine.reminderPattern.patternId == 3)
                              Row(
                                children: [
                                  Text(
                                    'Interval : ',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16),
                                  ),
                                  Text(
                                    'Every ${medicine.reminderPattern.daysOfInterval!} days',
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ],
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )),
              ],
            ),
            h10,
            if (medicine.reminderPattern.patternId == 2)
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: medicine.reminderPattern.daysOfWeek!.map((e) {
                    return Container(
                      decoration: BoxDecoration(
                          color: MyColors.primary,
                          borderRadius: BorderRadius.circular(10)),
                      margin: EdgeInsets.only(right: 4),
                      padding: allPadding,
                      child: Text(
                        e,
                        style: TextStyle(color: MyColors.white),
                      ),
                    );
                  }).toList(),
                ),
              ),
            if (medicine.reminderPattern.patternId == 2) h10,
            Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                        color: MyColors.grey.withOpacity(0.7),
                        borderRadius: BorderRadius.circular(10)),
                    padding: allPadding,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Start Date',
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 12),
                        ),
                        Text(
                          '${DateFormat('yyyy-MM-dd').format(medicine.startDate)}',
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                ),
                w10,
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                        color: MyColors.grey.withOpacity(0.7),
                        borderRadius: BorderRadius.circular(10)),
                    padding: allPadding,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'End Date',
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 12),
                        ),
                        Text(
                          '${DateFormat('yyyy-MM-dd').format(medicine.endDate)}',
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            h10,
            Container(
              decoration: BoxDecoration(
                  color: MyColors.grey.withOpacity(0.7),
                  borderRadius: BorderRadius.circular(10)),
              padding: allPadding,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Progress : ${totalMedication - intake} medicines left',
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 12),
                  ),
                  h10,
                  LinearProgressBar(
                    maxSteps: totalMedication,
                    progressType: LinearProgressBar
                        .progressTypeLinear, // Use Linear progress
                    currentStep: intake,
                    progressColor: MyColors.secondary,
                    backgroundColor: MyColors.white,
                  )
                ],
              ),
            ),
            h10,
            if (medicine.note != null)
              Card(
                margin: EdgeInsets.zero,
                child: Container(
                  decoration: BoxDecoration(
                    color: MyColors.grey.withOpacity(0.7),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: allPadding,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Notes',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                      Divider(),
                      Text(medicine.note!),
                    ],
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }
}
