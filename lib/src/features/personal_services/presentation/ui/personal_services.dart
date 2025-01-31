



import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ministry/src/features/login/application/login_notifier.dart';
import 'package:ministry/src/features/personal_services/presentation/ui/widgets/blurred_services.dart';
import 'package:ministry/src/features/personal_services/presentation/ui/widgets/personal_services_list.dart';

class PersonalServices extends ConsumerWidget {
  const PersonalServices({super.key});

  @override
  Widget build(BuildContext context, ref) {

    final authState = ref.watch(loginNotifierProvider);

    return authState.user == null ? BlurredServices() : PersonalServicesList();
  }
}
