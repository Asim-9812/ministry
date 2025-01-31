
import 'dart:io';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:path/path.dart' as path;
import 'package:dropdown_search/dropdown_search.dart';
import 'package:easy_image_viewer/easy_image_viewer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:workmanager/workmanager.dart';
import '../../../../../core/resources/color_manager.dart';
import '../../../../../core/resources/gap_manager.dart';
import '../../../providers/image_providers.dart';
import '../../../utils/old_common_utils.dart';
import '../controller/data.dart';
import '../controller/medicine_providers.dart';
import '../domain/model/medicine_model.dart';
import '../domain/services/medicine_services.dart';





class UpdateMedReminder extends ConsumerStatefulWidget {
  final MedicineModel medicine;

  UpdateMedReminder({required this.medicine,super.key});

  @override
  ConsumerState<UpdateMedReminder> createState() => _CreateMedReminderState();
}

class _CreateMedReminderState extends ConsumerState<UpdateMedReminder> {

  late MedicineModel medicine;
  late Meal selectedMeal;
  late MedicineRoute selectedRoute;
  late MedicineUnit selectedUnit;
  late Frequency selectedFrequency;
  late DateTime selectedTime;
  late int totalDays;
  late DateTime selectedDate;
  List<DateTime> scheduleTime = [];
  late ReminderPattern selectedPattern;
  List<String> selectedDays =[];
  int? intervalTime;
  List<int> notificationIds = [];
  List<DateTime> dateList =[];


  late int reminderId;


  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _strengthController = TextEditingController();
  final _timeController = TextEditingController();
  final _durationController = TextEditingController();
  final _startDateController = TextEditingController();
  final _endDateController = TextEditingController();
  final _intervalController = TextEditingController();
  final _noteController = TextEditingController();



  @override
  void initState(){
    super.initState();
    medicine = widget.medicine;
    selectedMeal = medicine.meal;
    selectedDate = medicine.startDate;
    selectedUnit = medicine.unit;
    selectedPattern = medicine.reminderPattern;
    selectedRoute = medicine.route;
    selectedTime = medicine.scheduleTime.first;
    totalDays = medicine.totalDays;
    reminderId = medicine.reminderId;
    selectedFrequency = medicine.frequency;
    _nameController.text = medicine.medicineName;
    _strengthController.text = medicine.strength.toString();
    _durationController.text = medicine.totalDays.toString();
    _startDateController.text = DateFormat('yyyy-MM-dd').format(selectedDate);
    _endDateController.text =DateFormat('yyyy-MM-dd').format(medicine.endDate);
    _timeController.text = DateFormat('HH:mm a').format(selectedTime);
    scheduleTime = medicine.scheduleTime;
    if(selectedPattern.daysOfInterval != null){
      _intervalController.text = medicine.reminderPattern.daysOfInterval.toString();
      intervalTime = medicine.reminderPattern.daysOfInterval;
    }

    if(selectedPattern.daysOfWeek != null){
      selectedDays = medicine.reminderPattern.daysOfWeek!;
    }

    if(medicine.note != null){
      _noteController.text = medicine.note!;
    }

  }


