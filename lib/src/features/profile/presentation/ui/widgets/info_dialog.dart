



import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:ministry/src/core/resources/color_manager.dart';
import 'package:ministry/src/features/status_page/domain/model/user_model.dart';

import '../../../../../core/resources/font_manager.dart';
import '../../../../../core/resources/gap_manager.dart';

void InfoDialog(context, UserModel userInfo) async {

  await showDialog(context: context, builder: (context){

    final contact = (userInfo.contact == null || userInfo.contact!.trim().isEmpty)? '-' : userInfo.contact!;

    return Center(
      child: ZoomIn(
        child: Container(
          color: MyColors.white,
          width: double.infinity,
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text('My Details', style: bh2,),
              Divider(),
              h10,
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 50,
                        child: Icon(Icons.person),
                      ),
                      h10,
                      Text('${userInfo.firstName} ${userInfo.lastName}',style: bh2,maxLines: 1,),
                    ],
                  ),
                  w20,
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text('Code',style: br1,maxLines: 1,),
                                Text(userInfo.userName,style: bh2,maxLines: 1,),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text('Passport No.',style: br1,maxLines: 1,),
                                Text(userInfo.passportNo!,style: bh2,maxLines: 1,),
                              ],
                            ),

                          ],
                        ),
                        Text('Email',style: br1,maxLines: 1,),
                        Text(userInfo.email,style: bh2,maxLines: 1,),
                        Text('Contact',style: br1,maxLines: 1,),
                        Text(contact,style: bh2,maxLines: 1,),
                      ],
                    ),
                  ),
                ],
              ),
              h10,
              Row(
                children: [
                  Expanded(
                    child: TextButton(
                        style: TextButton.styleFrom(
                          shape: ContinuousRectangleBorder(
                            borderRadius: BorderRadius.circular(12)
                          ),
                          backgroundColor: MyColors.primary
                        ),
                        onPressed: ()=> Navigator.pop(context), child: Text('Edit',style: wh2,)),
                  ),
                  w10,
                  Expanded(
                    child: TextButton(
                        style: TextButton.styleFrom(
                            shape: ContinuousRectangleBorder(
                                borderRadius: BorderRadius.circular(12)
                            ),
                          backgroundColor: MyColors.green
                        ),
                        onPressed: ()=> Navigator.pop(context), child: Text('Ok',style: wh2,)),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );

  });


}