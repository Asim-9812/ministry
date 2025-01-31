



import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:ministry/src/core/utils/toaster.dart';
import 'package:ministry/src/features/status_page/domain/model/user_model.dart';
import 'package:path/path.dart';

import '../../../../core/resources/color_manager.dart';
import '../../../../core/resources/font_manager.dart';
import '../../../../core/resources/gap_manager.dart';
import '../../../old_reminder/utils/old_common_utils.dart';
import '../../controller/date_formatter.dart';
import '../../controller/document_provider.dart';
import '../../domain/services/patient_document_services.dart';



class PatientAddDocuments extends ConsumerStatefulWidget {
  PatientAddDocuments({super.key});

  @override
  ConsumerState<PatientAddDocuments> createState() => _PatientAddDocumentsState();
}

class _PatientAddDocumentsState extends ConsumerState<PatientAddDocuments> {
  final _formKey = GlobalKey<FormState>();

  final _titleController = TextEditingController();

  final _descController = TextEditingController();

  final _dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final user = Hive.box<UserModel>('users').values.first;
    final isLoading = ref.watch(commonProvider).isUploading;
    final documentNames = ref.watch(commonProvider).documentTitles;
    final documentTypeId = ref.watch(commonProvider).documentType;
    final icon = documentTypeId == 1 ? Icons.picture_as_pdf : Icons.image;
    final file = documentTypeId == 1 ? ref.watch(docProvider) : ref.watch(docImageProvider);
    return GestureDetector(
      onTap: ()=>unFocus(context),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Add Documents',style: wh3,),
          leading: IconButton(onPressed: ()=>Navigator.pop(context),icon: Icon(Icons.chevron_left,color: MyColors.primary ,),),
        ),
        body: Padding(
          padding: eightPadding,
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  h10,
                  TextFormField(
                    controller: _titleController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      labelText: 'Title'
                    ),
                    validator: (value){
                      if(value!.trim().isEmpty){
                        return 'Title is required';
                      }
                      else if(value.length > 20){
                        return 'Title cannot exceed 20 letters';
                      }
                      else if(documentNames.contains(value.toLowerCase().trim())){
                        return 'Document with same name already exists';
                      }
                      return null;
                    },
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                  ),
                  h10,
                  TextFormField(
                    controller: _descController,
                    maxLines: null,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        labelText: 'Description',
                    ),
                    validator: (value){
                      if(value!.trim().isEmpty){
                        return 'Description is required';
                      }
                      else if(value.length>100){
                        return 'Exceeds number of letters allowed';
                      }
                      return null;
                    },
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(100)
                    ],
                  ),
                  h10,
                  TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Date is required';
                      }

                      // Create a regular expression pattern to match 'yyyy-MM-dd' format
                      final pattern = r'^\d{4}-\d{2}-\d{2}$';
                      final regex = RegExp(pattern);

                      if (!regex.hasMatch(value)) {
                        return 'Invalid Date';
                      }

                      // Split the date string into parts
                      final dateParts = value.split('-');

                      // Ensure there are three parts (year, month, day)
                      if (dateParts.length != 3) {
                        return 'Invalid Date';
                      }

                      final year = int.tryParse(dateParts[0]);
                      final month = int.tryParse(dateParts[1]);
                      final day = int.tryParse(dateParts[2]);

                      if (year == null || month == null || day == null) {
                        return 'Invalid Date';
                      }

                      // Check if the month is invalid
                      if (month < 1 || month > 12) {
                        return 'Invalid Month';
                      }

                      // Check if the day is invalid for the selected month
                      if (day < 1 || day > DateTime(year, month + 1, 0).day) {
                        return 'Day must be between 1 and ${DateTime(year, month, 0).day}';
                      }

                      // Get the current date
                      final currentDate = DateTime.now();

                      // Check if the selected date is in the future
                      if (DateTime(year, month, day).isAfter(currentDate)) {
                        return 'Date cannot be in the future';
                      }


                      return null;
                    },
                    inputFormatters: [
                      DateInputFormatter()
                    ],
                    controller: _dateController,
                    decoration: InputDecoration(
                      labelText: 'Completed date',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                          )
                      ),
                      hintText: 'YYYY-MM-DD',
                      suffixIcon: IconButton(
                        icon: Icon(Icons.calendar_month,color: MyColors.primary ,),
                        onPressed: () => _selectDate(context, _dateController),
                      ),
                    ),
                  ),
                  h10,
                  if(file != null)
                  ListTile(
                    shape: ContinuousRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side: BorderSide(
                        color: MyColors.darkGrey
                      )
                    ),
                    tileColor: MyColors.grey,
                    contentPadding: EdgeInsets.only(left: 16),
                    leading: Icon(icon,color: MyColors.primary,),
                    title: Text(basename(file.path!)),
                    trailing: IconButton(onPressed: (){
                      if(documentTypeId == 1){
                        ref.read(docProvider.notifier).pickPdf();
                      }
                      else{
                       _forImagePicker(context, ref);
                      }
                    }, icon: Icon(Icons.refresh,color: MyColors.primary ,)),
                  ),
                  if(file == null)
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(double.infinity,60),
                        shape: ContinuousRectangleBorder(
                          borderRadius: BorderRadius.circular(20)
                        ),
                        elevation: 0,
                        backgroundColor: MyColors.lightGrey,
                      ),
                      onPressed: (){
                        if(documentTypeId == 1){
                          ref.read(docProvider.notifier).pickPdf();
                        }
                        else{
                          _forImagePicker(context, ref);
                        }
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.cloud_upload_outlined,color: MyColors.primary ,size: 30,),
                          w10,
                          Text('Upload File',style: TextStyle(fontSize: 18),)
                    ],
                  )),
                  h20,
                  Row(
                    children: [
                      Expanded(child: regularTextButton(
                          text: 'Cancel',
                          onPressed: ()=>Navigator.pop(context))),
                      w10,
                      Expanded(child: regularTextButton(
                        color: MyColors.white,
                          bgColor: MyColors.primary,
                          onPressed: () async {

                            if(file != null){
                              if(_formKey.currentState!.validate()){
                                ref.read(commonProvider.notifier).updateUploadState(true);
                                final userId = user.userName.toString().toUpperCase();
                                final document = await MultipartFile.fromFile(
                                  file.path!,
                                  filename: basename(file.path!),);
                                Map<String, dynamic> data = {
                                'documentID':0,
                                'userID':userId,
                                'documentTypeID':documentTypeId,
                                'folderName':userId,
                                'doctorAttachmentID':0,
                                'documentTitle':_titleController.text.trim(),
                                'documentDescription':_descController.text.trim(),
                                'completedDate':_dateController.text.trim(),
                                'flag':'Insert',
                                'documentUrl' : document
                                };
                                //print(data);

                                  ref.read(patientDocumentNotifier.notifier).submitDocument(data: data,token:user.token!,context: context).then((value){
                                  ref.refresh(patientDocumentProvider(Tuple2(user.userName!, user.token!)));
                                  ref.read(commonProvider.notifier).updateDocumentType(0);
                                  ref.read(commonProvider.notifier).updateUploadState(false);
                                  ref.invalidate(docImageProvider);
                                  ref.invalidate(docProvider);
                                });

                              }
                            }
                            else{
                              Toaster.error('Please select a file');
                            }


                      },text: isLoading? null : 'Upload', child: isLoading? SpinKitDualRing(color: MyColors.white,size: 16,): null))
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _forImagePicker(BuildContext context,ref) async {
    await showModalBottomSheet(

        context: context,
        builder: (context){
          return Container(
            padding:allPadding,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Please select a way to upload the Image'),
                h10,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        InkWell(
                          onTap : () async {
                            ref.read(docImageProvider.notifier).camera();
                            Navigator.pop(context);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                    color: MyColors.black.withOpacity(0.5)
                                )
                            ),
                            padding: allPadding,
                            child: Icon(Icons.camera_alt,color: MyColors.black,size: 30,),
                          ),
                        ),
                        h10,
                        Text('Camera',style: TextStyle(color: MyColors.black,fontSize: 16),)
                      ],
                    ),
                    Column(
                      children: [
                        InkWell(
                          onTap:()async{

                            ref.read(docImageProvider.notifier).pickAnImage();
                            Navigator.pop(context);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                    color: MyColors.black.withOpacity(0.5)
                                )
                            ),
                            padding: allPadding,
                            child: Icon(Icons.image,color: MyColors.black,size: 30,),
                          ),
                        ),
                        h10,
                        Text('Gallery',style: TextStyle(color: MyColors.black,fontSize: 16),)
                      ],
                    ),
                  ],
                ),
              ],
            ),
          );
        }
    );

  }

  Future<void> _selectDate(BuildContext context, TextEditingController controller) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate:_dateController.text.isNotEmpty?DateFormat('yyyy-MM-dd').parse(_dateController.text): DateTime.now(),
      firstDate:DateTime.now().subtract(Duration(days: 36500)),
      lastDate:DateTime.now(),
    );
    if (picked != null && picked != DateTime.now())
      controller.text = DateFormat('yyyy-MM-dd').format(picked);

  }
}
