


import 'package:flutter/material.dart';
import 'package:ministry/src/core/widgets/common_widgets.dart';
import 'package:ministry/src/features/utilities/presentation/ui/widgets/utilities_list.dart';

class Utilities extends StatelessWidget {
  const Utilities({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBar('Utilities'),
      body: UtilitiesList(),
    );
  }
}