  @override
  Widget build(BuildContext context) {
    final frequency = frequencyList;
    final patterns = patternList;
    final token = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1bmlxdWVfbmFtZSI6WyJUQ0hDIiwiU1RLUyIsIlRDSEMiXSwicm9sZSI6ImFkbWluIiwiZW1haWwiOiJhc2ltOTgxMjAxQGdtYWlsLmNvbSIsIm5iZiI6MTczODEzMjQ0NywiZXhwIjoxNzM4MjE4ODQ3LCJpYXQiOjE3MzgxMzI0NDd9.oB9dFNqH48IkGyjfT4FbkrlPkUnbIMo1RL2m1eO0DHE';
    final routes = ref.watch(medRoutesProvider(token));
    final units = ref.watch(medUnitsProvider(token));
    final image = ref.watch(imageProvider);

    final meal = 'assets/images/med/meal.png';
    final meal2 = 'assets/images/med/meal2.png';

    return GestureDetector(
      onTap: ()=>unFocus(context),
      child: Scaffold(
        appBar: CommonBar(text: 'Edit Reminder', backButton: true, context: context),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: (){
                            setState(() {
                              selectedMeal = Meal(mealId: 1, mealTime: 'Before a meal');
                            });
                          },
                          child: Container(
                            margin: EdgeInsets.only(right: 5),
                            decoration: BoxDecoration(

                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                    color: selectedMeal.mealId == 1 ? MyColors.primary : MyColors.black
                                )
                            ),
                            padding: allPadding,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      height: 30,
                                      width: 10,
                                      decoration: BoxDecoration(
                                          color: selectedMeal.mealId == 1? MyColors.secondary : MyColors.grey,
                                          borderRadius: BorderRadius.circular(10),
                                          border: Border.all(
                                              color: MyColors.black
                                          )
                                      ),
                                    ),
                                    w10,
                                    Image.asset(selectedMeal.mealId == 1 ? meal : meal2,width: 50,height: 50,),
                                  ],
                                ),
                                h06,
                                Text('Before a meal'),

                              ],
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: (){
                            setState(() {
                              selectedMeal = Meal(mealId: 2, mealTime: 'After a meal');
                            });
                          },
                          child: Container(
                            margin: EdgeInsets.only(left: 5),
                            decoration: BoxDecoration(

                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                    color: selectedMeal.mealId == 2 ? MyColors.primary : MyColors.black
                                )
                            ),
                            padding: allPadding,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [

                                    Image.asset(selectedMeal.mealId == 2 ? meal : meal2,width: 50,height: 50,),
                                    w10,
                                    Container(
                                      height: 30,
                                      width: 10,
                                      decoration: BoxDecoration(
                                          color: selectedMeal.mealId == 2? MyColors.secondary : MyColors.grey,
                                          borderRadius: BorderRadius.circular(10),
                                          border: Border.all(
                                              color: MyColors.black
                                          )
                                      ),
                                    ),
                                  ],
                                ),
                                h06,
                                Text('After a meal')
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  h20,

                  routes.when(
                      data: (route){
                        return DropdownSearch<String>(

                          items: (filter, loadProps) =>route.map((e) => e.route).toList(),
                          decoratorProps: DropDownDecoratorProps(
                            decoration: InputDecoration(
                              prefixIcon: Icon(FontAwesomeIcons.pills,size: 16,color: MyColors.primary,),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)
                              ),
                              labelText: "Route",
                            ),
                          ),
                          onChanged: (value) {
                            //print(value);
                            setState(() {
                              selectedRoute = route.firstWhere((element) => element.route == value!);
                            });

                          },
                          validator: (value){
                            if(value == null){
                              return 'Please select a route';
                            }
                            return null;
                          },
                          autoValidateMode: AutovalidateMode.onUserInteraction,


                          selectedItem: selectedRoute.route,
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
                        );
                      },
                      error: (error,stack) => Center(child: IgnorePointer(
                        ignoring: true,
                        child: TextFormField(
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)
                              ),
                              filled: true,
                              labelText: '$error'
                          ),
                        ),
                      ),),
                      loading: ()=>loadingShimmer(child: TextFormField(
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)
                            ),
                            filled: true,
                            labelText: 'Unit'
                        ),
                      ))
                  ),
                  h10,
                  TextFormField(
                    controller: _nameController,
                    decoration: InputDecoration(

                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        labelText: 'Medicine Name',
                        prefixIcon: Icon(Icons.sort_by_alpha,size: 16,color: MyColors.primary,)

                    ),
                    validator: (value){
                      if(value!.trim().isEmpty){
                        return 'Name is required';
                      }
                      if(RegExp(r'^(?=.*?[!@#&*~])').hasMatch(value)){
                        return 'Invalid Name';
                      }
                      return null;
                    },
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    onChanged: (value){
                      // ref.read(itemProvider.notifier).updateMedicineName(value);
                    },

                  ),
                  h10,
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: _strengthController,
                          decoration: InputDecoration(

                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              labelText: 'Strength',
                              prefixIcon: Icon(FontAwesomeIcons.glassWaterDroplet,size: 16,color: MyColors.primary,)

                          ),
                          validator: (value){
                            if(value!.trim().isEmpty){
                              return 'Strength is required';
                            }
                            try{
                              double.parse(value);
                            }catch(e){
                              return 'Invalid value';
                            }

                            return null;
                          },
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          onChanged: (value){
                            // ref.read(itemProvider.notifier).updateMedicineName(value);
                          },

                        ),
                      ),
                      w06,
                      units.when(
                          data: (unit){
                            return Expanded(
                              child: DropdownSearch<String>(

                                items: (filter, loadProps) =>unit.map((e) => e.units).toList(),
                                decoratorProps: DropDownDecoratorProps(
                                  decoration: InputDecoration(
                                    prefixIcon: Icon(Icons.scale,size: 16,color: MyColors.primary,),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10)
                                    ),
                                    labelText: "Unit",
                                  ),
                                ),
                                onChanged: (value) {
                                  //print(value);
                                  setState(() {
                                    selectedUnit = unit.firstWhere((element) => element.units == value!);
                                  });

                                },
                                validator: (value){
                                  if(value == null){
                                    return 'Please select a route';
                                  }
                                  return null;
                                },
                                autoValidateMode: AutovalidateMode.onUserInteraction,


                                selectedItem: selectedUnit.units,
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
                            );
                          },
                          error: (error,stack) => Expanded(child: IgnorePointer(
                            ignoring: true,
                            child: TextFormField(
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10)
                                  ),
                                  filled: true,
                                  labelText: '$error'
                              ),
                            ),
                          ),),
                          loading: ()=>Expanded(
                            child: loadingShimmer(child: TextFormField(
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10)
                                  ),
                                  filled: true,
                                  labelText: 'Unit'
                              ),
                            )),
                          )
                      ),
                    ],
                  ),
                  h10,
                  DropdownSearch<String>(

                       items:(filter, loadProps) => frequency.map((e) => e.frequency).toList(),
                    decoratorProps: DropDownDecoratorProps(
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.timelapse,size: 16,color: MyColors.primary,),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)
                        ),
                        labelText: "Frequency",
                      ),
                    ),
                    onChanged: (value) {
                      //print(value);
                      setState(() {
                        selectedFrequency = frequency.firstWhere((element) => element.frequency == value!);
                        selectedTime == null;
                      });
                      notificationIds.clear();
                      scheduleTime.clear();
                      _timeController.clear();
                    },
                    validator: (value){
                      if(value == null){
                        return 'Please select a frequency';
                      }
                      return null;
                    },
                    autoValidateMode: AutovalidateMode.onUserInteraction,


                    selectedItem: selectedFrequency.frequency,
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
                  TextFormField(
                    controller: _timeController,
                    readOnly: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      hintText: 'hh:mm',
                      labelText: 'Schedule Time',
                      prefixIcon: Icon(FontAwesomeIcons.clock,size: 16,color: MyColors.primary,),

                    ),
                    onTap: (){
                      if(notificationIds.isNotEmpty){
                        notificationIds.clear();
                      }
                      if(dateList.isNotEmpty){
                        dateList.clear();
                      }
                      _selectTime();
                                        },
                  ),
                  h10,
                  if(scheduleTime.isNotEmpty && scheduleTime.length > 1)
                    SingleChildScrollView(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: scheduleTime.map((e){
                          return Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: MyColors.primary
                              ),
                              padding: allPadding,
                              child: Text(DateFormat('HH:mm a').format(e),style: TextStyle(color: MyColors.white),));
                        }).toList(),
                      ),
                    ),

                  if(scheduleTime.isNotEmpty && scheduleTime.length > 1)
                    h10,

                  TextFormField(
                    controller: _durationController,
                    decoration: InputDecoration(

                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        labelText: 'Medication Duration (in days)',
                        prefixIcon: Icon(FontAwesomeIcons.database,size: 16,color: MyColors.primary,)

                    ),
                    validator: (value){
                      if(value!.trim().isEmpty){
                        return 'Duration is required';
                      }
                      try{
                        int.parse(value);
                      }catch(e){
                        return 'Invalid value';
                      }

                      return null;
                    },
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    onChanged: (value){
                      if(value.trim().isNotEmpty){
                        setState(() {
                          totalDays = int.parse(value);
                        });
                        DateTime endDate = selectedDate.add(Duration(days: totalDays));
                        _endDateController.text = DateFormat('yyyy-MM-dd').format(endDate);

                      }

                    },

                  ),
                  h10,
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: _startDateController,
                          readOnly: true,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            hintText: 'yyyy-mm-dd',
                            labelText: 'Start Date',
                            prefixIcon: Icon(FontAwesomeIcons.calendarDay,size: 16,color: MyColors.primary,),

                          ),
                          onTap: (){
                          if(dateList.isNotEmpty){
                            dateList.clear();
                          }
                          setState(() {
                            selectedDate==null;
                          });
                          _startDateController.clear();
                          _endDateController.clear();
                          _selectDate();
                          },
                        ),
                      ),
                      w06,
                      Expanded(
                        child: TextFormField(
                          controller: _endDateController,
                          readOnly: true,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            hintText: 'yyyy-mm-dd',
                            labelText: 'End Date',
                            prefixIcon: Icon(FontAwesomeIcons.calendarDay,size: 16,color: MyColors.primary,),
                          ),
                        ),
                      ),
                    ],
                  ),
                  h10,
                  DropdownSearch<String>(
                    items:(filter, loadProps) => patterns.map((e) => e.patternName).toList(),
                    decoratorProps: DropDownDecoratorProps(
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.pattern,size: 16,color: MyColors.primary,),
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


                    selectedItem: selectedPattern.patternName,
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

                  if(selectedPattern.patternId == 2)
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
                                  color: isSelected == true ? MyColors.primary:MyColors.white
                              ),
                              padding: allPadding,
                              child: Text(e.substring(0,3),style: TextStyle(color: isSelected == true? MyColors.white:MyColors.black),),
                            ),
                          );
                        }).toList(),
                      ),
                    ),



                  if(selectedPattern.patternId == 3)
                    TextFormField(
                      controller: _intervalController,
                      decoration: InputDecoration(

                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          labelText: 'Interval',
                          prefixIcon: Icon(FontAwesomeIcons.timeline,size: 16,color: MyColors.primary,)

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

                  if(selectedPattern.patternId == 2 || selectedPattern.patternId == 3)
                    h10,

                  ListTile(
                    onTap: (){
                      if(image == null){
                        _forImagePicker(context, ref);
                      }else{
                        final imagePath = FileImage(File(image.path));
                        showImageViewer(context, imagePath, onViewerDismissed: () {});
                      }
                    },
                    shape: ContinuousRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                        side: BorderSide(
                            color:image != null ? MyColors.primary: MyColors.black,
                            width: image != null ? 1: 0.5
                        )
                    ),
                    tileColor: image != null ? MyColors.white:  MyColors.grey,
                    leading: Icon(Icons.image,size: 16,color: MyColors.primary,),
                    title: Text(image != null ? '${path.basename(image.path)}' : 'Provide a image (optional)'),
                    trailing:image != null ? IconButton(onPressed: (){
                      //print('pressed!');

                      ref.invalidate(imageProvider);
                    }, icon: Icon(Icons.close,color: MyColors.darkGrey,size: 16,)):null,
                  ),
                  h10,
                  TextFormField(
                    controller: _noteController,
                    maxLines: null,
                    decoration: InputDecoration(

                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        labelText: 'Notes (optional)',
                        prefixIcon: Icon(Icons.note,size: 16,color: MyColors.primary,)

                    ),

                  ),
                  h10,
                  Row(
                    children: [
                      Expanded(child: regularTextButton(
                          color: MyColors.white,
                          bgColor: MyColors.primary,
                          onPressed: (){
                        if(_formKey.currentState!.validate()){
                          _confirmDialog();
                        }
                      },text: 'Save')),
                    ],
                  ),


                  h50,

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _selectTime() async {

    List<DateTime> tempScheduleList = [];


    TimeOfDay initialTime = TimeOfDay.fromDateTime(selectedTime ?? DateTime.now());

    TimeOfDay? _timePicker = await showTimePicker(context: context, initialTime: initialTime);


    if(_timePicker != null){
      DateTime now = DateTime.now();

      selectedTime = DateTime(now.year,now.month,now.day,_timePicker.hour,_timePicker.minute);
      DateTime tempTime= selectedTime;
      _timeController.text = DateFormat('HH:mm a').format(selectedTime);
      int repeat = selectedFrequency.frequencyId;
      int interval = (24/repeat).round();


      int initialId = (reminderId * 100);   // for notificationsIds,
      int contentId = (reminderId * 1000);  // for notificationsIds,
      notificationIds.add(initialId);
      notificationIds.add(contentId);

      tempScheduleList.add(selectedTime);

      for(int i = 1; i < repeat ; i++){
        int initialId = (reminderId * 100) + i ;   // for notificationsIds,
        int contentId = (reminderId * 1000) + i ;   // for notificationsIds,
        tempTime = tempTime.add(Duration(hours: interval));
        tempScheduleList.add(tempTime);
        notificationIds.add(initialId);
        notificationIds.add(contentId);
      }

      //print(tempScheduleList);

      //print(notificationIds);

      setState(() {
        scheduleTime = tempScheduleList;
      });


    }


  }

  void _selectDate() async{


    DateTime initialDate = selectedDate ?? DateTime.now();

    DateTime? _datePicker = await showDatePicker(context: context, firstDate: DateTime.now(), lastDate: DateTime(2026),initialDate: initialDate);


    if(_datePicker != null){

      DateTime now = DateTime.now();

      selectedDate = _datePicker;

      DateTime endDate = selectedDate.add(Duration(days: totalDays));

      _startDateController.text = DateFormat('yyyy-MM-dd').format(selectedDate);
      _endDateController.text = DateFormat('yyyy-MM-dd').format(endDate);
    }
  }

  void _confirmDialog() async {

    ref.watch(imageProvider);

    final medicineName = _nameController.text;

    final medicineStrength = '${_strengthController.text} ${selectedUnit.units}';

    final meal = '${selectedMeal.mealTime}';

    final medFrequency = '${selectedFrequency.frequency}';


    final startDate = DateFormat('yyyy-MM-dd').format(selectedDate);

    final end = selectedDate.add(Duration(days: totalDays));

    final endDate = DateFormat('yyyy-MM-dd').format(end);

    final schedule = scheduleTime.map((e) => DateFormat('HH:mm a').format(e)).toList();



    await showDialog(context: context, builder: (context){
      return AlertDialog(
        title: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(FontAwesomeIcons.pills,color: MyColors.primary,size: 16,),
                w20,
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(medicineName,style: TextStyle(fontSize: 24,fontWeight: FontWeight.w600),),
                    Text(medicineStrength,style: TextStyle(fontSize: 12),),
                  ],
                ),
              ],
            ),
            Divider()
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: schedule.map((e) => Container(
                    margin: EdgeInsets.only(right: 8),
                    decoration: BoxDecoration(
                        color: MyColors.primary,
                        borderRadius: BorderRadius.circular(10)
                    ),
                    padding: EdgeInsets.all(8),
                    child: Text(e,style: TextStyle(color: MyColors.white,fontSize: 10),))).toList(),
              ),
            ),
            h10,
            Text(meal,style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500),),
            h06,
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('Frequency : ',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500),),
                Text(medFrequency,style: TextStyle(fontSize: 16),),
              ],
            ),
            h06,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Start Date',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500),),
                    Text(startDate,style: TextStyle(fontSize: 16),),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('End Date',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500),),
                    Text(endDate,style: TextStyle(fontSize: 16),),
                  ],
                ),
              ],
            ),
          ],
        ),
        actions: [
          regularTextButton(
              onPressed: ()=>Navigator.pop(context),
              text: 'Cancel'
          ),
          regularTextButton(
            bgColor: MyColors.primary,
              color: MyColors.white,
              onPressed: (){
                Navigator.pop(context);
                _loading();
                _setDateTime();
              },
              text: 'Save'
          )
        ],
      );
    });

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

  void _setDateTime() async{

    // print(selectedTime);

    List<DateTime> tempDateList = [];

    DateTime tempDate = selectedDate;
    DateTime tempTime = selectedTime;

    DateTime tempStartDate = DateTime(tempDate.year,tempDate.month,tempDate.day,tempTime.hour,tempTime.minute);

    int repeat = selectedFrequency.frequencyId;
    int interval = (24/repeat).round();

    tempDateList.add(tempStartDate);

    DateTime tempDates = tempStartDate;

    // for start date and time
    for(int j = 1; j < repeat;j++){
      tempDates = tempDates.add(Duration(hours: interval));
      tempDateList.add(tempDates);
    }


    if(selectedPattern.patternId == 1){
      for (int i = 1; i < totalDays; i++) {
        tempDates = tempDates.add(Duration(days: 1));

        for (int j = 0; j < repeat; j++) {
          DateTime tempDate = tempDates.add(Duration(hours: interval * j));
          tempDateList.add(tempDate);
        }
      }
    }
    //print(tempDateList);

    if (selectedPattern.patternId == 2) {
      int addedDays = 0; // Initialize addedDays to 0

      do {
        for (int j = 0; j < repeat; j++) {
          // Check if selectedDays contains the day of the week of tempDates
          if (selectedDays.contains(DateFormat('EEEE').format(tempDates))) {
            tempDateList.add(tempDates);
          }

          // Increment tempDates by the interval hours
          tempDates = tempDates.add(Duration(hours: interval));
        }

        // Increment addedDays by 1 after each iteration
        addedDays++;

        // Increment tempDates by 1 day
        tempDates = tempDates.add(Duration(days: 1));

        // Create a new instance of DateTime
        tempDates = DateTime.now();

        // Continue the loop while addedDays is less than the limit
      } while (addedDays < totalDays * scheduleTime.length);
    }

    if(selectedPattern.patternId == 3){
      // Create a new instance of DateTime
      DateTime tempDates = DateTime.now();

      for(int i = 1; i < totalDays; i++){
        tempDates = tempDates.add(Duration(days: intervalTime!));
        for(int j = 0; j < repeat;j++){
          // Create a new instance of DateTime
          DateTime tempDate = tempDates.add(Duration(hours: interval));
          tempDateList.add(tempDate);
        }
      }
    }


    setState(() {
      dateList = tempDateList;
    });

    _setReminder();


  }

  void _setReminder() async {


    final image = ref.watch(imageProvider);

    final strength = double.parse(_strengthController.text);

    final reminderPattern = ReminderPattern(
        patternId: selectedPattern.patternId,
        patternName: selectedPattern.patternName,
        daysOfInterval: intervalTime,
        daysOfWeek: selectedPattern.patternId == 2? selectedDays : null
    );


    MedicineModel medicineModel = MedicineModel(
        frequency: selectedFrequency,
        strength: strength,
        route: selectedRoute,
        reminderPattern: reminderPattern,
        reminderId: reminderId,
        reminderTypeId: 1,
        medicineName: _nameController.text.trim(),
        meal: selectedMeal,
        unit: selectedUnit,
        scheduleTime: scheduleTime,
        startDate: selectedDate,
        endDate: selectedDate.add(Duration(days: totalDays)),
        notificationIds: notificationIds,
        totalDays: totalDays,
        attachment: await image?.readAsBytes(),
        dateList: dateList,
        note: _noteController.text.isNotEmpty ? _noteController.text.trim() : null
    );

    for(int i in notificationIds){
      await AwesomeNotifications().cancel(i);
    }
    await Workmanager().cancelByUniqueName('1-${reminderId}');


    Map<String, dynamic> inputData = {
      'reminderId' : reminderId,
      'reminderTypeId' : 1,
      'title' : _nameController.text.trim(),
      'body' : '$strength ${selectedUnit.units} - ${selectedMeal.mealTime}',
      'dateList' : dateList.map((e) => e.toString()).toList()
    };

    String taskName = _nameController.text.trim();

    String uniqueName = '1-${reminderId}';

    Constraints constraints =Constraints(
      networkType: NetworkType.not_required,
      requiresBatteryNotLow: false,
      requiresCharging: false,
      requiresDeviceIdle: false,
      requiresStorageNotLow: false,
    );

    await Workmanager().registerPeriodicTask(uniqueName, taskName, inputData: inputData,constraints: constraints,frequency: Duration(hours: 4));




    Future.delayed(Duration(seconds: 2),(){
      ref.read(medicineReminderNotifier.notifier).editReminder(medicineModel: medicineModel, context: context).then((value) {
        ref.refresh(medReminderProvider);
        ref.refresh(medicineProvider(reminderId));
      });

    });



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
                            ref.read(imageProvider.notifier).camera();

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

                            ref.read(imageProvider.notifier).pickAnImage();

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
