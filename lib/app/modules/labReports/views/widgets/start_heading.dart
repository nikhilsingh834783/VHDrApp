import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../app_common_widgets/common_import.dart';
import '../../controllers/lab_reports_controller.dart';

class StartingHeading extends StatelessWidget {
  const StartingHeading({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LabReportsController>(builder: (controller) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: const BoxDecoration(
              color: ConstColor.buttonColor,
            ),
            height: 50,
            child: Center(
              child: AppText(
                text: 'Test Name',
                fontSize: Sizes.px13,
                fontColor: ConstColor.whiteColor,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          SizedBox(
            height: Sizes.crossLength * .540,
            child: ListView.builder(
                padding: EdgeInsets.zero,
                // physics: const NeverScrollableScrollPhysics(),
                itemCount: controller.labReportsList.length,
                controller: controller.scrollController2,
                itemBuilder: (item, i) {
                  return Column(
                    children: [
                      SizedBox(
                        height: getDynamicHeight(size: 0.050),
                        child: Center(
                          child: AppText(
                            text: controller.labReportsList[i].testName ?? '',
                            fontSize: Sizes.px13,
                            fontColor: ConstColor.buttonColor,
                            fontWeight: FontWeight.w500,
                            textAlign: TextAlign.center,
                            maxLine: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                      Divider(
                        thickness: 1,
                        color: ConstColor.blackColor.withOpacity(0.3),
                      ),
                    ],
                  );
                }),
          )

          // SizedBox(
          //   height: getDynamicHeight(size: 0.040),
          //   child: Center(
          //     child: AppText(
          //       text: 'RBC count',
          //       fontSize: Sizes.px13,
          //       fontColor: ConstColor.buttonColor,
          //       fontWeight: FontWeight.w500,
          //     ),
          //   ),
          // ),
          // Divider(
          //   thickness: 1,
          //   color: ConstColor.blackColor.withOpacity(0.3),
          // ),
          // SizedBox(
          //   height: getDynamicHeight(size: 0.040),
          //   child: Center(
          //     child: AppText(
          //       text: 'P.C.V',
          //       fontSize: Sizes.px13,
          //       fontColor: ConstColor.buttonColor,
          //       fontWeight: FontWeight.w500,
          //     ),
          //   ),
          // ),
          // Divider(
          //   thickness: 1,
          //   color: ConstColor.blackColor.withOpacity(0.3),
          // ),
          // SizedBox(
          //   height: getDynamicHeight(size: 0.040),
          //   child: Center(
          //     child: AppText(
          //       text: 'Hemoglobin',
          //       fontSize: Sizes.px13,
          //       fontColor: ConstColor.buttonColor,
          //       fontWeight: FontWeight.w500,
          //     ),
          //   ),
          // ),
          // Divider(
          //   thickness: 1,
          //   color: ConstColor.blackColor.withOpacity(0.3),
          // ),
          // SizedBox(
          //   height: getDynamicHeight(size: 0.040),
          //   child: Center(
          //     child: AppText(
          //       text: 'RBC count',
          //       fontSize: Sizes.px13,
          //       fontColor: ConstColor.buttonColor,
          //       fontWeight: FontWeight.w500,
          //     ),
          //   ),
          // ),
          // Divider(
          //   thickness: 1,
          //   color: ConstColor.blackColor.withOpacity(0.3),
          // ),
          // SizedBox(
          //   height: getDynamicHeight(size: 0.040),
          //   child: Center(
          //     child: AppText(
          //       text: 'P.C.V',
          //       fontSize: Sizes.px13,
          //       fontColor: ConstColor.buttonColor,
          //       fontWeight: FontWeight.w500,
          //     ),
          //   ),
          // ),
          // Divider(
          //   thickness: 1,
          //   color: ConstColor.blackColor.withOpacity(0.3),
          // ),
          // SizedBox(
          //   height: getDynamicHeight(size: 0.040),
          //   child: Center(
          //     child: AppText(
          //       text: 'Hemoglobin',
          //       fontSize: Sizes.px13,
          //       fontColor: ConstColor.buttonColor,
          //       fontWeight: FontWeight.w500,
          //     ),
          //   ),
          // ),
          // Divider(
          //   thickness: 1,
          //   color: ConstColor.blackColor.withOpacity(0.3),
          // ),
          // SizedBox(
          //   height: getDynamicHeight(size: 0.040),
          //   child: Center(
          //     child: AppText(
          //       text: 'RBC count',
          //       fontSize: Sizes.px13,
          //       fontColor: ConstColor.buttonColor,
          //       fontWeight: FontWeight.w500,
          //     ),
          //   ),
          // ),
          // Divider(
          //   thickness: 1,
          //   color: ConstColor.blackColor.withOpacity(0.3),
          // ),
          // SizedBox(
          //   height: getDynamicHeight(size: 0.040),
          //   child: Center(
          //     child: AppText(
          //       text: 'P.C.V',
          //       fontSize: Sizes.px13,
          //       fontColor: ConstColor.buttonColor,
          //       fontWeight: FontWeight.w500,
          //     ),
          //   ),
          // ),
          // Divider(
          //   thickness: 1,
          //   color: ConstColor.blackColor.withOpacity(0.3),
          // ),
          // SizedBox(
          //   height: getDynamicHeight(size: 0.040),
          //   child: Center(
          //     child: AppText(
          //       text: 'Hemoglobin',
          //       fontSize: Sizes.px13,
          //       fontColor: ConstColor.buttonColor,
          //       fontWeight: FontWeight.w500,
          //     ),
          //   ),
          // ),
          // const SizedBox(
          //   height: 5,
          // )
        ],
      );
    });
  }
}
