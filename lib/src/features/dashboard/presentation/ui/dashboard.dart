
import 'package:flutter/material.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ministry/src/core/resources/color_manager.dart';
import 'package:ministry/src/features/dashboard/application/controller/dashboard_controller.dart';
import 'package:ministry/src/features/homepage/presentation/ui/homepage.dart';
import 'package:ministry/src/features/status_page/presentation/status_page.dart';
import 'package:ministry/src/features/utilities/presentation/ui/utilities.dart';
import '../../../notifications/presentation/ui/notifications.dart';
import '../../../old_reminder/reminders/reminders.dart';
import '../../../reminders/presentation/ui/reminders.dart';
import 'widgets/ask_permission.dart';




class Dashboard extends ConsumerWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context, ref) {


    Future.microtask(() => askPermissionDialog(context));


    final controller = ref.watch(dashboardController).pageController;
    final pageIndex = ref.watch(dashboardController).pageIndex;
    final navIndex = ref.watch(dashboardController).navIndex;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: PageView(
        onPageChanged: (value){  // for nav indicator to indicate correct index
          int newPageIndex = 0;
          int newNavIndex =0;
          if(value > 2){
            newPageIndex = value;
            newNavIndex = value-1;
          }
          else if(value == 2){
            newPageIndex = value;
            newNavIndex = -1;
          }
          else{
            newPageIndex = value;
            newNavIndex = value;
          }
          ref.read(dashboardController.notifier).changeNavIndex(newNavIndex);
          ref.read(dashboardController.notifier).changePageIndex(newPageIndex);
        },
        controller: controller,
        children: [
          NotificationPage(),
          // Reminders(),
          OldReminderTab(),
          Homepage(),
          Utilities(),
          StatusPage(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: 'dashFloat',
        splashColor: Colors.transparent,
        shape: const CircleBorder(),
        onPressed: (){
          int newPageIndex = 2;
          int newNavIndex = -1;
          ref.read(dashboardController.notifier).changeNavIndex(newNavIndex);
          ref.read(dashboardController.notifier).changePageIndex(newPageIndex);
        },
        backgroundColor:pageIndex == 2 ?  MyColors.primary : MyColors.white,
        child: Icon(Icons.home,color: pageIndex == 2 ? MyColors.white : MyColors.primary,size: 30,),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

      bottomNavigationBar: AnimatedBottomNavigationBar(
        elevation: 0,
        backgroundColor: MyColors.primary,
        notchMargin: 4,
        splashRadius: 0,
        // safeAreaValues: SafeAreaValues(left: false),
        icons:const [
          Icons.notifications,
          Icons.alarm,
          Icons.grid_view,
          Icons.person
        ],
        activeIndex: navIndex,
        activeColor: MyColors.white,
        inactiveColor: MyColors.lightBlue,
        gapLocation: GapLocation.center,
        notchSmoothness: NotchSmoothness.sharpEdge,
        onTap: (index) {
          int newPageIndex = 0;
          int newNavIndex = 0;
          if(index == 2 || index == 3){
            newPageIndex = index +1;
            newNavIndex = index;
          }
          else{
            newPageIndex = index;
            newNavIndex = index;
          }
          ref.read(dashboardController.notifier).changeNavIndex(newNavIndex);
          ref.read(dashboardController.notifier).changePageIndex(newPageIndex);
        },
        //other params
      ),
    );
  }
  
  

}
