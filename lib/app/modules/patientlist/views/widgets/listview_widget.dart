import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:venus/app/modules/labReports/controllers/lab_reports_controller.dart';
import 'package:venus/app/modules/otscheduler/controllers/otscheduler_controller.dart';
import 'package:venus/app/modules/otscheduler/views/otscheduler_view.dart';
import 'package:venus/app/modules/patientlist/model/patient_model.dart';
import 'package:venus/app/modules/progressSummary/controllers/progress_summary_controller.dart';
import 'package:venus/app/modules/progressSummary/views/progress_summary_view.dart';
import 'package:venus/app/modules/radiologyReport/controllers/radiology_report_controller.dart';
import 'package:venus/app/modules/radiologyReport/views/radiology_report_view.dart';
import 'package:venus/main.dart';

import '../../../../app_common_widgets/common_import.dart';
import '../../../labReports/views/lab_reports_view_copy.dart';
import '../../controllers/patientlist_controller.dart';

class PatientList extends StatelessWidget {
  final PatientListModel patientData;
  final BuildContext textcontext;
  const PatientList(
      {super.key, required this.patientData, required this.textcontext});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PatientlistController>(builder: (controller) {
      return Padding(
        padding: EdgeInsets.only(
          left: Sizes.crossLength * 0.020,
          right: Sizes.crossLength * 0.020,
          top: Sizes.crossLength * 0.020,
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: ConstColor.whiteColor,
            boxShadow: const [
              BoxShadow(
                color: Colors.grey,
                blurRadius: 2.0,
                // offset: Offset(0, 1)
              ),
            ],
          ),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(Sizes.crossLength * 0.015),
                      topRight: Radius.circular(Sizes.crossLength * 0.015)),
                  color: patientData.patientCategory.toString().toLowerCase() ==
                          "Admitted".toLowerCase()
                      ? ConstColor.buttonColor
                      : ConstColor.refferedColor,
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: Sizes.crossLength * 0.010,
                    horizontal: Sizes.crossLength * 0.020,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 5,
                        child: AppText(
                          text: patientData.bedNo ?? "",
                          fontSize: Sizes.px13,
                          fontColor: ConstColor.whiteColor,
                          fontWeight: FontWeight.w500,
                          maxLine: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      SizedBox(
                        width: getDynamicHeight(size: 0.020),
                      ),
                      Expanded(
                        flex: 7,
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: AppText(
                            text:
                                "${patientData.ward} -Floor ${patientData.floor.toString()}",
                            fontSize: Sizes.px13,
                            fontColor: ConstColor.whiteColor,
                            fontWeight: FontWeight.w500,
                            maxLine: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
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
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: AppText(
                            text:
                                patientData.patientName.toString().capitalize ??
                                    '',
                            fontSize: Sizes.px16,
                            letterSpacing: 0.3,
                            fontColor: patientData.patientCategory
                                        .toString()
                                        .toLowerCase() ==
                                    "Admitted".toLowerCase()
                                ? ConstColor.buttonColor
                                : ConstColor.refferedColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        PopupMenuButton<int>(
                          onOpened: () {
                            controller.focusNode.unfocus();
                            FocusScope.of(textcontext).unfocus();
                            FocusScope.of(context).unfocus();
                            controller.showShortButton = true;
                            hideBottomBar.value = true;
                            controller.update();
                          },
                          onCanceled: () {
                            controller.focusNode.unfocus();
                            FocusScope.of(textcontext).unfocus();
                            FocusScope.of(context).unfocus();
                            hideBottomBar.value = false;
                          },
                          padding: EdgeInsets.zero,
                          itemBuilder: (context) => [
                            // popupmenu item 1
                            PopupMenuItem(
                              value: 1,
                              child: AppText(
                                // text: "Progress Summary",
                                text: "Clinical Summary",
                                fontSize: Sizes.px14,
                                fontWeight: FontWeight.w500,
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
                                fontSize: Sizes.px14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const PopupMenuDivider(
                              height: 1,
                            ),

                            PopupMenuItem(
                              value: 3,
                              child: AppText(
                                text: "Radiology Reports",
                                fontSize: Sizes.px14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const PopupMenuDivider(
                              height: 1,
                            ),

                            PopupMenuItem(
                              value: 4,
                              child: AppText(
                                text: "OT Schedule",
                                fontSize: Sizes.px14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                          offset: const Offset(0, 15),
                          color: ConstColor.whiteColor,
                          elevation: 5,
                          clipBehavior: Clip.none,
                          child: SvgPicture.asset(ConstAsset.moreOptions),
                          onSelected: (va) {
                            controller.focusNode.unfocus();
                            FocusScope.of(textcontext).unfocus();
                            FocusScope.of(context).unfocus();
                            hideBottomBar.value = false;

                            controller.update();
                            if (va == 1) {
                              var progreesController =
                                  Get.put(ProgressSummaryController());
                              progreesController.scrollListner();
                              progreesController.getProgressSummary(
                                  ipdNo: patientData.ipdNo ?? '',
                                  uhid: patientData.uhid ?? '');
                              progreesController.selectedIndex = [];
                              PersistentNavBarNavigator.pushNewScreen(
                                context,
                                screen: ProgressSummaryView(
                                  bedNumber: patientData.bedNo ?? '',
                                  patientName: patientData.patientName ?? "",
                                ),
                                withNavBar: true,
                                pageTransitionAnimation:
                                    PageTransitionAnimation.cupertino,
                              ).then((value) {
                                hideBottomBar.value = false;
                              });
                            } else if (va == 2) {
                              var labreportsController =
                                  Get.put(LabReportsController());
                              labreportsController.showSwipe = true;
                              hideBottomBar.value = true;
                              labreportsController.labReportsList = [];
                              labreportsController.allReportsList = [];
                              labreportsController.allDatesList = [];
                              labreportsController.update();
                              labreportsController.showSwipe = true;
                              hideBottomBar.value = true;
                              labreportsController.getLabReporst(
                                  ipdNo: patientData.ipdNo ?? '',
                                  uhidNo: patientData.uhid ?? '');
                              labreportsController.commonList = [];
                              labreportsController.dataContain = [];
                              labreportsController.scrollLister();
                              PersistentNavBarNavigator.pushNewScreen(
                                context,
                                screen: LabReportsViewCopy(
                                  bedNumber: patientData.bedNo ?? '',
                                  patientName: patientData.patientName ?? "",
                                ),
                                withNavBar: true,
                                pageTransitionAnimation:
                                    PageTransitionAnimation.cupertino,
                              ).then((value) {
                                hideBottomBar.value = false;
                              });
                            } else if (va == 3) {
                              var progreesController =
                                  Get.put(RadiologyReportController());
                              progreesController.allRadiologyList = [];
                              progreesController.getRadioLogyReport(
                                  ipdNo: patientData.ipdNo ?? '',
                                  uhidNo: patientData.uhid ?? '');
                              progreesController.scrollListner();
                              PersistentNavBarNavigator.pushNewScreen(
                                context,
                                screen: RadiologyReportView(
                                  bedNumber: patientData.bedNo ?? '',
                                  patientName: patientData.patientName ?? "",
                                ),
                                withNavBar: true,
                                pageTransitionAnimation:
                                    PageTransitionAnimation.cupertino,
                              ).then((value) {
                                hideBottomBar.value = false;
                              });
                            } else {
                              var otschedulerController =
                                  Get.put(OtschedulerController());
                              otschedulerController.getOrganizationList();
                              calenderType = 2;
                              previousDateEnable = false;
                              otschedulerController.selectedOperationId = [];
                              otschedulerController.selectedOperationList = [];
                              otschedulerController.selectedDate = null;
                              otschedulerController.searchAdditionalDoctorList =
                                  null;
                              otschedulerController
                                  .searchOperationNameListData = null;
                              otschedulerController.getOperationName();
                              otschedulerController.getAdditionalSurgeon();
                              otschedulerController.selectedDate = null;
                              otschedulerController.ipdTextController.text =
                                  patientData.ipdNo ?? '';
                              otschedulerController.mobileController.text =
                                  patientData.mobiileNo ?? '';
                              otschedulerController.uhidNumber.text =
                                  patientData.uhid ?? '';
                              otschedulerController.patientName.text =
                                  patientData.patientName
                                          .toString()
                                          .capitalize ??
                                      '';
                              otschedulerController.update();
                              Get.to(const OtschedulerView())!.then((value) {
                                hideBottomBar.value = false;
                              });
                            }
                          },
                        ),
                      ],
                    ),
                    SizedBox(
                      height: Sizes.crossLength * 0.012,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              SvgPicture.asset(
                                ConstAsset.paymentOptions,
                                height: Sizes.crossLength * 0.020,
                                width: Sizes.crossLength * 0.020,
                                colorFilter: ColorFilter.mode(
                                  patientData.patientCategory
                                              .toString()
                                              .toLowerCase() ==
                                          "Admitted".toLowerCase()
                                      ? ConstColor.buttonColor
                                      : ConstColor.refferedColor,
                                  BlendMode.srcIn,
                                ),
                                // colorFilter: ,
                              ),
                              SizedBox(width: Sizes.crossLength * 0.010),
                              Expanded(
                                child: AppText(
                                  text: patientData.admType ?? '',
                                  fontSize: Sizes.px13,
                                  fontColor: ConstColor.black6B6B6B,
                                  fontWeight: FontWeight.w500,
                                  overflow: TextOverflow.ellipsis,
                                  maxLine: 2,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: Sizes.crossLength * 0.010),
                        patientData.referredDr != null &&
                                patientData.referredDr != ''
                            ? Expanded(
                                child: Row(
                                  children: [
                                    SvgPicture.asset(
                                      ConstAsset.refferedDoctor,
                                      height: Sizes.crossLength * 0.020,
                                      width: Sizes.crossLength * 0.020,
                                      colorFilter: ColorFilter.mode(
                                        patientData.patientCategory
                                                    .toString()
                                                    .toLowerCase() ==
                                                "Admitted".toLowerCase()
                                            ? ConstColor.buttonColor
                                            : ConstColor.refferedColor,
                                        BlendMode.srcIn,
                                      ),
                                      // colorFilter: ,
                                    ),
                                    SizedBox(width: Sizes.crossLength * 0.010),
                                    Expanded(
                                      child: AppText(
                                        text: patientData.referredDr ?? '-',
                                        fontSize: Sizes.px13,
                                        fontColor: ConstColor.black6B6B6B,
                                        fontWeight: FontWeight.w500,
                                        overflow: TextOverflow.ellipsis,
                                        maxLine: 2,
                                      ),
                                    )
                                  ],
                                ),
                              )
                            : const SizedBox(),
                      ],
                    ),
                    SizedBox(
                      height: Sizes.crossLength * 0.012,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: AppText(
                            text: 'DOA: ${patientData.doa}',
                            fontSize: Sizes.px14,
                            fontColor: ConstColor.black6B6B6B,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(width: Sizes.crossLength * 0.010),
                        Expanded(
                          child: AppText(
                            text: 'Total Day: ${patientData.totalDays}',
                            fontSize: Sizes.px14,
                            fontColor: ConstColor.black6B6B6B,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: Sizes.crossLength * 0.020,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      );
    });
  }
}
