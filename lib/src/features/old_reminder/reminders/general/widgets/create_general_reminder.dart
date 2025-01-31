




import 'dart:io';
import 'dart:math';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:easy_image_viewer/easy_image_viewer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workmanager/workmanager.dart';
import '../../../../../core/resources/color_manager.dart';
import '../../../../../core/resources/font_manager.dart';
import '../../../../../core/resources/gap_manager.dart';
import '../../../notification_controllers/notification_controller.dart';
import '../../../providers/image_providers.dart';
import '../../../utils/old_common_utils.dart';
import '../../medicine/controller/data.dart';
import '../../medicine/domain/model/medicine_model.dart';
import '../controller/data.dart';
import '../controller/general_reminder_providers.dart';
import '../domain/model/general_model.dart';
import '../domain/services/general_services.dart';



class CreateGeneralReminder extends ConsumerStatefulWidget {
  const CreateGeneralReminder({super.key});

  @override
  ConsumerState<CreateGeneralReminder> createState() => _CreateGeneralReminderState();
}

class _CreateGeneralReminderState extends ConsumerState<CreateGeneralReminder> {




  bool _isReminder = false;


  bool _hasRemindBefore = false;

  
  DateTime? selectedTime;
  ReminderPattern? selectedPattern;
  RemindBefore? selectedRemindMe = RemindBefore(remindTypeId: 1, remindType: 'Days');
  List<String> selectedDays =[];
  int? intervalTime;


  final reminderId = Random().nextInt(999);
  final createdDate = DateTime.now();


  final _formKey = GlobalKey<FormState>();

  final _titleController = TextEditingController();
  final _noteController = TextEditingController();
  final _dateController = TextEditingController();
  final _beforeController = TextEditingController();
  final _intervalController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    
    final patterns = generalPatternList;
    final remindType  = remindBeforeList;

    
    final imageList = ref.watch(imageListProvider);

