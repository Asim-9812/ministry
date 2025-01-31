

import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
                final date = DateFormat('yyyy-MM-dd hh:mm').format(DateTime.parse(notice.validDate));
                return ListTile(
                  leading: Image.asset('assets/images/logo.png'),
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(notice.shortInfo,style: br1,),
                      h10,
                      Text(date,style: br3),
                    ],
                  ),
                );
              }
          );
        }, 
        error: (err,stack){
          return SizedBox();
        },
        loading: (){
          return SizedBox();
        }
    );
  }
}
