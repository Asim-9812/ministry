

import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ministry/src/core/utils/shimmers.dart';
import 'package:ministry/src/features/public_notices/presentation/ui/widget/detailed_notice_dialog.dart';
import 'package:ministry/src/features/public_notices/presentation/ui/widget/loading_notices.dart';
import 'package:ministry/src/features/public_notices/presentation/ui/widget/no_notices.dart';
import '../../../../core/resources/color_manager.dart';
import '../../../../core/resources/font_manager.dart';
import '../../../../core/resources/gap_manager.dart';
import '../../application/providers/notice_providers.dart';

class PublicNotices extends ConsumerWidget {
  const PublicNotices({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final noticeAsyncValue = ref.watch(noticeProviders);
    return noticeAsyncValue.when(
        data: (notices){
          if(notices.isEmpty){
            return NoPublicNotices();
          }
          return ListView.separated(
            padding: EdgeInsets.only(bottom: 50),
            itemCount: notices.length,
              separatorBuilder: (context,index){
                return Divider(
                  color: MyColors.grey,
                  endIndent: 16,
                  indent: 16,
                );
              },
              itemBuilder: (context,index){
                final notice = notices[index];

                return NoticeDialog(notice: notice);
              }
          );
        },
        error: (error,stack)=>Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text('$error',style: bh2,),
        ),
        loading: ()=>LoadingNotices()
    );
  }
}
