


import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/resources/font_manager.dart';
import '../../../../../core/resources/gap_manager.dart';
import '../../../application/providers/notice_providers.dart';

class NoPublicNotices extends ConsumerWidget {
  const NoPublicNotices({super.key});

  @override
  Widget build(BuildContext context,ref) {
    return RefreshIndicator(
      onRefresh: () async {
        ref.refresh(noticeProviders);
        print('refreshed');
      },
      child: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        child: Container(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              h50,
              Padding(
                padding: const EdgeInsets.only(right: 32.0),
                child: Image.asset('assets/images/empty/noFiles.png'),
              ),
              h20,
              Text('No Notifications',style: bh2,),
              h50,
              h100,
            ],
          ),
        ),
      ),
    );
  }
}
