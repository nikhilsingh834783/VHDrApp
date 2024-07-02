import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:venus/app/app_common_widgets/sizer_constant.dart';
import 'package:venus/main.dart';

import '../controllers/bottom_bar_controller.dart';

class BottomBarView extends GetView<BottomBarController> {
  const BottomBarView({super.key});
  @override
  Widget build(BuildContext context) {
    Get.put(BottomBarController());
    return GetBuilder<BottomBarController>(builder: (controller) {
      return Obx(
        () => SafeArea(
            top: false,
            bottom: false,
            maintainBottomViewPadding: true,
            minimum: Platform.isIOS
                ? EdgeInsets.only(bottom: Sizes.crossLength * 0.026)
                : EdgeInsets.only(bottom: Sizes.crossLength * 0.015),
            child: Scaffold(
              body: PersistentTabView(
                context,
                confineInSafeArea: Platform.isAndroid ? true : false,
                controller: controller.persistentController,
                handleAndroidBackButtonPress: true,
                hideNavigationBarWhenKeyboardShows: true,
                popAllScreensOnTapOfSelectedTab: true,
                backgroundColor: Colors.white,
                navBarHeight:
                    hideBottomBar.value ? 0 : Sizes.crossLength * 0.070,
                decoration: NavBarDecoration(
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30)),
                  colorBehindNavBar: Colors.transparent,
                  // border: Border(
                  //     top: BorderSide(width: 1, color: ConstColor.borderColor)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      spreadRadius: 3.0,
                    ),
                  ],
                  adjustScreenBottomPaddingOnCurve: true,
                ),
                itemAnimationProperties: const ItemAnimationProperties(
                  duration: Duration(milliseconds: 200),
                  curve: Curves.ease,
                ),
                screenTransitionAnimation: const ScreenTransitionAnimation(
                  animateTabTransition: false,
                  curve: Curves.ease,
                  duration: Duration(milliseconds: 100),
                ),
                screens: controller.buildScreens(),
                items: controller.items(context),
                navBarStyle: NavBarStyle.style8,
                stateManagement: false,
                hideNavigationBar: false,
                resizeToAvoidBottomInset: true,
                bottomScreenMargin: Sizes.crossLength * 0.020,
                onItemSelected: (value) {
                  controller.onItemTapped(value);
                },
              ),
            )),
      );
    });
  }
}
