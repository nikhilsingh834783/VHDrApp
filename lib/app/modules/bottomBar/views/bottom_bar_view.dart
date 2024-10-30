// import 'dart:io';
//
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
// import 'package:venus/app/app_common_widgets/sizer_constant.dart';
// import 'package:venus/main.dart';
//
// import '../controllers/bottom_bar_controller.dart';
//
// class BottomBarView extends GetView<BottomBarController> {
//   const BottomBarView({super.key});
//
//   // For getting desired shape as per figma just open project in android
// //studio and got style 8 decoration there make padding from 15 to 5
//
//   @override
//   Widget build(BuildContext context) {
//     Get.put(BottomBarController());
//     return GetBuilder<BottomBarController>(builder: (controller) {
//       return Obx(
//         () => Scaffold(
//           resizeToAvoidBottomInset: false,
//           body: PersistentTabView(
//             padding: const EdgeInsets.only(bottom: 0, top: 0),
//             //padding: const EdgeInsets.only(bottom: 10, top: 0),
//             context,
//             confineToSafeArea: Platform.isAndroid ? true : false,
//             controller: controller.persistentController,
//             // selectedTabScreenContext: (p0) {
//             //   controller.ctx = p0;
//             // },
//             handleAndroidBackButtonPress: true,
//             hideNavigationBarWhenKeyboardAppears: true,
//             popBehaviorOnSelectedNavBarItemPress: PopBehavior.all,
//             backgroundColor: Colors.white,
//             navBarHeight: hideBottomBar.value ? 0 : Sizes.crossLength * 0.082,
//             decoration: NavBarDecoration(
//               borderRadius: const BorderRadius.only(
//                   topLeft: Radius.circular(30), topRight: Radius.circular(30)),
//               colorBehindNavBar: Colors.transparent,
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.grey.withOpacity(0.1),
//                   spreadRadius: 3.0,
//                 ),
//               ],
//             ),
//             animationSettings: const NavBarAnimationSettings(
//               screenTransitionAnimation: ScreenTransitionAnimationSettings(
//                 animateTabTransition: false,
//                 curve: Curves.ease,
//                 duration: Duration(milliseconds: 200),
//               ),
//             ),
//
//             screens: controller.buildScreens(),
//             items: controller.items(),
//             navBarStyle: NavBarStyle.style8,
//             //stateManagement: true,
//             resizeToAvoidBottomInset: true,
//             bottomScreenMargin: Sizes.crossLength * 0.020,
//             onItemSelected: (index) {
//               controller.onItemTapped(index);
//             },
//             // popBehaviorOnSelectedNavBarItemPress: PopBehavior.once,
//             // selectedTabScreenContext: (contxt) {
//             //   controller.ctx = contxt;
//             // if (controller.ctx!.mounted) {
//             //   controller.update();
//             // }
//             // },
//             // adjustScreenBottomPaddingOnCurve: true,
//             // itemAnimationProperties: const ItemAnimationProperties(
//             //   duration: Duration(milliseconds: 200),
//             //   curve: Curves.ease,
//             // ),
//             // border: Border(
//             //     top: BorderSide(width: 1, color: ConstColor.borderColor)),
//           ),
//         ),
//       );
//     });
//   }
// }
//
//

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:venus/app/app_common_widgets/sizer_constant.dart';
import 'package:venus/main.dart';

import '../controllers/bottom_bar_controller.dart';

class BottomBarView extends GetView<BottomBarController> {
  const BottomBarView({super.key});

  // For getting desired shape as per figma just open project in android
//studio and got style 8 decoration there make padding from 15 to 5

  @override
  Widget build(BuildContext context) {
    Get.put(BottomBarController());
    return GetBuilder<BottomBarController>(builder: (controller) {
      return Obx(
        () => Scaffold(
          resizeToAvoidBottomInset: false,
          body: SafeArea(
            bottom: true,
            child: PersistentTabView(
              padding: const EdgeInsets.only(bottom: 0, top: 0),
              //padding: const EdgeInsets.only(bottom: 10, top: 0),
              context,
              confineToSafeArea: Platform.isAndroid ? true : false,
              controller: controller.persistentController,
              // selectedTabScreenContext: (p0) {
              //   controller.ctx = p0;
              // },
              handleAndroidBackButtonPress: true,
              hideNavigationBarWhenKeyboardAppears: true,
              popBehaviorOnSelectedNavBarItemPress: PopBehavior.all,
              backgroundColor: Colors.white,
              navBarHeight: hideBottomBar.value ? 0 : Sizes.crossLength * 0.082,
              decoration: NavBarDecoration(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(30), topRight: Radius.circular(30)),
                colorBehindNavBar: Colors.transparent,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 3.0,
                  ),
                ],
              ),
              animationSettings: const NavBarAnimationSettings(
                screenTransitionAnimation: ScreenTransitionAnimationSettings(
                  animateTabTransition: false,
                  curve: Curves.ease,
                  duration: Duration(milliseconds: 200),
                ),
              ),
            
              screens: controller.buildScreens(),
              items: controller.items(),
              navBarStyle: NavBarStyle.style8,

              //stateManagement: true,
              resizeToAvoidBottomInset: true,
              bottomScreenMargin: Sizes.crossLength * 0.020,
              onItemSelected: (index) {
                controller.onItemTapped(index);
              },
              // popBehaviorOnSelectedNavBarItemPress: PopBehavior.once,
              // selectedTabScreenContext: (contxt) {
              //   controller.ctx = contxt;
              // if (controller.ctx!.mounted) {
              //   controller.update();
              // }
              // },
              // adjustScreenBottomPaddingOnCurve: true,
              // itemAnimationProperties: const ItemAnimationProperties(
              //   duration: Duration(milliseconds: 200),
              //   curve: Curves.ease,
              // ),
              // border: Border(
              //     top: BorderSide(width: 1, color: ConstColor.borderColor)),
            ),
          ),
        ),
      );
    });
  }
}
