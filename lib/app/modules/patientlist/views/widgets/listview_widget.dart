import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:venus/app/app_common_widgets/common_text.dart';
import 'package:venus/app/app_common_widgets/sizer_constant.dart';
import 'package:venus/app/core/constant/asset_constant.dart';
import 'package:venus/app/core/them/const_color.dart';
import 'package:venus/app/modules/patientlist/model/patient_model.dart';

class PatientList extends StatelessWidget {
  final PatientListModel patientData;
  const PatientList({super.key, required this.patientData});

  @override
  Widget build(BuildContext context) {
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
                      child: AppText(
                        text: patientData.bedNo ?? "",
                        fontSize: Sizes.px14,
                        fontColor: ConstColor.whiteColor,
                        fontWeight: FontWeight.w500,
                        maxLine: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    SizedBox(
                      width: getDynamicHeight(size: 0.020),
                    ),
                    AppText(
                      text:
                          "${patientData.ward} -Floor ${patientData.floor.toString()}",
                      fontSize: Sizes.px14,
                      fontColor: ConstColor.whiteColor,
                      fontWeight: FontWeight.w500,
                      maxLine: 1,
                      overflow: TextOverflow.ellipsis,
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
                          text: patientData.patientName.toString().capitalize ??
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
                        padding: EdgeInsets.zero,
                        itemBuilder: (context) => [
                          // popupmenu item 1
                          PopupMenuItem(
                            value: 1,
                            child: AppText(
                              text: "Progress Summary",
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
                          // if (va == 1) {
                          if (!Get.isSnackbarOpen) {
                            Get.rawSnackbar(message: "Coming Soon");
                          }
                          //   Get.to(() => const ProgressSummaryView());
                          // } else if (va == 2) {
                          //   Get.to(() => const LabReportsView());
                          // } else if (va == 3) {
                          //   Get.to(() => const RadiologyReportView());
                          // } else if (va == 4) {
                          //   Get.to(() => const OtschedulerView());
                          // }
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
                                fontSize: Sizes.px14,
                                fontColor: ConstColor.black6B6B6B,
                                fontWeight: FontWeight.w500,
                                overflow: TextOverflow.ellipsis,
                                maxLine: 1,
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
                                      fontSize: Sizes.px14,
                                      fontColor: ConstColor.black6B6B6B,
                                      fontWeight: FontWeight.w500,
                                      overflow: TextOverflow.ellipsis,
                                      maxLine: 1,
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
  }
}
