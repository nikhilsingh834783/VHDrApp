import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../app_common_widgets/common_import.dart';
import '../../controllers/lab_reports_controller.dart';

class ReferenceWidget extends StatelessWidget {
  final List allReportsData;
  final double height;
  const ReferenceWidget(
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
                text: 'Normal Range',
                fontSize: Sizes.px13,
                fontColor: ConstColor.whiteColor,
                fontWeight: FontWeight.w700,
                textAlign: TextAlign.center,
              ),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          SizedBox(
            height: height,
            child: ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: allReportsData.length + 1,
                shrinkWrap: true,
                // controller: controller.scrollController1,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (item, i) {
                  return Column(
                    children: [
                      i == allReportsData.length
                          ? const SizedBox()
                          : SizedBox(
                              height: getDynamicHeight(size: 0.055),
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    AppText(
                                      text: allReportsData[i]['NormalRange'] !=
                                                  null &&
                                              allReportsData[i]
                                                      ['NormalRange'] !=
                                                  ''
                                          ? allReportsData[i]['NormalRange']
                                          : '-',
                                      fontSize: Sizes.px13,
                                      fontColor: ConstColor.black6B6B6B,
                                      fontWeight: FontWeight.w500,
                                      textAlign: TextAlign.center,
                                      maxLine: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    AppText(
                                      text: allReportsData[i]['Unit'] != null &&
                                              allReportsData[i]['Unit'] != ''
                                          ? allReportsData[i]['Unit']
                                          : '-',
                                      fontSize: Sizes.px9,
                                      fontColor: ConstColor.black6B6B6B,
                                      fontWeight: FontWeight.w500,
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
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
                              color: Colors.white,
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
