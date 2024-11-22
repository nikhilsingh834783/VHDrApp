import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:venus/app/modules/costestimate/views/costestimate_view.dart';
import 'package:venus/app/modules/otscheduler/views/otscheduler_view.dart';
import 'package:venus/main.dart';

import '../../../app_common_widgets/common_import.dart';
import '../../bottomBar/controllers/bottom_bar_controller.dart';
import '../../otscheduler/controllers/otscheduler_controller.dart';
import '../controllers/schdule_surgeries_controller.dart';
import 'widgets/schedule_calender.dart';

class SchduleSurgeriesView extends GetView<SchduleSurgeriesController> {
  const SchduleSurgeriesView({super.key});
  @override
  Widget build(BuildContext context) {
    Get.put(SchduleSurgeriesController());
    return GetBuilder<SchduleSurgeriesController>(
      builder: (controller) {
        return PopScope(
          onPopInvokedWithResult: (bool didPop, Object? result) async {
            // This can be async and you can check your condition
            backButtonPress();
          },
          child: Scaffold(
            appBar: AppBar(
              title: AppText(
                text: 'Surgeries/Procedures',
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
                  onPressed: () => backButtonPress()),
            ),
            backgroundColor: Colors.white,
            // drawer: const MyDrawer(),
            body: Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: Sizes.crossLength * 0.020),
              // padding: EdgeInsets.only(
              //   left: Sizes.crossLength * 0.020,
              //   right: Sizes.crossLength * 0.020,
              // ),
              child: Stack(
                alignment: Alignment.bottomCenter,
                fit: StackFit.passthrough,
                children: [
                  Column(
                    children: [
                      SizedBox(
                        height: Sizes.crossLength * 0.025,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: AppTextField(
                              controller: controller.searchController,
                              onTap: () {
                                controller.showShortButton = false;
                                controller.update();
                              },
                              onChanged: (text) {
                                controller.getSchduleListApi(
                                    searchPrefix: text.trim(), isLoader: false);
                              },
                              textInputAction: TextInputAction.done,
                              contentPadding:
                                  const EdgeInsets.symmetric(horizontal: 30),
                              onTapOutside: (event) {
                                FocusScope.of(context).unfocus();
                                // Future.delayed(const Duration(milliseconds: 300));
                                controller.showShortButton = true;
                                controller.update();
                              },
                              onFieldSubmitted: (v) {
                                if (controller.searchController.text
                                    .trim()
                                    .isNotEmpty) {
                                  controller.getSchduleListApi(
                                      searchPrefix: controller
                                          .searchController.text
                                          .trim(),
                                      isLoader: true);
                                }
                                Future.delayed(
                                    const Duration(milliseconds: 800));
                                controller.showShortButton = true;
                                controller.update();
                              },
                              suffixIcon: controller.searchController.text
                                      .trim()
                                      .isNotEmpty
                                  ? GestureDetector(
                                      onTap: () {
                                        FocusScope.of(context).unfocus();
                                        controller.searchController.clear();
                                        controller.getSchduleListApi(
                                            isLoader: false);
                                      },
                                      child: const Icon(Icons.cancel_outlined))
                                  : const SizedBox(),
                              prefixIcon: SvgPicture.asset(
                                ConstAsset.searchSvg,
                                height: Sizes.crossLength * 0.020,
                                width: Sizes.crossLength * 0.020,
                              ),
                              hintText: 'Search Patient',
                            ),
                          ),
                          SizedBox(
                            width: Sizes.crossLength * 0.015,
                          ),
                          CustomPopupMenu(
                              showArrow: false,
                              position: PreferredPosition.bottom,
                              menuBuilder: () => const ScheduleCalenderWidget(),
                              pressType: PressType.singleClick,
                              verticalMargin: 5,
                              horizontalMargin: 20,
                              controller: controller.selectedDateController,
                              onTap: () {
                                controller.selectedDateController.showMenu();
                              },
                              child: GestureDetector(
                                onTap: () {
                                  controller.selectedDateController.showMenu();
                                },
                                child: Container(
                                  height: Sizes.crossLength * 0.050,
                                  width: Sizes.crossLength * 0.050,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                        width: 1,
                                        color: ConstColor.borderColor),
                                  ),
                                  child: Center(
                                    child:
                                        SvgPicture.asset(ConstAsset.calender),
                                  ),
                                ),
                              )),
                        ],
                      ),
                      SizedBox(
                        height: Sizes.crossLength * 0.020,
                      ),
                      Expanded(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Align(
                            alignment: Alignment.topLeft,
                            child: AppText(
                              text: DateFormat('dd MMM yyyy')
                                  .format(controller.selectedScheduleDate),
                              fontSize: Sizes.px16,
                              fontWeight: FontWeight.w600,
                              fontColor: ConstColor.black6B6B6B,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Expanded(
                            child: controller.procedureListData.isEmpty
                                ? Center(
                                    child: controller.apiCall
                                        ? const SizedBox()
                                        : AppText(
                                            text: 'No data found',
                                            fontSize: Sizes.px15,
                                            fontWeight: FontWeight.w600,
                                          ),
                                  )
                                : RefreshIndicator(
                                    backgroundColor: ConstColor.whiteColor,
                                    color: ConstColor.buttonColor,
                                    onRefresh: () {
                                      return controller.getSchduleListApi(
                                          isLoader: false,
                                          searchPrefix: controller
                                              .searchController.text
                                              .trim());
                                    },
                                    child: ListView.builder(
                                      itemCount:
                                          controller.procedureListData.length,
                                      controller:
                                          controller.schduleScrollController,
                                      padding:
                                          const EdgeInsets.only(bottom: 70),
                                      shrinkWrap: true,
                                      physics:
                                          const AlwaysScrollableScrollPhysics(),
                                      itemBuilder: (context, index) {
                                        return Padding(
                                          padding: EdgeInsets.only(
                                              top: getDynamicHeight(
                                                  size: 0.015)),
                                          child: Container(
                                            clipBehavior: Clip.antiAlias,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                                color: ConstColor.whiteColor,
                                                border: Border.all(
                                                    width: 1,
                                                    color: ConstColor.blackColor
                                                        .withOpacity(0.2))),
                                            child: Column(
                                              children: [
                                                SizedBox(
                                                  height:
                                                      Sizes.crossLength * 0.010,
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                    left: Sizes.crossLength *
                                                        0.020,
                                                    right: Sizes.crossLength *
                                                        0.020,
                                                  ),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Expanded(
                                                            child: AppText(
                                                              text: controller
                                                                      .procedureListData[
                                                                          index]
                                                                      .patientName ??
                                                                  "",
                                                              fontSize:
                                                                  Sizes.px16,
                                                              letterSpacing:
                                                                  0.3,
                                                              fontColor: ConstColor
                                                                  .buttonColor,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            height:
                                                                getDynamicHeight(
                                                                    size:
                                                                        0.035),
                                                            width:
                                                                getDynamicHeight(
                                                                    size:
                                                                        0.130),
                                                            child: AppButton(
                                                                radius: 50,
                                                                fontSize:
                                                                    Sizes.px12,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                text:
                                                                    "Surgical Estimate",
                                                                onPressed: () {
                                                                  calenderType =
                                                                      2;
                                                                  previousDateEnable =
                                                                      false;
                                                                  controller
                                                                      .update();
                                                                  Get.to(const CostestimateView(),
                                                                          arguments: {
                                                                        "patientName": controller
                                                                            .procedureListData[index]
                                                                            .patientName,
                                                                        "speciality": controller
                                                                            .procedureListData[index]
                                                                            .speciality,
                                                                        "drId": controller
                                                                            .procedureListData[index]
                                                                            .drId,
                                                                        "operationDate": controller
                                                                            .procedureListData[index]
                                                                            .operationDate,
                                                                        "startTime": controller
                                                                            .procedureListData[index]
                                                                            .startTime,
                                                                        "endTime": controller
                                                                            .procedureListData[index]
                                                                            .endTime,
                                                                        "operationIds": controller
                                                                            .procedureListData[index]
                                                                            .operationIds,
                                                                        'fromSurgeryScren':
                                                                            true
                                                                      })!
                                                                      .then(
                                                                          (value) {
                                                                    calenderType =
                                                                        1;
                                                                    previousDateEnable =
                                                                        true;
                                                                    controller
                                                                        .update();
                                                                  });
                                                                }),
                                                          )
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        height:
                                                            Sizes.crossLength *
                                                                0.012,
                                                      ),
                                                      Row(
                                                        children: [
                                                          SvgPicture.asset(
                                                            ConstAsset
                                                                .phoneCall,
                                                            height: Sizes
                                                                    .crossLength *
                                                                0.020,
                                                            width: Sizes
                                                                    .crossLength *
                                                                0.020,
                                                            colorFilter:
                                                                const ColorFilter
                                                                    .mode(
                                                              ConstColor
                                                                  .buttonColor,
                                                              BlendMode.srcIn,
                                                            ),
                                                            // colorFilter: ,
                                                          ),
                                                          SizedBox(
                                                              width: Sizes
                                                                      .crossLength *
                                                                  0.008),
                                                          Container(
                                                            padding:
                                                                const EdgeInsets
                                                                    .only(
                                                              bottom:
                                                                  1, // Space between underline and text
                                                            ),
                                                            decoration:
                                                                const BoxDecoration(
                                                              border: Border(
                                                                bottom:
                                                                    BorderSide(
                                                                  color: ConstColor
                                                                      .buttonColor,
                                                                  width:
                                                                      1.0, // Underline thickness
                                                                ),
                                                              ),
                                                            ),
                                                            child: AppText(
                                                              text: controller
                                                                      .procedureListData[
                                                                          index]
                                                                      .mobileNo ??
                                                                  "",
                                                              fontSize:
                                                                  Sizes.px14,
                                                              fontColor: ConstColor
                                                                  .buttonColor,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        height:
                                                            Sizes.crossLength *
                                                                0.012,
                                                      ),
                                                      Row(
                                                        children: [
                                                          SvgPicture.asset(
                                                            ConstAsset.time,
                                                            // colorFilter: ,
                                                          ),
                                                          SizedBox(
                                                            width:
                                                                getDynamicHeight(
                                                                    size:
                                                                        0.010),
                                                          ),
                                                          AppText(
                                                            text: controller
                                                                    .procedureListData[
                                                                        index]
                                                                    .schTime ??
                                                                "",
                                                            fontSize:
                                                                Sizes.px14,
                                                            fontColor: ConstColor
                                                                .black6B6B6B,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                          ),
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        height:
                                                            Sizes.crossLength *
                                                                0.012,
                                                      ),
                                                      Row(
                                                        children: [
                                                          AppText(
                                                            text:
                                                                'Ass. Surgeon Name:',
                                                            fontSize:
                                                                Sizes.px14,
                                                            fontColor: ConstColor
                                                                .black6B6B6B,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                          ),
                                                          SizedBox(
                                                            width:
                                                                getDynamicHeight(
                                                                    size:
                                                                        0.005),
                                                          ),
                                                          AppText(
                                                            text: controller
                                                                    .procedureListData[
                                                                        index]
                                                                    .assisSurgnNm ??
                                                                "",
                                                            fontSize:
                                                                Sizes.px14,
                                                            fontColor: ConstColor
                                                                .black6B6B6B,
                                                            fontWeight:
                                                                FontWeight.w700,
                                                          ),
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        height:
                                                            Sizes.crossLength *
                                                                0.012,
                                                      ),
                                                      Row(
                                                        children: [
                                                          AppText(
                                                            text:
                                                                'Surgery Type:',
                                                            fontSize:
                                                                Sizes.px14,
                                                            fontColor: ConstColor
                                                                .black6B6B6B,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                          ),
                                                          SizedBox(
                                                            width:
                                                                getDynamicHeight(
                                                                    size:
                                                                        0.005),
                                                          ),
                                                          Expanded(
                                                            child: AppText(
                                                              text: controller
                                                                      .procedureListData[
                                                                          index]
                                                                      .surgeryName ??
                                                                  "",
                                                              fontSize:
                                                                  Sizes.px14,
                                                              fontColor: ConstColor
                                                                  .black6B6B6B,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        height:
                                                            Sizes.crossLength *
                                                                0.020,
                                                      ),
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                          ),
                        ],
                      )),
                    ],
                  ),
                  controller.showShortButton && !hideBottomBar.value
                      ? Padding(
                          padding: const EdgeInsets.only(bottom: 70),
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: SizedBox(
                                height: 45,
                                width: getDynamicHeight(size: 0.175),
                                child: AppButton(
                                  text: 'OT Schedule',
                                  onPressed: () {
                                    calenderType = 2;
                                    previousDateEnable = false;
                                    controller.update();
                                    var otschedulerController =
                                        Get.put(OtschedulerController());
                                    otschedulerController.selectedOperationId =
                                        [];
                                    otschedulerController
                                        .selectedOperationList = [];
                                    otschedulerController.selectedDate = null;
                                    otschedulerController
                                        .searchAdditionalDoctorList = null;
                                    otschedulerController
                                        .searchOperationNameListData = null;
                                    otschedulerController.getOrganizationList();
                                    otschedulerController.getOperationName();
                                    otschedulerController
                                        .getAdditionalSurgeon();
                                    Get.to(() => const OtschedulerView())!
                                        .then((value) {
                                      calenderType = 1;
                                      previousDateEnable = true;
                                      controller.update();
                                    }).then((value) {
                                      controller.getOpdSchdulesDates(
                                          isLoader: true);
                                      controller.getSchduleListApi(
                                          isLoader: true);
                                    });
                                  },
                                  bgColor: ConstColor.buttonColor,
                                  radius: 50,
                                )),
                          ),
                        )
                      : const SizedBox(
                          height: 10,
                        ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
