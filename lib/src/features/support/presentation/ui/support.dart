

import 'package:flutter/material.dart';
import 'package:ministry/src/core/utils/launch_url.dart';
import 'package:ministry/src/core/widgets/common_widgets.dart';
import 'package:ministry/src/features/support/data/support_info.dart';

import '../../../../core/resources/color_manager.dart';
import '../../../../core/resources/font_manager.dart';
import '../../../../core/resources/gap_manager.dart';

class Support extends StatelessWidget {
  const Support({super.key});

  @override
  Widget build(BuildContext context) {
    final support = supportInfo;
    return Scaffold(
      appBar: commonNavBar('Support'),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Contacts',style: bh2,),
              h10,
              _listTile(icon: Icons.phone, name: 'Contact No.', value: support['contact']!,onTap: ()=>ExternalLinks.makePhoneCall(support['contact']!)),
              _listTile(icon: Icons.mail, name: 'Email', value: support['email']!,onTap: ()=>ExternalLinks.sendEmail(support['email']!)),
              _listTile(icon: Icons.link, name: 'Website', value: support['website']!, onTap: ()=>ExternalLinks.url(support['website']!)),
              _listTile(icon: Icons.pin_drop, name: 'Address', value: support['address']!),
              h20,
              Text('About Us',style: bh2,),
              h10,
              _listTile(icon: Icons.play_arrow_sharp, name: 'Check for Updates', value: 'Version ${support['version']!}'),
              _listTile(icon: Icons.share, name: 'Share', value: 'Tap to share',onTap: () => ExternalLinks.share(support['playStore']!),)
            ],
          ),
        ),
      ),
    );
  }

  Widget _listTile({
    required IconData icon,
    required String name,
    required String value,
    VoidCallback? onTap
  }){
    return Material(
      child: ListTile(
        // shape: ContinuousRectangleBorder(
        //   borderRadius: BorderRadius.circular(12),
        //   side: BorderSide(
        //     color: MyColors.primary
        //   )
        // ),
        // tileColor: MyColors.primaryLight,
        onTap: onTap,
        leading: Icon(icon,color: MyColors.primary,),
        title: Text(name,style: bh3,),
        subtitle:Text(value) ,
      ),
    );
  }

}
