import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:venus/app/app_common_widgets/app_font_name.dart';
import 'package:venus/app/app_common_widgets/sizer_constant.dart';
import 'package:venus/app/core/constant/asset_constant.dart';
import 'package:venus/app/core/them/const_color.dart';
import 'package:venus/app/modules/contact/views/contact_view.dart';
import 'package:venus/app/modules/home/views/home_view.dart';
import 'package:venus/app/modules/notification/views/notification_view.dart';
import 'package:venus/main.dart';

class BottomBarController extends GetxController {
  final count = 0.obs;
  PersistentTabController? persistentController =
      PersistentTabController(initialIndex: 1);

  @override
  void onInit() async {
    super.onInit();
    hideBottomBar.value = false;
    update();
  }

  List<Widget> buildScreens() {
    return [
      const ContactView(),
      const HomeView(),
      const NotificationView(),
    ];
  }

  List<PersistentBottomNavBarItem> items(BuildContext? ctx) {
    return [
      PersistentBottomNavBarItem(
          title: "Contacts",
          icon: SvgPicture.asset(
            ConstAsset.callSvg,
            color: ConstColor.buttonColor,
          ),
          inactiveIcon: SvgPicture.asset(
            ConstAsset.callSvg,
            height: Sizes.crossLength * 0.050,
            color: ConstColor.blackTextColor,
          ),
          activeColorPrimary: ConstColor.buttonColor,
          textStyle: TextStyle(
              fontSize: Sizes.px12,
              fontWeight: FontWeight.w600,
              fontFamily: CommonFontStyle.plusJakartaSans)),
      PersistentBottomNavBarItem(
        title: "Home",
        textStyle: TextStyle(
            fontSize: Sizes.px12,
            fontWeight: FontWeight.w600,
            fontFamily: CommonFontStyle.plusJakartaSans),
        icon: SvgPicture.asset(
          ConstAsset.homeSvg,
        ),
        inactiveIcon: SvgPicture.asset(
          ConstAsset.homeSvg,
          color: ConstColor.blackTextColor,
        ),
        activeColorPrimary: ConstColor.buttonColor,
      ),
      PersistentBottomNavBarItem(
        title: "Notification",
        textStyle: TextStyle(
            fontSize: Sizes.px12,
            fontWeight: FontWeight.w600,
            fontFamily: CommonFontStyle.plusJakartaSans),
        icon: SvgPicture.asset(
          ConstAsset.notificationSvg,
        ),
        inactiveIcon: SvgPicture.asset(
          ConstAsset.notificationSvg,
          color: ConstColor.blackTextColor,
        ),
        activeColorPrimary: ConstColor.buttonColor,
      ),
    ];
  }

  void onItemTapped(int index) {
    print("=====index---$index");
    update();
  }
}