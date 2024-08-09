import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../app_common_widgets/common_import.dart';
import '../../controllers/lab_reports_controller.dart';

class StartingHeading extends StatelessWidget {
  final List allReportsData;
  final double height;
  const StartingHeading(
      {super.key, required this.allReportsData, required this.height});

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
            height: height,
            child: ListView.builder(
                padding: const EdgeInsets.only(bottom: 16.0),
                physics: const NeverScrollableScrollPhysics(),
                itemCount: allReportsData.length + 1,
                itemBuilder: (item, i) {
                  return Column(
                    children: [
                      i == allReportsData.length
                          ? const SizedBox()
                          : SizedBox(
                              height: getDynamicHeight(size: 0.055),
                              child: Center(
                                child: AppText(
                                  text: allReportsData[i]['TestName'] ?? '',
                                  fontSize: Sizes.px13,
                                  fontColor: ConstColor.buttonColor,
                                  fontWeight: FontWeight.w500,
                                  textAlign: TextAlign.center,
                                  maxLine: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                      i == allReportsData.length
                          ? const SizedBox()
                          : Divider(
                              thickness: 1,
                              height: getDynamicHeight(size: 0.002),
                              color: ConstColor.blackColor.withOpacity(0.3),
                            ),
                      i == allReportsData.length
                          ? Container(
                              height: 10,
                            )
                          : const SizedBox()
                    ],
                  );
                }),
          )
        ],
      );
    });
  }
}
