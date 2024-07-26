import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:venus/app/modules/schedulechargelist/views/widgets/doctor_visit_list.dart';
import 'package:venus/app/modules/schedulechargelist/views/widgets/operation_class.dart';
import 'package:venus/app/modules/schedulechargelist/views/widgets/surgery_list.dart';

import '../../../app_common_widgets/common_import.dart';
import '../controllers/schedulechargelist_controller.dart';
import 'widgets/operation_name.dart';
import 'widgets/rooms_list_view.dart';

class SchedulechargelistView extends GetView<SchedulechargelistController> {
  const SchedulechargelistView({super.key});
  @override
  Widget build(BuildContext context) {
    Get.put(SchedulechargelistController());
    return GetBuilder<SchedulechargelistController>(
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            title: AppText(
              text: 'Schedule of Charges',
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
                icon: const Icon(Icons.arrow_back),
                onPressed: () => Navigator.pop(context)),
          ),
          backgroundColor: ConstColor.whiteColor,
          // drawer: const MyDrawer(),
          body: Padding(
            padding: EdgeInsets.only(
              left: Sizes.crossLength * 0.020,
              right: Sizes.crossLength * 0.020,
            ),
            child: Column(
              children: [
                SizedBox(
                  height: Sizes.crossLength * 0.025,
                ),
                Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: getDynamicHeight(size: 0.045),
                        child: AppButton(
                          radius: 45,
                          onPressed: () {
                            controller.searchController.clear();
                            controller.selectedTab = 0;
                            controller.getRooms(isLoader: false);
                            controller.update();
                          },
                          text: "Rooms",
                          fontSize: Sizes.px14,
                          textColor: controller.selectedTab == 0
                              ? ConstColor.whiteColor
                              : ConstColor.black6B6B6B,
                          bgColor: controller.selectedTab == 0
                              ? ConstColor.buttonColor
                              : ConstColor.whiteF2F2F2,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: getDynamicHeight(size: 0.015),
                    ),
                    Expanded(
                      child: SizedBox(
                        height: getDynamicHeight(size: 0.045),
                        child: AppButton(
                          radius: 45,
                          onPressed: () {
                            controller.searchController.clear();
                            controller.selectedTab = 1;
                            controller.getDoctorVisit(isLoader: false);
                            controller.update();
                          },
                          text: "Doctor Visit",
                          fontSize: Sizes.px14,
                          textColor: controller.selectedTab == 1
                              ? ConstColor.whiteColor
                              : ConstColor.black6B6B6B,
                          bgColor: controller.selectedTab == 1
                              ? ConstColor.buttonColor
                              : ConstColor.whiteF2F2F2,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: getDynamicHeight(size: 0.015),
                    ),
                    Expanded(
                      child: SizedBox(
                        height: getDynamicHeight(size: 0.045),
                        child: AppButton(
                          radius: 45,
                          onPressed: () {
                            controller.searchController.clear();
                            controller.selectedTab = 2;
                            controller.getOperationClass();
                            controller.update();
                          },
                          text: "Surgery",
                          fontSize: Sizes.px14,
                          textColor: controller.selectedTab == 2
                              ? ConstColor.whiteColor
                              : ConstColor.black6B6B6B,
                          bgColor: controller.selectedTab == 2
                              ? ConstColor.buttonColor
                              : ConstColor.whiteF2F2F2,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: getDynamicHeight(size: 0.020),
                ),
                AppTextField(
                  controller: controller.searchController,
                  onTap: () {
                    controller.update();
                  },
                  onChanged: (text) {
                    if (text.isEmpty) {
                      if (controller.selectedTab == 0) {
                        controller.getRooms(searchPrefix: '', isLoader: false);
                      } else if (controller.selectedTab == 1) {
                        controller.getDoctorVisit(
                            searchPrefix: '', isLoader: false);
                      } else {
                        controller.getSurgeries(
                            searchPrefix: '', isLoader: false);
                      }
                    } else {
                      if (controller.selectedTab == 0) {
                        controller.getRooms(
                            searchPrefix: text.trim(), isLoader: false);
                      } else if (controller.selectedTab == 1) {
                        controller.getDoctorVisit(
                            searchPrefix: text.trim(), isLoader: false);
                      } else {
                        controller.getSurgeries(
                            searchPrefix: text.trim(), isLoader: false);
                      }
                    }
                  },
                  textInputAction: TextInputAction.done,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 30),
                  onTapOutside: (event) {
                    FocusScope.of(context).unfocus();
                    controller.update();
                  },
                  onFieldSubmitted: (v) {
                    if (controller.searchController.text.trim().isNotEmpty) {
                      if (controller.selectedTab == 0) {
                        controller.getRooms(
                            searchPrefix:
                                controller.searchController.text.trim(),
                            isLoader: false);
                      } else if (controller.selectedTab == 1) {
                        controller.getDoctorVisit(
                            searchPrefix:
                                controller.searchController.text.trim(),
                            isLoader: false);
                      } else {
                        controller.getSurgeries(
                            searchPrefix:
                                controller.searchController.text.trim(),
                            isLoader: false);
                      }
                    }
                    Future.delayed(const Duration(milliseconds: 800));

                    controller.update();
                  },
                  suffixIcon: controller.searchController.text.trim().isNotEmpty
                      ? GestureDetector(
                          onTap: () {
                            FocusScope.of(context).unfocus();
                            controller.searchController.clear();
                            if (controller.selectedTab == 0) {
                              controller.getRooms(
                                  searchPrefix:
                                      controller.searchController.text.trim(),
                                  isLoader: false);
                            } else if (controller.selectedTab == 1) {
                              controller.getDoctorVisit(
                                  searchPrefix:
                                      controller.searchController.text.trim(),
                                  isLoader: false);
                            } else {
                              controller.getSurgeries(
                                  searchPrefix:
                                      controller.searchController.text.trim(),
                                  isLoader: false);
                            }
                          },
                          child: const Icon(Icons.cancel_outlined))
                      : const SizedBox(),
                  prefixIcon: SvgPicture.asset(
                    ConstAsset.searchSvg,
                    height: Sizes.crossLength * 0.020,
                    width: Sizes.crossLength * 0.020,
                  ),
                  hintText: 'Search here...',
                ),
                SizedBox(
                  height: Sizes.crossLength * 0.010,
                ),
                controller.selectedTab == 2
                    ? Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: CustomPopupMenu(
                                    showArrow: false,
                                    position: PreferredPosition.bottom,
                                    menuBuilder: () =>
                                        const OperationNameListView(),
                                    pressType: PressType.singleClick,
                                    verticalMargin: 5,
                                    horizontalMargin: 20,
                                    controller:
                                        controller.operationNamePopupController,
                                    menuOnChange: (t) {
                                      if (!t) {
                                        if (controller
                                            .operationClassController.text
                                            .trim()
                                            .isNotEmpty) {
                                          controller.getSurgeries(
                                              isLoader: true);
                                        }
                                      }
                                      print(t);
                                    },
                                    onTap: () {
                                      controller.operationNamePopupController
                                          .showMenu();
                                    },
                                    child: Container(
                                      height: 48,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.white,
                                        border: Border.all(
                                          width: 1,
                                          color: ConstColor.borderColor,
                                        ),
                                      ),
                                      child: Center(
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 10, right: 10),
                                          child: Row(
                                            children: [
                                              Expanded(
                                                  child: controller
                                                          .selectedOperationList
                                                          .isEmpty
                                                      ? AppText(
                                                          text:
                                                              'Select Surgery',
                                                          fontColor: ConstColor
                                                              .hintTextColor,
                                                        )
                                                      : ListView.builder(
                                                          itemCount: controller
                                                              .selectedOperationList
                                                              .length,
                                                          scrollDirection:
                                                              Axis.horizontal,
                                                          shrinkWrap: true,
                                                          itemBuilder:
                                                              (item, index) {
                                                            return Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .only(
                                                                      top: 7,
                                                                      bottom: 7,
                                                                      right:
                                                                          10),
                                                              child: Container(
                                                                width: 80,
                                                                height: 20,
                                                                decoration: BoxDecoration(
                                                                    boxShadow: const [
                                                                      BoxShadow(
                                                                        color: Colors
                                                                            .grey,
                                                                        blurRadius:
                                                                            2.0,
                                                                      ),
                                                                    ],
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            10),
                                                                    color: Colors
                                                                        .white),
                                                                child: Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .only(
                                                                          left:
                                                                              7,
                                                                          right:
                                                                              5),
                                                                  child: Row(
                                                                    children: [
                                                                      Expanded(
                                                                        child:
                                                                            AppText(
                                                                          text: controller.selectedOperationList[index].operationName ??
                                                                              '',
                                                                          maxLine:
                                                                              1,
                                                                          overflow:
                                                                              TextOverflow.ellipsis,
                                                                        ),
                                                                      ),
                                                                      GestureDetector(
                                                                          onTap:
                                                                              () {
                                                                            FocusScope.of(context).unfocus();
                                                                            controller.selectedOperationId.remove(controller.selectedOperationList[index].id);
                                                                            controller.selectedOperationList.remove(controller.selectedOperationList[index]);
                                                                            controller.update();
                                                                          },
                                                                          child:
                                                                              const Icon(
                                                                            Icons.cancel_outlined,
                                                                            size:
                                                                                20,
                                                                            color:
                                                                                ConstColor.errorBorderColor,
                                                                          ))
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                            );
                                                          })),
                                              SvgPicture.asset(
                                                ConstAsset.down,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    )),
                              ),
                              SizedBox(
                                width: Sizes.crossLength * 0.015,
                              ),
                              Expanded(
                                child: CustomPopupMenu(
                                  showArrow: false,
                                  position: PreferredPosition.bottom,
                                  menuBuilder: () => const OperationClassView(),
                                  pressType: PressType.singleClick,
                                  verticalMargin: 5,
                                  horizontalMargin: 20,
                                  controller:
                                      controller.operationClassPopupController,
                                  onTap: () {
                                    if (controller
                                        .selectedOperationId.isNotEmpty) {
                                      controller.operationClassPopupController
                                          .showMenu();
                                    } else {
                                      if (!Get.isSnackbarOpen) {
                                        Get.rawSnackbar(
                                            message: 'Please select surgery.');
                                      }
                                    }
                                  },
                                  child: AppTextField(
                                    isReadOnly: true,
                                    onTap: () {
                                      if (controller
                                          .selectedOperationId.isNotEmpty) {
                                        controller.operationClassPopupController
                                            .showMenu();
                                      } else {
                                        if (!Get.isSnackbarOpen) {
                                          Get.rawSnackbar(
                                              message:
                                                  'Please select surgery.');
                                        }
                                      }
                                    },
                                    hintText: "Select Class",
                                    controller:
                                        controller.operationClassController,
                                    suffixIcon: Padding(
                                      padding: const EdgeInsets.all(15.0),
                                      child: SvgPicture.asset(
                                        ConstAsset.down,
                                        height: 20,
                                        width: 20,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: Sizes.crossLength * 0.010,
                          ),
                        ],
                      )
                    : const SizedBox(),
                Expanded(
                    child: controller.selectedTab == 0
                        ? const RoomListView()
                        : controller.selectedTab == 1
                            ? const DoctorVisitList()
                            : const SurgerListView()),
              ],
            ),
          ),
        );
      },
    );
  }
}
