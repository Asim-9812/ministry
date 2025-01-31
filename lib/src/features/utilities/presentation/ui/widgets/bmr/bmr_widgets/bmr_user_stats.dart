


import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../../../core/resources/color_manager.dart';
import '../../../../../../../core/resources/font_manager.dart';
import '../../../../../../../core/resources/gap_manager.dart';
import '../../../../../application/bmi_controllers/bmi_controller.dart';
import '../../../../../application/bmr_controllers/bmr_controller.dart';

class BmrUserStats extends ConsumerWidget {
  const BmrUserStats({super.key});

  @override
  Widget build(BuildContext context,ref) {

    final gender = ref.watch(bmrController).genderIndex;
    final age = ref.watch(bmrController).age;
    final unit = ref.watch(bmrController).unitIndex;
    final height = ref.watch(bmrController).height;
    final heightInFt = ref.watch(bmrController).heightInFt;
    final controller = ref.watch(bmrController).weightController;
    final formKey = ref.watch(bmrController).formKey;

    return Expanded(
      flex: 1,
      child: Container(
        // color: MyColors.lightGrey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    color: MyColors.lightGrey,
                    borderRadius: BorderRadius.circular(8)
                ),
                padding: EdgeInsets.symmetric(vertical: 8),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(child: Text('Gender',style: bh3,)),
                    h10,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Radio(
                            activeColor: MyColors.primary,
                            value: 0,
                            groupValue: gender,
                            onChanged: (val){
                              ref.read(bmrController.notifier).changeGender(0);
                            }
                        ),
                        Text('Male',style: bh2,),
                      ],
                    ),
                    h10,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Radio(
                            activeColor: MyColors.primary,
                            value: 1,
                            groupValue: gender,
                            onChanged: (val){
                              ref.read(bmrController.notifier).changeGender(1);
                            }
                        ),
                        Text('Female',style: bh2,),
                      ],
                    ),
                  ],
                ),
              ),
              h10,
              Container(
                decoration: BoxDecoration(
                    color: MyColors.lightGrey,
                    borderRadius: BorderRadius.circular(8)
                ),
                width: double.infinity,
                padding: EdgeInsets.only(top: 8),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Text('Age in years',style: bh3,)),
                    PopupMenuButton(
                      color: MyColors.white,
                      position: PopupMenuPosition.under,
                      constraints: BoxConstraints(
                          maxHeight: 400
                      ),
                      icon: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('$age',style: bh2,),
                          Icon(Icons.arrow_drop_down)
                        ],
                      ),
                      offset: Offset(30, 0),
                      itemBuilder: (context){
                        return List.generate(90, (index){
                          return PopupMenuItem(
                              onTap: (){
                                ref.read(bmrController.notifier).updateAge(index+10);
                                FocusManager.instance.primaryFocus?.unfocus();
                              },
                              child: Text('${index+10}')
                          );
                        }).toList();
                      },
                    )
                  ],
                ),
              ),
              h10,
              Container(
                decoration: BoxDecoration(
                    color: MyColors.lightGrey,
                    borderRadius: BorderRadius.circular(8)
                ),
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 8),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Text('Weight in KG',style: bh3,)),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Form(
                        key: formKey,
                        child: TextFormField(
                          controller: controller,
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                            errorBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: MyColors.black
                              )
                            ),
                            border: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: MyColors.black
                              )
                            )
                          ),
                          style: bh1,
                          validator: (val){
                            if(val == null || val.trim().isEmpty){
                              return 'Required';
                            }
                            else{
                              try{
                                final doubleCheck = double.parse(val);
                              }catch(e){
                                return 'Invalid';
                              }
                            }
                            return null;
                          },
                          onChanged: (newVal){
                            try{
                              final doubleCheck = double.parse(newVal);
                              ref.read(bmrController.notifier).updateWeight(doubleCheck);
                            }catch(e){
                              print('Invalid');
                            }
                          },
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              h10,
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    color: MyColors.lightGrey,
                    borderRadius: BorderRadius.circular(8)
                ),
                padding: EdgeInsets.symmetric(vertical: 8),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text('Height',style: bh3,),
                    h10,
                    Text(unit == 0 ? '${height.round()} cm' : '${heightInFt.$1} ft',style: bh2,),
                    Divider(
                      endIndent: 8,
                      indent: 8,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Radio(
                                  activeColor: MyColors.primary,
                                  value: 0,
                                  groupValue: unit,
                                  onChanged: (val){
                                    ref.read(bmrController.notifier).changeUnit(0);
                                  }
                              ),
                              Text('CM',style: br1,),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Radio(
                                  activeColor: MyColors.primary,
                                  value: 1,
                                  groupValue: unit,
                                  onChanged: (val){
                                    ref.read(bmrController.notifier).changeUnit(1);
                                  }
                              ),
                              Text('FT',style: br1,),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
