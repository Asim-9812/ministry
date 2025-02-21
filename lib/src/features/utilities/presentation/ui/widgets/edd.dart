


import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ministry/src/core/utils/toaster.dart';
import 'package:ministry/src/core/widgets/common_widgets.dart';
import 'package:nepali_date_picker/nepali_date_picker.dart' as picker;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nepali_date_picker/nepali_date_picker.dart';

import '../../../../../core/resources/color_manager.dart';
import '../../../../../core/resources/font_manager.dart';
import '../../../../../core/resources/gap_manager.dart';


class Edd extends StatefulWidget {
  const Edd({super.key});

  @override
  State<Edd> createState() => _EDDState();
}

class _EDDState extends State<Edd> {

  String disclaimer = 'Please note that due dates are estimates and can vary for each individual. Factors such as menstrual cycle length, ovulation, and other medical considerations can influence the actual delivery date. Consult with a healthcare professional for personalized guidance.';


  final _formKey = GlobalKey<FormState>();
  String? calculatedEDD;
  String? calculatedNepEDD;
  NepaliDateTime? NepRange;

  // Function to calculate Edd
  String calculateEDD(DateTime date) {
    int day = date.day ?? 1;
    int month = date.month ?? 1;
    int year = date.year ?? DateTime.now().year;


    DateTime lastPeriodDate = DateTime(year, month, day);
    DateTime edd = lastPeriodDate.add(Duration(days: 280)); // Adding 280 days for Edd

    return DateFormat('MMMM dd, yyyy').format(edd); // Format Edd date
  }

  String calculateNepaliEDD(NepaliDateTime date) {
    int day = date.day ?? 1;
    int month = date.month ?? 1;
    int year = date.year ?? DateTime.now().year;

    setState(() {
      NepRange = calculateNepaliEDDRange(date);
    });


    NepaliDateTime lastPeriodDate = NepaliDateTime(year, month, day);
    NepaliDateTime edd = lastPeriodDate.add(Duration(days: 280)); // Adding 280 days for Edd

    return NepaliDateFormat('MMMM dd, yyyy').format(edd); // Format Edd date
  }

  NepaliDateTime calculateNepaliEDDRange(NepaliDateTime date) {
    int day = date.day ?? 1;
    int month = date.month ?? 1;
    int year = date.year ?? DateTime.now().year;


    NepaliDateTime lastPeriodDate = NepaliDateTime(year, month, day);
    NepaliDateTime edd = lastPeriodDate.add(Duration(days: 280)); // Adding 280 days for Edd

    return edd; // Format Edd date
  }

  int dateType = 1;
  String dateTime = '' ;
  String nepDateTime = '' ;
  DateTime? initialDate;
  NepaliDateTime? initialNepDate;
  TextEditingController _dateController = TextEditingController();





