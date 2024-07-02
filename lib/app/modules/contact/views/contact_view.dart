import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:venus/app/app_common_widgets/common_text.dart';
import 'package:venus/app/app_common_widgets/my_drawer.dart';
import 'package:venus/app/app_common_widgets/sizer_constant.dart';
import 'package:venus/app/core/them/const_color.dart';
import 'package:venus/app/modules/bottomBar/controllers/bottom_bar_controller.dart';
import 'package:venus/main.dart';

import '../controllers/contact_controller.dart';

class ContactView extends GetView<ContactController> {
  const ContactView({super.key});
  @override
  Widget build(BuildContext context) {
    Get.put(ContactController());
    return GetBuilder<ContactController>(builder: (controller) {
      return Scaffold(
        key: controller.scaffoldKey,
        appBar: AppBar(
          title: AppText(
            text: 'Contact',
            fontSize: Sizes.px22,
            fontColor: ConstColor.headingTexColor,
            fontWeight: FontWeight.w800,
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 2,
          excludeHeaderSemantics: false,
          surfaceTintColor: Colors.white,
          shadowColor: Colors.grey,
          leading: IconButton(
              icon: SvgPicture.asset('assets/images/svg/menu.svg'),
              onPressed: () =>
                  controller.scaffoldKey.currentState!.openDrawer()),
        ),
        backgroundColor: Colors.white,
        onDrawerChanged: (isop) {
          var bottomBarController = Get.put(BottomBarController());
          hideBottomBar.value = isop;
          bottomBarController.update();
        },
        drawer: const MyDrawer(),
        body: const Center(
          child: Text(
            'Coming Soon...',
            style: TextStyle(fontSize: 20),
          ),
        ),
      );
    });
  }
}
