// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:venus/main.dart';

import '../../../app_common_widgets/common_import.dart';
import '../controllers/radiology_report_controller.dart';
import 'widgets/pdf_report_view.dart';

class RadiologyReportView extends GetView<RadiologyReportController> {
  String patientName;
  String bedNumber;
  RadiologyReportView(
      {super.key, required this.patientName, required this.bedNumber});
  @override
  Widget build(BuildContext context) {
    Get.put(RadiologyReportController());
    return GetBuilder<RadiologyReportController>(
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            title: AppText(
              text: 'Radiology Reports',
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
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                          width: 1,
                          color: ConstColor.black6B6B6B.withOpacity(0.20))),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: getDynamicHeight(size: 0.012),
                      vertical: getDynamicHeight(size: 0.015),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: AppText(
                            text: patientName,
                            fontSize: Sizes.px14,
                            fontColor: ConstColor.buttonColor,
                            fontWeight: FontWeight.w600,
                            maxLine: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        SizedBox(
                          width: Sizes.crossLength * 0.015,
                        ),
                        bedNumber != ''
                            ? AppText(
                                text: 'Bed: $bedNumber',
                                fontSize: Sizes.px14,
                                fontColor: ConstColor.black6B6B6B,
                                fontWeight: FontWeight.w500,
                              )
                            : const SizedBox(),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: Sizes.crossLength * 0.015,
                ),
                controller.apiCall
                    ? const SizedBox()
                    : Expanded(
                        child: controller.allRadiologyList.isEmpty
                            ? Center(
                                child: AppText(
                                  text: "No data found",
                                  fontSize: Sizes.px15,
                                  fontWeight: FontWeight.w500,
                                ),
                              )
                            : ListView.builder(
                                itemCount: controller.allRadiologyList.length,
                                controller: controller.radioScrollController,
                                padding: EdgeInsets.only(
                                    bottom: hideBottomBar.value ? 10 : 70),
                                physics: const BouncingScrollPhysics(),
                                itemBuilder: (context, i) {
                                  return Padding(
                                    padding: EdgeInsets.only(
                                        top: getDynamicHeight(size: 0.020)),
                                    child: Container(
                                      clipBehavior: Clip.hardEdge,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          border: Border.all(
                                              width: 1,
                                              color: ConstColor.buttonColor)),
                                      child: Column(
                                        children: [
                                          Container(
                                            decoration: const BoxDecoration(
                                              color: ConstColor.buttonColor,
                                            ),
                                            child: Row(
                                              children: [
                                                Expanded(
                                                  child: Padding(
                                                    padding: EdgeInsets.only(
                                                      top: getDynamicHeight(
                                                          size: 0.010),
                                                      left: getDynamicHeight(
                                                          size: 0.010),
                                                      bottom: getDynamicHeight(
                                                          size: 0.010),
                                                    ),
                                                    child: AppText(
                                                      text: getDate(controller
                                                              .allRadiologyList[
                                                                  i]
                                                              .rptDate ??
                                                          ''),
                                                      fontSize: Sizes.px13,
                                                      fontColor:
                                                          ConstColor.whiteColor,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                              horizontal:
                                                  getDynamicHeight(size: 0.015),
                                            ),
                                            child: Column(
                                              children: [
                                                SizedBox(
                                                  height: getDynamicHeight(
                                                      size: 0.010),
                                                ),

                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    AppText(
                                                      text:
                                                          '${controller.allRadiologyList[i].testName}',
                                                      fontSize: Sizes.px14,
                                                      fontColor: ConstColor
                                                          .black4B4D4F,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                    GestureDetector(
                                                        onTap: () {
                                                          Get.to(() =>
                                                              RadiologyPdfView(
                                                                url: controller
                                                                        .allRadiologyList[
                                                                            i]
                                                                        .reportURL ??
                                                                    '',
                                                              ));
                                                        },
                                                        child: SvgPicture.asset(
                                                            ConstAsset.eye))
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: getDynamicHeight(
                                                      size: 0.010),
                                                ),
                                                // i ==
                                                //         controller
                                                //                 .allRadiologyList
                                                //                 .length -
                                                //             1
                                                //     ? const SizedBox()
                                                //     : Divider(
                                                //         thickness: 1,
                                                //         color: ConstColor
                                                //             .blackColor
                                                //             .withOpacity(0.10),
                                                //       )
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            height:
                                                getDynamicHeight(size: 0.010),
                                          ),
                                          // ListView.builder(
                                          //     shrinkWrap: true,
                                          //     physics:
                                          //         const NeverScrollableScrollPhysics(),
                                          //     itemCount: 5,
                                          //     padding: EdgeInsets.symmetric(
                                          //         vertical:
                                          //             getDynamicHeight(size: 0.010)),
                                          //     itemBuilder: (context, itemIndex) {
                                          //       return Padding(
                                          //         padding: EdgeInsets.symmetric(
                                          //           horizontal:
                                          //               getDynamicHeight(size: 0.015),
                                          //         ),
                                          //         child: Column(
                                          //           children: [
                                          //             SizedBox(
                                          //               height:
                                          //                   getDynamicHeight(size: 0.010),
                                          //             ),
                                          //             Row(
                                          //               mainAxisAlignment:
                                          //                   MainAxisAlignment
                                          //                       .spaceBetween,
                                          //               children: [
                                          //                 AppText(
                                          //                   text:
                                          //                       'Test Name: High sensitive troponin',
                                          //                   fontSize: Sizes.px14,
                                          //                   fontColor:
                                          //                       ConstColor.black4B4D4F,
                                          //                   fontWeight: FontWeight.w600,
                                          //                 ),
                                          //                 GestureDetector(
                                          //                     onTap: () {
                                          //                       Get.to(() =>
                                          //                           const RadiologyPdfView());
                                          //                     },
                                          //                     child: SvgPicture.asset(
                                          //                         ConstAsset.eye))
                                          //               ],
                                          //             ),
                                          //             SizedBox(
                                          //               height:
                                          //                   getDynamicHeight(size: 0.010),
                                          //             ),
                                          //             itemIndex == 4
                                          //                 ? const SizedBox()
                                          //                 : Divider(
                                          //                     thickness: 1,
                                          //                     color: ConstColor.blackColor
                                          //                         .withOpacity(0.10),
                                          //                   )
                                          //           ],
                                          //         ),
                                          //       );
                                          //     })
                                        ],
                                      ),
                                    ),
                                  );
                                }),
                      ),
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

getDate(String dateString) {
  try {
    List dateList = dateString.split('/');
    return DateFormat("dd MMMM yyyy")
        .format(DateTime.parse("${dateList[2]}-${dateList[1]}-${dateList[0]}"));
  } catch (e) {
    return dateString;
  }
}
