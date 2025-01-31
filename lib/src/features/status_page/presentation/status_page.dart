


import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ministry/src/features/login/presentation/ui/login.dart';
import 'package:ministry/src/features/profile/presentation/ui/profile.dart';

import '../../login/application/login_notifier.dart';

class StatusPage extends ConsumerWidget {
  const StatusPage({super.key});

  @override
  Widget build(BuildContext context, ref) {

    final authState = ref.watch(loginNotifierProvider);

    return authState.user == null ? LoginPage() : ProfilePage();
  }
}