    return PopScope(
      canPop: true,
      onPopInvoked: (onPop){
        ref.invalidate(imageListProvider);
      },
      child: GestureDetector(
        onTap: ()=>unFocus(context),
        child: Scaffold(

          appBar: AppBar(
            title: Text('Set Reminder',style: bh2,),
            leading: IconButton(onPressed: (){
              ref.invalidate(imageListProvider);
              Navigator.pop(context);
            },icon: Icon(Icons.chevron_left,color: MyColors.secondary,),),
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    TextFormField(
                      controller: _titleController,
                      style: TextStyle(fontSize: 30,fontWeight: FontWeight.w500),
                      decoration: InputDecoration(
                        // contentPadding: EdgeInsets.symmetric(vertical: 16),
                        border: UnderlineInputBorder(),
                        hintText: 'Title',
                        hintStyle: TextStyle(fontSize: 30,color: MyColors.darkGrey),
                        prefixIcon: Icon(Icons.title,color: MyColors.secondary),
                      ),
                      validator: (value){
                        if(value!.trim().isEmpty){
                          return 'Title is required';
                        }
                        if(RegExp(r'^(?=.*?[!@#&*~])').hasMatch(value)){
                          return 'Invalid Title';
                        }
                        return null;
                      },
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(25)
                      ],
                    ),

                    h20,


                    Container(
                      // height: 100,
                      decoration: BoxDecoration(
                        color: MyColors.lightGrey,
                        borderRadius: BorderRadius.circular(10)
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 8,vertical: 12),
                      child: Column(
                        children: [
                          Text('Notes',style: TextStyle(fontWeight: FontWeight.w500,color: MyColors.secondary),),
                          h20,
                          TextFormField(
                            maxLines: null,
                            controller: _noteController,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Add notes ...'
                            ),
                          ),

                        ],
                      ),
                    ),
                    h10,
                    if(imageList == null)
                      Align(
                        alignment: Alignment.centerRight,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              elevation: 0,
                              backgroundColor: MyColors.lightGrey,
                              shape: ContinuousRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(20),
                                      bottomLeft: Radius.circular(20)
                                  ),
                                  side: BorderSide(
                                      color: MyColors.black,
                                    width: 0.5
                                  )
                              )
                          ),
                          onPressed: (){
                            _forImagePicker(context, ref);
                          },
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.add_a_photo,color: MyColors.secondary,size: 16,),
                              w10,
                              Text('Add a photo',style: TextStyle(color: MyColors.black),)
                            ],
                          ),
                        ),
                      ),

                    if(imageList != null)
                     Stack(
                       children: [
                         SingleChildScrollView(
                           scrollDirection: Axis.horizontal,
                           child: Row(
                             children:  imageList.map((e) {
                               final index = imageList.indexOf(e);
                               // print(e.path);
                               return InkWell(
                                 onTap: (){
                                   final imagePath = FileImage(File(e.path));
                                   showImageViewer(context, imagePath, onViewerDismissed: () {});
                                 },
                                 child: Container(
                                   margin: EdgeInsets.only(right: 8),
                                   width: 100,
                                   height: 150,
                                   decoration: BoxDecoration(
                                       image: DecorationImage(image: FileImage(File(e.path)),fit: BoxFit.cover),
                                       borderRadius: BorderRadius.circular(10)
                                   ),
                                   child: Align(
                                     alignment: Alignment.topRight,
                                     child:InkWell(
                                       onTap: (){
                                         ref.read(imageListProvider.notifier).deleteImage(index: index);
                                       },
                                       child: Container(
                                         decoration: BoxDecoration(
                                           shape: BoxShape.circle,
                                           color: MyColors.secondary.withOpacity(0.8)
                                         ),
                                           margin: EdgeInsets.all(4),
                                           padding: EdgeInsets.all(8),
                                           child: Icon(Icons.close,color: MyColors.white,size: 16,)),
                                     )
                                   ),
                                 ),
                               );
                             }).toList(),
                           ),
                         ),
                         Container(
                           height: 150,
                           child: Align(
                             alignment: Alignment.centerRight,
                             child: ElevatedButton(
                               style: ElevatedButton.styleFrom(
                                 elevation: 0,
                                 backgroundColor: MyColors.grey,
                                 shape: ContinuousRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    bottomLeft: Radius.circular(20)
                                  ),
                                   side: BorderSide(
                                     color: MyColors.black,
                                     width: 0.5
                                   )
                                 )
                               ),
                               onPressed: (){
                                _forImagePicker(context, ref);
                               },
                               child: Row(
                                 mainAxisSize: MainAxisSize.min,
                                 children: [
                                   Icon(Icons.add_a_photo,color: MyColors.secondary,size: 18,),
                                 ],
                               ),
                             ),
                           ),
                         ),
                       ],
                     ),

                    if(imageList != null)
                      h20,
                    h10,
                    if(!_isReminder)
                      Align(
                        alignment: Alignment.centerRight,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              elevation: 0,
                              backgroundColor: MyColors.lightGrey,
                              shape: ContinuousRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(20),
                                      bottomLeft: Radius.circular(20)
                                  ),
                                  side: BorderSide(
                                      color: MyColors.black,
                                      width: 0.5
                                  )
                              )
                          ),
                          onPressed: (){
                            setState(() {
                              _isReminder = !_isReminder;
                            });
                          },
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.alarm,color: MyColors.secondary,size: 16,),
                              w10,
                              Text('Add a reminder',style: TextStyle(color: MyColors.black),)
                            ],
                          ),
                        ),
                      ),

                    Visibility(
                        visible: _isReminder,
                        child: Column(
                          children: [
                            TextFormField(
                              controller: _dateController,
                              readOnly: true,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                prefixIcon: Icon(Icons.alarm,size: 16,color: MyColors.secondary,),
                                hintText: 'Add a time',
                                suffixIcon: IconButton(onPressed: (){
                                  setState(() {
                                    selectedPattern = null;
                                    selectedTime = null;
                                    _isReminder = false;
                                    _hasRemindBefore = false;
                                    selectedRemindMe = null;
                                  });
                                  _beforeController.clear();
                                  _dateController.clear();
                                }, icon: Icon(Icons.close,color: MyColors.secondary,)),
                              ),
                              onTap: ()=>_selectDateTime(),
                            ),
                            h06,
                            if(!_hasRemindBefore)
                            Align(
                              alignment: Alignment.centerRight,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    elevation: 0,
                                    backgroundColor: MyColors.lightGrey,
                                    shape: ContinuousRectangleBorder(
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(20),
                                            bottomLeft: Radius.circular(20)
                                        ),
                                        side: BorderSide(
                                            color: MyColors.black,
                                            width: 0.5
                                        )
                                    )
                                ),
                                onPressed: (){
                                  setState(() {
                                    _hasRemindBefore = !_hasRemindBefore;
                                  });
                                },
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(Icons.alarm,color: MyColors.secondary,size: 16,),
                                    w10,
                                    Text('Remind me before',style: TextStyle(color: MyColors.black),)
                                  ],
                                ),
                              ),
                            ),

                            if(_hasRemindBefore)
                              h10,

                            Visibility(
                                visible: _hasRemindBefore,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: TextFormField(
                                        controller: _beforeController,
                                        decoration: InputDecoration(
                                          isDense : true,
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(10)
                                          ),
                                          labelText: 'Remind me before',
                                          prefixIcon: Icon(Icons.timer,color: MyColors.secondary,size: 16,)
                                        ),
                                        validator: (value){
                                          if(value!.trim().isEmpty){
                                            return 'Duration is required';
                                          }
                                          try{
                                            final conv = int.parse(value);
                                          }catch(e){
                                            return 'Invalid value';
                                          }

                                          return null;
                                        },
                                        autovalidateMode: AutovalidateMode.onUserInteraction,
                                      ),
                                    ),
                                    w10,
                                    SizedBox(
                                      width: 100,
                                      child: DropdownSearch<String>(

                                        items: (filter, loadProps) => remindType.map((e) => e.remindType).toList(),
                                        decoratorProps: DropDownDecoratorProps(
                                          decoration: InputDecoration(
                                            border: UnderlineInputBorder(),
                                          ),
                                          textAlign: TextAlign.center,
                                          textAlignVertical: TextAlignVertical.bottom
                                        ),
                                        onChanged: (value) {

                                          //print(value);
                                          setState(() {
                                            selectedRemindMe = remindType.firstWhere((element) => element.remindType == value!);
                                          });


                                        },
                                        validator: (value){
                                          if(value == null){
                                            return 'Please select a type';
                                          }
                                          return null;
                                        },
                                        autoValidateMode: AutovalidateMode.onUserInteraction,


                                        selectedItem: selectedRemindMe?.remindType ?? remindBeforeList.first.remindType,
                                        popupProps: const PopupProps<String>.menu(

                                          showSearchBox: true,
                                          fit: FlexFit.loose,
                                          constraints: BoxConstraints(maxHeight: 350),
                                          showSelectedItems: true,
                                          searchFieldProps: TextFieldProps(
                                            style: TextStyle(
                                              fontSize: 18,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    w06,
                                    IconButton(onPressed: (){
                                      setState(() {
                                        _hasRemindBefore = false;
                                        selectedRemindMe = null;
                                      });
                                      _beforeController.clear();
                                    }, icon: Icon(Icons.close,color: MyColors.secondary,))

                                  ],
                                )

                            ),


                            if(_hasRemindBefore)
                            h10,
                            DropdownSearch<String>(

                              items:(filter, loadProps) =>  patterns.map((e) => e.patternName).toList(),
                              decoratorProps: DropDownDecoratorProps(
                                decoration: InputDecoration(
                                  prefixIcon: Icon(Icons.pattern,size: 16,color: MyColors.secondary,),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10)
                                  ),
                                  labelText: "Reminder Pattern",
                                ),
                              ),
                              onChanged: (value) {
                                //print(value);
                                setState(() {
                                  selectedPattern = patterns.firstWhere((element) => element.patternName == value!);
                                });
                              },
                              validator: (value){
                                if(value == null){
                                  return 'Please select a frequency';
                                }
                                return null;
                              },
                              autoValidateMode: AutovalidateMode.onUserInteraction,


                              selectedItem: selectedPattern?.patternName,
                              popupProps: const PopupProps<String>.menu(

                                showSearchBox: true,
                                fit: FlexFit.loose,
                                constraints: BoxConstraints(maxHeight: 350),
                                showSelectedItems: true,
                                searchFieldProps: TextFieldProps(
                                  style: TextStyle(
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                            ),
                            h10,

                            if(selectedPattern?.patternId == 3)
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: daysOfWeek.map((e) {
                                    final isSelected = selectedDays.contains(e);
                                    return InkWell(
                                      onTap: (){
                                        if(isSelected == true){
                                          setState(() {
                                            selectedDays.remove(e);
                                          });
                                        }
                                        else{
                                          setState(() {
                                            selectedDays.add(e);
                                          });
                                        }
                                      },
                                      child: Container(
                                        margin: EdgeInsets.only(right: 8),
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(10),
                                            border: Border.all(
                                                color: isSelected == true? MyColors.white:MyColors.black,
                                                width: 0.5
                                            ),
                                            color: isSelected == true ? MyColors.secondary:MyColors.white
                                        ),
                                        padding: allPadding,
                                        child: Text(e.substring(0,3),style: TextStyle(color: isSelected == true? MyColors.white:MyColors.black),),
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ),



                            if(selectedPattern?.patternId == 4)
                              TextFormField(
                                controller: _intervalController,
                                decoration: InputDecoration(

                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    labelText: 'Interval (in Days)',
                                    prefixIcon: Icon(FontAwesomeIcons.timeline,size: 16,color: MyColors.secondary,)

                                ),
                                validator: (value){
                                  if(value!.trim().isEmpty){
                                    return 'Interval is required';
                                  }
                                  try{
                                    final conv = int.parse(value);
                                  }catch(e){
                                    return 'Invalid value';
                                  }

                                  return null;
                                },
                                autovalidateMode: AutovalidateMode.onUserInteraction,
                                onChanged: (value){
                                  if(value.trim().isNotEmpty){
                                    setState(() {
                                      intervalTime = int.parse(value);
                                    });
                                  }
                                },

                              ),

                            if(selectedPattern?.patternId == 2 || selectedPattern?.patternId == 3)
                              h10,
                          ],
                        )

                    ),

                    h10,
                    Row(
                      children: [
                        Expanded(child:
                        regularTextButton(
                          bgColor: MyColors.green,
                            color: MyColors.white,
                            onPressed: (){
                              if(_formKey.currentState!.validate()){
                                _loading();
                                _setReminder();
                              }
                        }, text: 'Save')),
                      ],
                    )


                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }




  void _loading() async {
    await showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: MyColors.white,
          elevation: 0,
          content: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset('assets/images/loadingGifs/loadingBall.gif'),
              h20,
              Text('Please wait...',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
            ],
          ),
        );
      },
    );
  }





  void _setReminder() async {


    final imageList = ref.watch(imageListProvider);

    List<Uint8List> attachmentList = [];


    if(imageList!=null && imageList.isNotEmpty){

      for(var i in imageList){
        final cnv = await i.readAsBytes();
        attachmentList.add(cnv);
      }

    }


    if(_hasRemindBefore){
      RemindBefore remindBefore = RemindBefore(remindTypeId: selectedRemindMe!.remindTypeId, remindType: selectedRemindMe!.remindType,remindMeBefore: int.parse(_beforeController.text));
      setState(() {
        selectedRemindMe = remindBefore;
      });

    }


    if(_isReminder){
      final reminderPattern = ReminderPattern(
          patternId: selectedPattern!.patternId,
          patternName: selectedPattern!.patternName,
          daysOfInterval: intervalTime,
          daysOfWeek: selectedPattern!.patternId == 3? selectedDays : null
      );
      setState(() {
        selectedPattern = reminderPattern;
      });

      if(reminderPattern.patternId == 1){
        Map<String, dynamic> inputData = {
          'reminderId' : reminderId,
          'reminderTypeId' : 2,
          'title' : _titleController.text.trim(),
          'body' : _noteController.text.isNotEmpty ? _noteController.text.trim(): null,
          'patternId' : 1,
          'specificDays' : selectedDays,
          'interval' : intervalTime,
          'startDate' : selectedTime.toString(),
          'hasRemindBefore' : _hasRemindBefore,
          'hasRemindType' : selectedRemindMe?.remindMeBefore,
          'hasRemindInterval' : _hasRemindBefore ? int.parse(_beforeController.text.trim()) : null,
          'hasRemind' : selectedRemindMe?.remindType

        };

        await NotificationController.scheduleGeneralNotifications(allData: inputData);


      }
      else{
        Map<String, dynamic> inputData = {
          'reminderId' : reminderId,
          'reminderTypeId' : 2,
          'title' : _titleController.text.trim(),
          'body' : _noteController.text.isNotEmpty ? _noteController.text.trim(): '',
          'patternId' : reminderPattern.patternId,
          'specificDays' : selectedDays,
          'interval' : intervalTime ?? 0,
          'startDate' : selectedTime.toString(),
          'hasRemindBefore' : _hasRemindBefore,
          'hasRemindType' : selectedRemindMe?.remindMeBefore ?? 0,
          'hasRemindInterval' : _hasRemindBefore ? int.parse(_beforeController.text.trim()) : 0,
          'hasRemind' : selectedRemindMe?.remindType ?? ''

        };

        String taskName = _titleController.text.trim();

        String uniqueName = '2-${reminderId}';

        Constraints constraints =Constraints(
          networkType: NetworkType.not_required,
          requiresBatteryNotLow: false,
          requiresCharging: false,
          requiresDeviceIdle: false,
          requiresStorageNotLow: false,
        );

        await Workmanager().registerPeriodicTask(uniqueName, taskName, inputData: inputData,constraints: constraints,frequency: Duration(hours: 12));


      }



    }



    GeneralModel generalModel = GeneralModel(
        reminderId: reminderId,
        reminderTypeId: 2,
        title: _titleController.text.trim(),
        notes: _noteController.text.trim().isNotEmpty ? _noteController.text.trim() : null,
        isReminder: _isReminder,
      attachment: imageList != null ? attachmentList : null,
      hasRemindBefore: _hasRemindBefore,
      startDate: selectedTime,
      reminderPattern: selectedPattern,
      remindBefore: selectedRemindMe,
      createdDate: createdDate
    );

    Future.delayed(Duration(seconds: 2),(){
      ref.read(generalReminderNotifier.notifier).addReminder(generalModel: generalModel, context: context).then((value) {
        ref.invalidate(imageListProvider);
        ref.refresh(genReminderProvider);
      });
    });
  }

  void _selectDateTime() async {

    DateTime? pickedDate = await showDatePicker(
        context: context,
        firstDate: DateTime.now(),
        lastDate: DateTime(2026),
      initialDate: selectedTime ?? DateTime.now()
    );

    if(pickedDate != null){
      TimeOfDay initialTime = TimeOfDay(hour: selectedTime?.hour ?? TimeOfDay.now().hour, minute: selectedTime?.minute ?? TimeOfDay.now().minute);
      TimeOfDay? pickedTime = await showTimePicker(context: context, initialTime: initialTime);

      if(pickedTime != null){
        DateTime newDate = DateTime(pickedDate.year,pickedDate.month,pickedDate.day,pickedTime.hour,pickedTime.minute);
        selectedTime = newDate;

        String date = DateFormat('HH:mm a, MMMM dd, yyyy').format(selectedTime!);

        _dateController.text = date;

        //print(selectedTime);

      }

    }

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
                            ref.read(imageListProvider.notifier).camera();
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

                            ref.read(imageListProvider.notifier).pickMultipleImage();
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



}
