





import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:marquee/marquee.dart';
import 'package:ministry/src/core/resources/color_manager.dart';
import 'package:ministry/src/features/public_notices/application/providers/notice_providers.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../../../../../core/resources/font_manager.dart';
import '../../../../../core/resources/gap_manager.dart';
import '../../../../dashboard/application/controller/dashboard_controller.dart';



class PublicNoticeMarquee extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final noticeAsyncValue = ref.watch(noticeProviders);

    return noticeAsyncValue.when(
      data: (notices) {
        if(notices.isEmpty){
          return h10;
        }
        List<String> noticeList = notices.where((e)=>e.shortInfo != null).map((e)=>e.shortInfo!.trim()).toList();
        final allNotices = noticeList.join('  |  ');

        return Card(
          elevation: 5,
          color: MyColors.white,
          margin: EdgeInsets.zero,
          child: Container(
            decoration: BoxDecoration(
              border:Border(
                  top: BorderSide(
                    color: MyColors.primary,
                  ),
                  bottom: BorderSide(
                      color: MyColors.primary
                  )
              ),
            ),
            // padding: EdgeInsets.symmetric(vertical: 8),
            child:  Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  height: 30,
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  color: MyColors.primary,
                  child: Center(child: Text('सूचना',style: wr1,)),
                ),

                Expanded(
                  child: InkWell(
                    onTap: (){
                      ref.read(dashboardController.notifier).changeNavIndex(0);
                      ref.read(dashboardController.notifier).changePageIndex(0);
                    },
                    child: Container(
                      height: 30,
                      child: Marquee(
                        blankSpace: 24,
                        velocity: 50,
                        text: allNotices,
                        style: br1,
                        scrollAxis: Axis.horizontal,
                        fadingEdgeEndFraction: 0.1,
                        fadingEdgeStartFraction: 0.1,
                      ),
                    ),
                  ),
                ),

              ],
            ),
          ),
        );
      },
      loading: () => h10,
      error: (err, stack) => h10,
    );
  }
}
