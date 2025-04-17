


import 'package:flutter/material.dart';
import 'package:ministry/src/core/widgets/common_widgets.dart';
import 'package:ministry/src/features/public_notices/presentation/ui/public_notices.dart';


class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBar('Notifications'),
      body: PublicNotices(),
    );
  }
}
