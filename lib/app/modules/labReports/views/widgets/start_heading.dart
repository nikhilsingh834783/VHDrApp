import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:venus/app/modules/labReports/views/widgets/ref.dart';

import '../../../../app_common_widgets/common_import.dart';
import '../../controllers/lab_reports_controller.dart';

class StartingHeading extends StatelessWidget {
  final List allReportsData;
  final double height;
  final List dateLsiting;
  const StartingHeading(
      {super.key,
      required this.allReportsData,
      required this.height,
      required this.dateLsiting});

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
            height: 90,
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
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      i == allReportsData.length
                          ? const SizedBox()
                          : SizedBox(
                              height: getHeightOfWidget(
                                  allReportsData[i]['NormalRange'] != null &&
                                          allReportsData[i]['NormalRange'] != ''
                                      ? allReportsData[i]['NormalRange']
                                      : '-',
                                  allReportsData[i]['Unit'] != null &&
                                          allReportsData[i]['Unit'] != ''
                                      ? allReportsData[i]['Unit']
                                      : '-',
                                  allReportsData,
                                  dateLsiting,
                                  i),
                              child: Center(
                                child: AppText(
                                  text: allReportsData[i]['TestName'] ?? '',
                                  fontSize: Sizes.px13,
                                  fontColor: ConstColor.buttonColor,
                                  fontWeight: FontWeight.w500,
                                  textAlign: TextAlign.center,
                                  // maxLine: 2,
                                  // overflow: TextOverflow.ellipsis,
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

getHeightOfWidget1(
    String text1, String text2, List alldata, List datesListing, int index) {
  if ((text1.length + text2.length) > 14) {
    return getDynamicHeight(size: 0.125);
  } else {
    // for (int i = 0; i < alldata.length; i++) {
    //   if (index == i) {
    //     for (int j = 0; j < datesListing.length; j++) {
    //       if (alldata[i][datesListing[j]].toString().length > 14) {
    //         return getDynamicHeight(size: 0.115);
    //       }
    //     }
    //   }
    // }
    return getDynamicHeight(size: 0.055);
  }
}