  bool invalid = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: MyColors.white,
        appBar: commonNavBar('EDD'),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 18),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  h20,
                  Text(
                    'When was the first day of your last period?',
                    style: bh2,
                  ),
                  h20,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () async {
                            setState(() {
                              dateType = 1;
                              dateTime = '';
                              calculatedNepEDD = null;
                              invalid=false;
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            side: BorderSide(
                                color: MyColors.black
                            ),
                            elevation: 0,
                            backgroundColor: dateType==1? MyColors.primary : MyColors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)
                            ),
                          ),
                          child: Text('A.D.',style: TextStyle(color: dateType == 1 ? MyColors.white:MyColors.black,fontSize: 16),),
                        ),
                      ),
                      w06,
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () async {
                            setState(() {
                              dateType = 2;
                              nepDateTime = '';
                              calculatedEDD = null;
                              invalid=false;
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            side: BorderSide(
                                color: MyColors.black
                            ),
                            textStyle: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: dateType == 2 ? MyColors.white:MyColors.black
                            ),
                            elevation: 0,
                            backgroundColor:dateType==2? MyColors.red.withValues(alpha: 50) : MyColors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)
                            ),
                          ),
                          child: Text('B.S.',style: TextStyle(color: dateType == 2 ? MyColors.white:MyColors.black,fontSize: 16)),
                        ),
                      ),
                    ],
                  ),
                  h10,
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          onTap: () async {
                            if(dateType == 1){
                              final DateTime currentDate = DateTime.now();
                              final DateTime nineMonthsAgo = currentDate.subtract(Duration(days: 9 * 30));
                              final DateTime? pickedDate = await showDatePicker(
                                context: context,
                                initialDate: initialDate ?? DateTime.now(),
                                firstDate: nineMonthsAgo,
                                lastDate: DateTime.now(),
                              );
                              setState(() {
                                dateTime = DateFormat('yyyy-MM-dd').format(pickedDate!);
                                initialDate = pickedDate;
                                _dateController.text = dateTime;
                              });
                            }
                            else{
                              final NepaliDateTime currentNepaliDate = NepaliDateTime.now();
                              final NepaliDateTime nineMonthsAgo = currentNepaliDate.subtract(Duration(days: 9 * 30));
                              picker.NepaliDateTime? _selectedNepaliDate = await picker.showMaterialDatePicker(
                                context: context,
                                initialDate: initialNepDate?? NepaliDateTime.now(),
                                firstDate: nineMonthsAgo,
                                lastDate: NepaliDateTime.now(),
                                initialDatePickerMode: DatePickerMode.day,
                              );
                              setState(() {
                                nepDateTime = NepaliDateFormat('yyyy-MM-dd').format(_selectedNepaliDate!);
                                initialNepDate = _selectedNepaliDate;
                                _dateController.text = nepDateTime;
                              });
                            }
                          },
                          readOnly: true,
                          controller: _dateController,
                          decoration: InputDecoration(
                              isDense: true,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5)
                              ),
                              labelText: 'Date',
                              hintText: 'Select a date...',
                              suffixIcon: IconButton(
                                  onPressed: () async {
                                    if(dateType == 1){
                                      final DateTime currentDate = DateTime.now();
                                      final DateTime nineMonthsAgo = currentDate.subtract(Duration(days: 9 * 30));
                                      final DateTime? pickedDate = await showDatePicker(
                                        context: context,
                                        initialDate: initialDate ?? DateTime.now(),
                                        firstDate: nineMonthsAgo,
                                        lastDate: DateTime.now(),
                                      );
                                      setState(() {
                                        dateTime = DateFormat('yyyy-MM-dd').format(pickedDate!);
                                        initialDate = pickedDate;
                                        _dateController.text = dateTime;
                                      });
                                    }
                                    else{
                                      final NepaliDateTime currentNepaliDate = NepaliDateTime.now();
                                      final NepaliDateTime nineMonthsAgo = currentNepaliDate.subtract(Duration(days: 9 * 30));
                                      picker.NepaliDateTime? _selectedNepaliDate = await picker.showMaterialDatePicker(
                                        context: context,
                                        initialDate: initialNepDate?? NepaliDateTime.now(),
                                        firstDate: nineMonthsAgo,
                                        lastDate: NepaliDateTime.now(),
                                        initialDatePickerMode: DatePickerMode.day,
                                      );
                                      setState(() {
                                        nepDateTime = NepaliDateFormat('yyyy-MM-dd').format(_selectedNepaliDate!);
                                        initialNepDate = _selectedNepaliDate;
                                        _dateController.text = nepDateTime;
                                      });
                                    }
                                  },
                                  icon: Icon(CupertinoIcons.calendar,color: MyColors.primary,))
                          ),

                        ),
                      ),
                      w06,
                      IconButton(
                          style: IconButton.styleFrom(
                              backgroundColor: MyColors.primary
                          ),
                          onPressed: _final,
                          icon: Icon(Icons.arrow_forward_rounded,color: MyColors.white,)
                      ),
                    ],
                  ),
                  h10,
                  if (calculatedEDD != null)
                    Row(
                      // mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset('assets/images/misc/preg.jpg',width: 150,height: 150,),
                        Expanded(child: _adCalculator())
                      ],
                    ),

                  if (calculatedNepEDD != null)
                    Row(
                      // mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset('assets/images/misc/preg.jpg',width: 150,height: 150,),
                        Expanded(child: _bsCalculator())
                      ],
                    ),
                  h20,
                  Container(
                    padding: EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: MyColors.grey.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Disclaimer',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600),),
                        Text(disclaimer,textAlign: TextAlign.justify,),
                      ],
                    ),
                  )

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Function to calculate Edd range
  String calculateEDDRange() {
    DateTime edd = DateFormat('MMMM dd, yyyy').parse(calculatedEDD!); // Parse calculated Edd
    DateTime eddMinus7 = edd.subtract(Duration(days: 7)); // Subtract 7 days
    DateTime eddPlus7 = edd.add(Duration(days: 7)); // Add 7 days

    return DateFormat('MMMM dd, yyyy').format(eddMinus7) + ' to ' + DateFormat('MMMM dd, yyyy').format(eddPlus7);
  }

  String calculateNepEDDRange() {
    NepaliDateTime edd = NepRange ?? NepaliDateTime.now(); // Parse calculated Edd
    NepaliDateTime eddMinus7 = edd.subtract(Duration(days: 7)); // Subtract 7 days
    NepaliDateTime eddPlus7 = edd.add(Duration(days: 7)); // Add 7 days

    return NepaliDateFormat('MMMM dd, yyyy').format(eddMinus7) + ' to ' + NepaliDateFormat('MMMM dd, yyyy').format(eddPlus7);
  }


  void _final(){
    if(dateTime == '' && dateType ==1){
      Toaster.error('Please pick a date');
    }
    else if(nepDateTime == '' && dateType ==2){
      Toaster.error('Please pick a date');
    }
    else{
      if(dateType == 1){
        final DateTime date = DateTime.parse(DateFormat('yyyy-MM-dd').format(DateTime.parse(dateTime)));

        setState(() {
          invalid = false;
          calculatedEDD = calculateEDD(date);
        });
      }
      else{
        final NepaliDateTime date = NepaliDateTime.parse(NepaliDateFormat('yyyy-MM-dd').format(NepaliDateTime.parse(nepDateTime)));

        setState(() {
          invalid = false;
          calculatedNepEDD = calculateNepaliEDD(date);
        });
      }
      setState(() {
        _dateController.clear();
      });
    }
  }


  Widget _adCalculator(){
    return Container(
      height: 150,
      width: double.infinity,
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
          color: MyColors.grey.withOpacity(0.5),
          borderRadius: BorderRadius.circular(10)
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Estimated Due Date :',
              style: TextStyle(color: MyColors.black, fontSize: 14,fontWeight: FontWeight.w500),
            ),
            Text(
              '$calculatedEDD',
              style: TextStyle(color: MyColors.black, fontSize: 16),
            ),
            h10,
            Text(
              'Estimated Due Date Range :',
              style: TextStyle(color: MyColors.black, fontSize: 14,fontWeight: FontWeight.w500),
            ),
            Text(calculateEDDRange(),style: TextStyle(color: MyColors.black,fontSize: 16)),
          ],
        ),
      ),
    );
  }

  Widget _bsCalculator(){
    return Container(
      height: 150,
      width: double.infinity,
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
          color: MyColors.grey.withOpacity(0.5),
          borderRadius: BorderRadius.circular(10)
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Estimated Due Date :',
              style: TextStyle(color: MyColors.black, fontSize: 14,fontWeight: FontWeight.w500),
            ),
            Text(
              '$calculatedNepEDD',
              style: TextStyle(color: MyColors.black, fontSize: 16),
            ),
            h10,
            Text(
              'Estimated Due Date Range :',
              style: TextStyle(color: MyColors.black, fontSize: 14,fontWeight: FontWeight.w500),
            ),
            Text(calculateNepEDDRange(),style: TextStyle(color: MyColors.black,fontSize: 16)),
          ],
        ),
      ),
    );
  }




}
