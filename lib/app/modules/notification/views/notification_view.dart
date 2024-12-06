import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:venus/app/app_common_widgets/my_drawer.dart';
import 'package:venus/app/modules/bottomBar/controllers/bottom_bar_controller.dart';

import '../../../../main.dart';
import '../../../app_common_widgets/common_import.dart';
import '../controllers/notification_controller.dart';

class NotificationView extends GetView<NotificationController> {
  const NotificationView({super.key});
  @override
  Widget build(BuildContext context) {
    print("Caaling");
    Get.put(NotificationController());
    return GetBuilder<NotificationController>(builder: (context) {
      return Scaffold(
        key: controller.scaffoldKey,
        appBar: AppBar(
          title: AppText(
            text: 'Notification',
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
        drawer: const MyDrawer(),
        onDrawerChanged: (isop) {
          if (!isop) {
            var bottomBarController = Get.put(BottomBarController());
            hideBottomBar.value = isop;
            bottomBarController.update();
          }
        },
        body: Obx(
          () => controller.apiCall.value
              ? Container()
              : controller.notificationListData.isEmpty
                  ? Center(
                      child: Padding(
                        padding:
                            EdgeInsets.only(bottom: Sizes.crossLength * 0.050),
                        child: AppText(
                          text: 'No data found',
                          fontSize: Sizes.px15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    )
                  : Column(
                      children: [
                        Expanded(
                          child: ListView.builder(
                            controller: controller.notificationScrollController,
                            padding: EdgeInsets.only(
                                bottom: Sizes.crossLength * 0.070),
                            itemCount: controller.notificationListData.length,
                            itemBuilder: (context, i) {
                              return Padding(
                                padding: EdgeInsets.only(
                                  left: Sizes.crossLength * 0.020,
                                  right: Sizes.crossLength * 0.020,
                                  top: Sizes.crossLength * 0.020,
                                ),
                                child: GestureDetector(
                                  onTap: () {},
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: ConstColor.whiteColor,
                                      boxShadow: const [
                                        BoxShadow(
                                          color: Colors.grey,
                                          blurRadius: 2.0,
                                        ),
                                      ],
                                      border: Border.all(
                                          width: 0.7,
                                          color: ConstColor.buttonColor),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(20.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                AppText(
                                                  text: controller
                                                          .notificationListData[
                                                              i]
                                                          .message ??
                                                      '',
                                                  fontSize: Sizes.px15,
                                                  fontWeight: FontWeight.w600,
                                                  fontColor:
                                                      ConstColor.blackTextColor,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        )
                      ],
                    ),
        ),
      );
    });
  }
}
