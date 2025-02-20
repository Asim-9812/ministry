


import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ministry/src/core/providers/user_info_provider.dart';
import 'package:ministry/src/core/resources/color_manager.dart';
import 'package:ministry/src/features/dashboard/application/controller/dashboard_controller.dart';

import '../../../../core/resources/font_manager.dart';
import '../../../../core/resources/gap_manager.dart';
import '../../../login/application/login_notifier.dart';

class ProfilePage extends ConsumerWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final loginNotifier = ref.read(loginNotifierProvider.notifier);
    final userInfo = ref.watch(userInfoProvider);
    return SafeArea(
      child: GestureDetector(
        onTap: ()=>FocusScope.of(context).unfocus(),
        child: Scaffold(
          body: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 1,
                      child: Container(
                        decoration: BoxDecoration(
                            color: MyColors.primary,
                            image: DecorationImage(image: AssetImage('assets/images/cover.png'),alignment: Alignment.bottomRight,fit: BoxFit.contain)
                        ),
                      )
                  ),
                  Expanded(
                      flex: 4,
                      child: Container(
                        color: MyColors.white,
                      )
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.all(8),
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 2,
                      child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Card(
                            margin: EdgeInsets.only(right: 8),
                            elevation: 0,
                            shape: CircleBorder(
                                side: BorderSide(
                                    width: 2,
                                    color: MyColors.lightBlue
                                )
                            ),
                            child: CircleAvatar(
                              backgroundColor: MyColors.white,
                              radius: 48,
                              child: Icon(Icons.person,color: MyColors.primary,),
                            ),
                          ),
                          h10,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('${userInfo.firstName} ${userInfo.lastName}',style: bh1,),
                              w08,
                              Icon(Icons.edit,color: MyColors.primary,size: 18,)
                            ],
                          ),
                          h30,
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 4,
                      child: Container(
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: _listTile(icon: Icons.person, name: 'My Details'),
                                  ),
                                  w10,
                                  Expanded(
                                    child: _listTile(icon: Icons.group, name: 'My Family'),
                                  ),
                                ],
                              ),
                              h10,
                              _listTile(icon: Icons.support_agent, name: 'Help & Support'),
                              h10,
                              _listTile(icon: Icons.collections_bookmark, name: 'Privacy & Policy'),
                              h10,
                              _listTile(
                                  onTap: () async {
                                    await loginNotifier.logout().whenComplete((){
                                      ref.refresh(loginNotifierProvider);
                                    });
                                  },
                                  icon: Icons.logout, name: 'Log out'
                              ),
                              h50,
                              Text('Version 1.0.0',style: bh3,),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  
  Widget _listTile({
    required IconData icon,
    required String name,
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
      ),
    );
  }
  
}
