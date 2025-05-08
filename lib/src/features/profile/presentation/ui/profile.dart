


import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ministry/src/core/providers/user_info_provider.dart';
import 'package:ministry/src/core/resources/color_manager.dart';
import 'package:ministry/src/features/profile/presentation/ui/widgets/info_dialog.dart';

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
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  height: 200,
                  color: MyColors.red,
                  child: Stack(
                    children: [
                      Column(
                        children: [
                          Expanded(
                            flex: 4,
                            child: Container(
                              decoration: BoxDecoration(
                                  color: MyColors.primary,
                                  image: DecorationImage(image: AssetImage('assets/images/cover.png'),alignment: Alignment.bottomRight,fit: BoxFit.contain)
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Container(
                              color: MyColors.white,
                            ),
                          )
                        ],
                      ),

                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Card(
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
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('${userInfo.firstName} ${userInfo.lastName}',style: bh1,),
                          // w08,
                          // Icon(Icons.edit,color: MyColors.primary,size: 18,)
                        ],
                      ),
                      h30,
                      Row(
                        children: [
                          Expanded(
                            child: _listTile(icon: Icons.person, name: 'My Details',onTap: ()=>InfoDialog(context, userInfo)),
                          ),
                          w10,
                          Expanded(
                            child: _listTile(icon: Icons.group, name: 'My Family'),
                          ),
                        ],
                      ),
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
                h50
              ],
            ),
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
