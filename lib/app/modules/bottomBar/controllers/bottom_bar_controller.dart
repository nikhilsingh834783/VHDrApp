import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
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
          icon: Column(
            children: [
              Container(
                  height: 7,
                  width: 14,
                  decoration: const BoxDecoration(
                      color: ConstColor.buttonColor,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(100),
                        bottomRight: Radius.circular(100),
                      ))),
              const SizedBox(
                height: 10,
              ),
              SvgPicture.asset(
                ConstAsset.callSvg,
                height: Sizes.crossLength * 0.025,
                colorFilter: const ColorFilter.mode(
                  ConstColor.buttonColor,
                  BlendMode.srcIn,
                ),
              ),
            ],
          ),
          inactiveIcon: SvgPicture.asset(
            ConstAsset.callSvg,
            height: Sizes.crossLength * 0.025,
            colorFilter: const ColorFilter.mode(
              ConstColor.blackTextColor,
              BlendMode.srcIn,
            ),
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
        icon: Column(
          children: [
            Container(
                height: 7,
                width: 14,
                decoration: const BoxDecoration(
                    color: ConstColor.buttonColor,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(100),
                      bottomRight: Radius.circular(100),
                    ))),
            const SizedBox(
              height: 10,
            ),
            SvgPicture.asset(
              ConstAsset.homeSvg,
              height: Sizes.crossLength * 0.025,
            ),
          ],
        ),
        inactiveIcon: SvgPicture.asset(
          ConstAsset.homeSvg,
          height: Sizes.crossLength * 0.025,
          colorFilter: const ColorFilter.mode(
            ConstColor.blackTextColor,
            BlendMode.srcIn,
          ),
        ),
        activeColorPrimary: ConstColor.buttonColor,
      ),
      PersistentBottomNavBarItem(
        title: "Notification",
        textStyle: TextStyle(
            fontSize: Sizes.px12,
            fontWeight: FontWeight.w600,
            fontFamily: CommonFontStyle.plusJakartaSans),
        icon: Column(
          children: [
            Container(
                height: 7,
                width: 14,
                decoration: const BoxDecoration(
                    color: ConstColor.buttonColor,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(100),
                      bottomRight: Radius.circular(100),
                    ))),
            const SizedBox(
              height: 10,
            ),
            SvgPicture.asset(
              ConstAsset.notificationSvg,
              height: Sizes.crossLength * 0.025,
            ),
          ],
        ),
        inactiveIcon: SvgPicture.asset(
          ConstAsset.notificationSvg,
          height: Sizes.crossLength * 0.025,
          colorFilter: const ColorFilter.mode(
            ConstColor.blackTextColor,
            BlendMode.srcIn,
          ),
        ),
        activeColorPrimary: ConstColor.buttonColor,
      ),
    ];
  }

  void onItemTapped(int index) {
    update();
  }
}
