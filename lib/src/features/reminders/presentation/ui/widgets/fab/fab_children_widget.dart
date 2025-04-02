


import 'package:flutter/material.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ministry/src/core/utils/page_route.dart';

import '../../../../../../core/resources/color_manager.dart';
import '../../../../../../core/resources/font_manager.dart';
import '../../../../../../core/resources/gap_manager.dart';

class FabChildrenWidget extends StatelessWidget {
  final GlobalKey<ExpandableFabState> fabKey;
  final String name;
  final IconData icon;
  final Widget pageRoute;
  const FabChildrenWidget({required this.fabKey,required this.name, required this.icon, required this.pageRoute,super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(name,style: bh3,),
        w10,
        FloatingActionButton.small(
          backgroundColor: MyColors.primaryLight,
          heroTag: null,
          onPressed: (){
            final state = fabKey.currentState;
            if (state != null) {
              state.toggle();
            }
            routeTo(context, pageRoute);
          },
          child: FaIcon(icon,color: MyColors.primary,size: 18,),
        ),
      ],
    );
  }
}
