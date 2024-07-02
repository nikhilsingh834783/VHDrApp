import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:venus/app/app_common_widgets/common_text.dart';
import 'package:venus/app/app_common_widgets/my_drawer.dart';
import 'package:venus/app/app_common_widgets/sizer_constant.dart';
import 'package:venus/app/core/constant/asset_constant.dart';
import 'package:venus/app/core/them/const_color.dart';
import 'package:venus/app/modules/bottomBar/controllers/bottom_bar_controller.dart';
import 'package:venus/app/modules/patientlist/controllers/patientlist_controller.dart';
import 'package:venus/app/modules/patientlist/views/patientlist_view.dart';

import '../../../../main.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    Get.put(HomeController());
    return GetBuilder<HomeController>(
      builder: (controller) {
        return Scaffold(
          key: controller.scaffoldKey,
          appBar: AppBar(
            title: AppText(
              text: 'Dashboard',
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
            var bottomBarController = Get.put(BottomBarController());
            hideBottomBar.value = isop;
            bottomBarController.update();
          },
          body: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  controller: controller.scrollController,
                  padding: EdgeInsets.only(bottom: Sizes.crossLength * 0.070),
                  itemCount: 3,
                  itemBuilder: (context, i) {
                    return Padding(
                      padding: EdgeInsets.only(
                        left: Sizes.crossLength * 0.020,
                        right: Sizes.crossLength * 0.020,
                        top: Sizes.crossLength * 0.020,
                      ),
                      child: GestureDetector(
                        onTap: () {
                          if (i == 0) {
                            var patientController =
                                Get.put(PatientlistController());
                            patientController.getFilterData(isLoader: true);
                            PersistentNavBarNavigator.pushNewScreen(
                              context,
                              screen: const PatientlistView(),
                              withNavBar: true,
                              pageTransitionAnimation:
                                  PageTransitionAnimation.cupertino,
                            );
                            // Get.to(() => const PatientlistView());
                          } else {
                            if (!Get.isSnackbarOpen) {
                              Get.rawSnackbar(message: "Coming Soon");
                            }
                          }

                          //  else if (i == 1) {
                          //   PersistentNavBarNavigator.pushNewScreen(
                          //     context,
                          //     screen: const OpdAppointmentsView(),
                          //     withNavBar: true,
                          //     pageTransitionAnimation:
                          //         PageTransitionAnimation.cupertino,
                          //   );
                          //   // Get.to(() => const PatientlistView());
                          // } else {
                          //   PersistentNavBarNavigator.pushNewScreen(
                          //     context,
                          //     screen: const SchduleSurgeriesView(),
                          //     withNavBar: true,
                          //     pageTransitionAnimation:
                          //         PageTransitionAnimation.cupertino,
                          //   );
                          // }
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: ConstColor.whiteColor,
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.grey,
                                blurRadius: 2.0,
                                // offset: Offset(0, 1)
                              ),
                            ],
                            border: Border.all(
                                width: 0.7, color: ConstColor.buttonColor),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Flexible(
                                            child: AppText(
                                              text: i == 1
                                                  ? 'Appointments'
                                                  : i == 2
                                                      ? 'Schedule Surgeries / Procedures'
                                                      : 'Patients',
                                              fontSize: Sizes.px15,
                                              fontWeight: FontWeight.w600,
                                              fontColor:
                                                  ConstColor.blackTextColor,
                                              maxLine: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                          SizedBox(
                                            width: Sizes.crossLength * 0.005,
                                          ),
                                          SvgPicture.asset(
                                            ConstAsset.sideArrow,
                                            height: Sizes.crossLength * 0.015,
                                            width: Sizes.crossLength * 0.015,
                                          )
                                        ],
                                      ),
                                      SizedBox(
                                        height: Sizes.crossLength * 0.005,
                                      ),
                                      AppText(
                                        text: controller.dataForDashBoard !=
                                                    null &&
                                                controller.dataForDashBoard!
                                                        .data !=
                                                    null
                                            ? i == 1
                                                ? controller
                                                            .dataForDashBoard!
                                                            .data!
                                                            .appointmentCount
                                                            .toString()
                                                            .length <
                                                        2
                                                    ? "0${controller.dataForDashBoard!.data!.appointmentCount}"
                                                    : "${controller.dataForDashBoard!.data!.appointmentCount}"
                                                : i == 2
                                                    ? controller
                                                                .dataForDashBoard!
                                                                .data!
                                                                .scheduleSurgeriesCount
                                                                .toString()
                                                                .length <
                                                            2
                                                        ? "0${controller.dataForDashBoard!.data!.scheduleSurgeriesCount}"
                                                        : "${controller.dataForDashBoard!.data!.scheduleSurgeriesCount}"
                                                    : controller
                                                                .dataForDashBoard!
                                                                .data!
                                                                .patientCount
                                                                .toString()
                                                                .length <
                                                            2
                                                        ? "0${controller.dataForDashBoard!.data!.patientCount}"
                                                        : "${controller.dataForDashBoard!.data!.patientCount}"
                                            : '-',
                                        fontSize: Sizes.px40,
                                        fontWeight: FontWeight.w600,
                                        fontColor: ConstColor.blackTextColor,
                                      ),
                                    ],
                                  ),
                                ),
                                i == 1
                                    ? SvgPicture.asset(
                                        ConstAsset.surgiryImage,
                                        height: Sizes.crossLength * 0.050,
                                        width: Sizes.crossLength * 0.050,
                                      )
                                    : i == 2
                                        ? SvgPicture.asset(
                                            ConstAsset.viewSurgical,
                                            height: Sizes.crossLength * 0.050,
                                            width: Sizes.crossLength * 0.050,
                                          )
                                        : Image.asset(
                                            ConstAsset.patientImage,
                                            height: Sizes.crossLength * 0.050,
                                            width: Sizes.crossLength * 0.050,
                                          )
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
        );
      },
    );
  }
}
