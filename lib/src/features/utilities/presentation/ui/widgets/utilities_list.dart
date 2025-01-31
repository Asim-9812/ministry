



import 'package:flutter/material.dart';
import 'package:ministry/src/core/resources/color_manager.dart';
import 'package:ministry/src/core/utils/page_route.dart';
import 'package:ministry/src/features/utilities/data/utilities_data.dart';

import '../../../../../core/resources/font_manager.dart';

class UtilitiesList extends StatelessWidget {
  const UtilitiesList({super.key});

  @override
  Widget build(BuildContext context) {
    final utilities = utilitiesList;
    return ListView.separated(
      itemCount: utilities.length,
        separatorBuilder: (context,index){
          return Divider(
            indent: 16,
            endIndent: 16,
            color: MyColors.grey,
          );
        },
        itemBuilder: (context,index){
        final utility = utilities[index];
        return ListTile(
          onTap: ()=>routeTo(context, utility.widget),
          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(utility.img),
          ),
          title: Text(utility.name,style: bh2,),
          subtitle: Text(utility.shortDesc,style: br2,),
          trailing: Icon(Icons.chevron_right_rounded),
          );
        }
    );
  }
}
