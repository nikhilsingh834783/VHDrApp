import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../app_common_widgets/common_import.dart';
import '../../controllers/lab_reports_controller.dart';

class ReferenceWidget extends StatelessWidget {
  const ReferenceWidget({super.key});

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
                text: 'Ref.',
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
                itemCount: controller.labReportsList.length,
                controller: controller.scrollController1,
                itemBuilder: (item, i) {
                  return Column(
                    children: [
                      SizedBox(
                        height: getDynamicHeight(size: 0.050),
                        child: Center(
                          child: Column(
                            children: [
                              AppText(
                                text:
                                    controller.labReportsList[i].normalRange ??
                                        '-',
                                fontSize: Sizes.px13,
                                fontColor: ConstColor.black6B6B6B,
                                fontWeight: FontWeight.w500,
                                textAlign: TextAlign.center,
                                maxLine: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              AppText(
                                text: controller.labReportsList[i].unit ?? '-',
                                fontSize: Sizes.px9,
                                fontColor: ConstColor.black6B6B6B,
                                fontWeight: FontWeight.w500,
                                textAlign: TextAlign.center,
                              ),
                            ],
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
        ],
      );
    });
  }
}
