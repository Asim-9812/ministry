



import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ministry/src/features/health_tips/domain/model/health_tips_model.dart';
import 'package:ministry/src/features/public_notices/domain/model/notice_model.dart';

import '../../../../../core/resources/color_manager.dart';
import '../../../../../core/resources/font_manager.dart';
import '../../../../../core/resources/gap_manager.dart';

class NoticeDialog extends StatelessWidget {
  final NoticeModel notice;
  const NoticeDialog({required this.notice,super.key});

  @override
  Widget build(BuildContext context) {
    final date = DateFormat('yyyy-MM-dd hh:mm').format(DateTime.parse(notice.validDate!));
    return ListTile(
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
                        Text(notice.title ?? notice.code ?? '',style: bh1,),
                        Divider(),
                        Flexible(
                          child: SingleChildScrollView(
                            child: Text(notice.shortInfo!,
                                style: br1,textAlign: TextAlign.justify),
                          ),
                        ),
                        Flexible(
                          child: SingleChildScrollView(
                            child: Text(notice.description ?? '',
                                style: br1,textAlign: TextAlign.justify),
                          ),
                        ),
                        h10,
                        Text(date,style: br3),
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
      leading: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Image.asset('assets/images/logo.png'),
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(notice.title ?? notice.code ?? '',style: bh2,maxLines: 2,),
          Text(notice.shortInfo ?? notice.code ?? '',style: br2,maxLines: 2,),
          Text(date,style: br3),
        ],
      ),
    );
  }
}
