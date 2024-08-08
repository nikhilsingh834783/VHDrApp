import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:venus/app/modules/labReports/views/lab_reports_view%20copy.dart';
import 'package:venus/app/modules/opdAppointments/views/widgets/opd_calender.dart';
import 'package:venus/app/modules/progressSummary/controllers/progress_summary_controller.dart';
import 'package:venus/app/modules/progressSummary/views/progress_summary_view.dart';
import 'package:venus/main.dart';

import '../../../app_common_widgets/common_import.dart';
import '../../labReports/controllers/lab_reports_controller.dart';
import '../../radiologyReport/controllers/radiology_report_controller.dart';
import '../../radiologyReport/views/radiology_report_view.dart';
import '../controllers/opd_appointments_controller.dart';

class OpdAppointmentsView extends GetView<OpdAppointmentsController> {
  const OpdAppointmentsView({super.key});
  @override
  Widget build(BuildContext context) {
    Get.put(OpdAppointmentsController());
    return GetBuilder<OpdAppointmentsController>(
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            title: AppText(
              text: 'OPD Appointments',
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
          backgroundColor: Colors.white,
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
                      child: AppTextField(
                        focusNode: controller.focusNode,
                        controller: controller.searchController,
                        onTap: () {
                          hideBottomBar.value = true;
                          controller.update();
                        },
                        onChanged: (text) {
                          controller.getOpdAppointments(
                              searchPrefix: text.trim(), isLoader: false);
                        },
                        textInputAction: TextInputAction.done,
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 30),
                        onTapOutside: (event) {
                          FocusScope.of(context).unfocus();
                          hideBottomBar.value = false;
                          controller.update();
                        },
                        onFieldSubmitted: (v) {
                          hideBottomBar.value = false;
                          if (controller.searchController.text
                              .trim()
                              .isNotEmpty) {
                            controller.getOpdAppointments(
                                searchPrefix:
                                    controller.searchController.text.trim(),
                                isLoader: false);
                          }
                          Future.delayed(const Duration(milliseconds: 800));
                          controller.update();
                        },
                        suffixIcon:
                            controller.searchController.text.trim().isNotEmpty
                                ? GestureDetector(
                                    onTap: () {
                                      FocusScope.of(context).unfocus();
                                      controller.searchController.clear();
                                      controller.getOpdAppointments(
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

                      //  AppTextField(
                      //   onChanged: (text) {
                      //     controller.getOpdAppointments(
                      //         searchPrefix: text.trim(), isLoader: false);
                      //   },
                      //   onTapOutside: (s) {
                      //     FocusScope.of(context).unfocus();
                      //   },
                      //   contentPadding:
                      //       const EdgeInsets.symmetric(horizontal: 30),
                      //   prefixIcon: SvgPicture.asset(
                      //     ConstAsset.searchSvg,
                      //     height: Sizes.crossLength * 0.020,
                      //     width: Sizes.crossLength * 0.020,
                      //   ),
                      //   hintText: 'Search Patient',
                      // ),
                    ),
                    SizedBox(
                      width: Sizes.crossLength * 0.015,
                    ),
                    CustomPopupMenu(
                        showArrow: false,
                        position: PreferredPosition.bottom,
                        menuBuilder: () => const OpdCalender(),
                        pressType: PressType.singleClick,
                        verticalMargin: 5,
                        horizontalMargin: 20,
                        controller: controller.selectDateController,
                        onTap: () {
                          controller.selectDateController.showMenu();
                        },
                        child: GestureDetector(
                          onTap: () {
                            controller.selectDateController.showMenu();
                          },
                          child: Container(
                            height: Sizes.crossLength * 0.050,
                            width: Sizes.crossLength * 0.050,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                  width: 1, color: ConstColor.borderColor),
                            ),
                            child: Center(
                              child: SvgPicture.asset(ConstAsset.calender),
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
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: AppText(
                        text: DateFormat('dd MMM yyyy')
                            .format(controller.selectedDate),
                        fontSize: Sizes.px16,
                        fontWeight: FontWeight.w600,
                        fontColor: ConstColor.black6B6B6B,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Expanded(
                      child: controller.appointmentData.isEmpty
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
                                return controller.getOpdAppointments(
                                    isLoader: false,
                                    searchPrefix: controller
                                        .searchController.text
                                        .trim());
                              },
                              child: ListView.builder(
                                controller:
                                    controller.appointmentScrollController,
                                itemCount: controller.appointmentData.length,
                                shrinkWrap: true,
                                physics: controller.appointmentData.length < 3
                                    ? const NeverScrollableScrollPhysics()
                                    : const BouncingScrollPhysics(),
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: EdgeInsets.only(
                                        top: getDynamicHeight(size: 0.015)),
                                    child: Container(
                                      clipBehavior: Clip.hardEdge,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.rectangle,
                                        borderRadius: BorderRadius.circular(15),
                                        color: ConstColor.whiteColor,
                                        border: Border.all(
                                            width: 0.3, color: Colors.grey),
                                        boxShadow: const [
                                          BoxShadow(
                                            color: Colors.grey,
                                            blurRadius: 2.0,
                                          ),
                                        ],
                                      ),
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              Expanded(
                                                child: Container(
                                                  decoration:
                                                      const BoxDecoration(
                                                    color:
                                                        ConstColor.buttonColor,
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                      vertical:
                                                          Sizes.crossLength *
                                                              0.015,
                                                      horizontal:
                                                          Sizes.crossLength *
                                                              0.020,
                                                    ),
                                                    child: AppText(
                                                      text:
                                                          'Case Number: ${controller.appointmentData[index].caseNo}',
                                                      fontSize: Sizes.px14,
                                                      fontColor:
                                                          ConstColor.whiteColor,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      maxLine: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: Sizes.crossLength * 0.010,
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                              left: Sizes.crossLength * 0.020,
                                              right: Sizes.crossLength * 0.020,
                                            ),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Expanded(
                                                      child: AppText(
                                                        text:
                                                            '${controller.appointmentData[index].patientName}',
                                                        fontSize: Sizes.px16,
                                                        letterSpacing: 0.3,
                                                        fontColor: ConstColor
                                                            .buttonColor,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                    ),
                                                    PopupMenuButton<int>(
                                                      padding: EdgeInsets.zero,
                                                      itemBuilder: (context) =>
                                                          [
                                                        // popupmenu item 1
                                                        PopupMenuItem(
                                                          value: 1,
                                                          child: AppText(
                                                            text:
                                                                "Clinical Summary",
                                                            fontSize:
                                                                Sizes.px14,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                          ),
                                                        ),
                                                        const PopupMenuDivider(
                                                          height: 1,
                                                        ),

                                                        // popupmenu item 2
                                                        PopupMenuItem(
                                                          value: 2,
                                                          child: AppText(
                                                            text: "Lab Reports",
                                                            fontSize:
                                                                Sizes.px14,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                          ),
                                                        ),
                                                        const PopupMenuDivider(
                                                          height: 1,
                                                        ),

                                                        PopupMenuItem(
                                                          value: 3,
                                                          child: AppText(
                                                            text:
                                                                "Radiology Reports",
                                                            fontSize:
                                                                Sizes.px14,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                          ),
                                                        ),
                                                      ],
                                                      offset:
                                                          const Offset(0, 15),
                                                      color:
                                                          ConstColor.whiteColor,
                                                      elevation: 5,
                                                      onCanceled: () {
                                                        controller.focusNode
                                                            .unfocus();
                                                        FocusScope.of(context)
                                                            .unfocus();
                                                        hideBottomBar.value =
                                                            false;
                                                      },
                                                      onOpened: () {
                                                        controller.focusNode
                                                            .unfocus();

                                                        FocusScope.of(context)
                                                            .unfocus();

                                                        hideBottomBar.value =
                                                            true;
                                                        controller.update();
                                                      },
                                                      onSelected: (va) {
                                                        controller.focusNode
                                                            .unfocus();
                                                        FocusScope.of(context)
                                                            .unfocus();
                                                        hideBottomBar.value =
                                                            false;
                                                        controller.update();
                                                        if (va == 1) {
                                                          var progreesController =
                                                              Get.put(
                                                                  ProgressSummaryController());
                                                          progreesController
                                                              .scrollListner();
                                                          progreesController
                                                              .getProgressSummary(
                                                                  ipdNo: '',
                                                                  uhid: '');
                                                          PersistentNavBarNavigator
                                                              .pushNewScreen(
                                                            context,
                                                            screen:
                                                                ProgressSummaryView(
                                                              bedNumber: '',
                                                              patientName: controller
                                                                      .appointmentData[
                                                                          index]
                                                                      .patientName ??
                                                                  "",
                                                            ),
                                                            withNavBar: true,
                                                            pageTransitionAnimation:
                                                                PageTransitionAnimation
                                                                    .cupertino,
                                                          );
                                                        } else if (va == 2) {
                                                          var labreportsController =
                                                              Get.put(
                                                                  LabReportsController());
                                                          labreportsController
                                                              .labReportsList = [];
                                                          labreportsController
                                                              .allReportsList = [];
                                                          labreportsController
                                                              .allDatesList = [];
                                                          labreportsController
                                                              .update();
                                                          labreportsController
                                                              .showSwipe = true;
                                                          hideBottomBar.value =
                                                              true;
                                                          labreportsController.getLabReporst(
                                                              ipdNo: '',
                                                              uhidNo: controller
                                                                      .appointmentData[
                                                                          index]
                                                                      .uhid ??
                                                                  '');
                                                          labreportsController
                                                              .commonList = [];
                                                          labreportsController
                                                              .scrollLister();
                                                          PersistentNavBarNavigator
                                                              .pushNewScreen(
                                                            context,
                                                            screen:
                                                                LabReportsViewCopy(
                                                              bedNumber: '',
                                                              patientName: controller
                                                                      .appointmentData[
                                                                          index]
                                                                      .patientName ??
                                                                  "",
                                                            ),
                                                            withNavBar: true,
                                                            pageTransitionAnimation:
                                                                PageTransitionAnimation
                                                                    .cupertino,
                                                          );
                                                        } else if (va == 3) {
                                                          var progreesController =
                                                              Get.put(
                                                                  RadiologyReportController());
                                                          progreesController
                                                              .allRadiologyList = [];
                                                          progreesController
                                                              .scrollListner();
                                                          progreesController.getRadioLogyReport(
                                                              ipdNo: '',
                                                              uhidNo: controller
                                                                      .appointmentData[
                                                                          index]
                                                                      .uhid ??
                                                                  '');
                                                          PersistentNavBarNavigator
                                                              .pushNewScreen(
                                                            context,
                                                            screen:
                                                                RadiologyReportView(
                                                              bedNumber: '',
                                                              patientName: controller
                                                                      .appointmentData[
                                                                          index]
                                                                      .patientName ??
                                                                  "",
                                                            ),
                                                            withNavBar: true,
                                                            pageTransitionAnimation:
                                                                PageTransitionAnimation
                                                                    .cupertino,
                                                          );
                                                        }
                                                      },
                                                      clipBehavior: Clip.none,
                                                      child: SvgPicture.asset(
                                                          ConstAsset
                                                              .moreOptions),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height:
                                                      Sizes.crossLength * 0.012,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        SvgPicture.asset(
                                                          ConstAsset.newCase,
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
                                                                0.010),
                                                        AppText(
                                                          text:
                                                              '${controller.appointmentData[index].caseType}',
                                                          fontSize: Sizes.px14,
                                                          fontColor: ConstColor
                                                              .black6B6B6B,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        SvgPicture.asset(
                                                          ConstAsset.timer,
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
                                                                0.010),
                                                        AppText(
                                                          text:
                                                              '${controller.appointmentData[index].appTime}',
                                                          fontSize: Sizes.px14,
                                                          fontColor: ConstColor
                                                              .black6B6B6B,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height:
                                                      Sizes.crossLength * 0.012,
                                                ),
                                                AppText(
                                                  text:
                                                      'UHID: ${controller.appointmentData[index].uhid}',
                                                  fontSize: Sizes.px14,
                                                  fontColor:
                                                      ConstColor.black6B6B6B,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                                SizedBox(
                                                  height:
                                                      Sizes.crossLength * 0.020,
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
                    )
                  ],
                )),
                SizedBox(
                  height: Sizes.crossLength * 0.025,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
