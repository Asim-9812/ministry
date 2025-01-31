



import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:ministry/src/features/health_tips/domain/model/health_tips_model.dart';

import '../../../../../core/resources/color_manager.dart';
import '../../../../../core/resources/font_manager.dart';
import '../../../../../core/resources/gap_manager.dart';

class HealthTipDialog extends StatelessWidget {
  final HealthTipsModel healthTip;
  const HealthTipDialog({required this.healthTip,super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
        splashColor: Colors.transparent,
        onTap: () async {
          await showDialog(
              useSafeArea: false,
              context: context,
              builder: (context){
                return Center(
                  child: ZoomIn(
                    child: Container(
                      color: MyColors.white,
                      constraints: BoxConstraints(
                          maxHeight: 300
                      ),
                      width: double.infinity,
                      padding: EdgeInsets.all(16),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(healthTip.title,style: bh1,),
                          Divider(),
                          Flexible(
                            child: SingleChildScrollView(
                              child: Text(healthTip.description,
                                  style: br1,textAlign: TextAlign.justify),
                            ),
                          ),
                          h20,
                          TextButton(
                              style: TextButton.styleFrom(
                                  backgroundColor: MyColors.primary,
                                  shape: ContinuousRectangleBorder(
                                      borderRadius: BorderRadius.circular(12)
                                  )
                              ),
                              onPressed: (){
                                Navigator.pop(context);
                              },
                              child: Text('OK',style: wr1,)
                          )
                        ],
                      ),
                    ),
                  ),
                );
              }
          );
        },
        child: Text('See more',style: br3,));
  }
}
