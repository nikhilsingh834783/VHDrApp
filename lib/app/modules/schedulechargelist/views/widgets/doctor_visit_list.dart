import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:venus/app/modules/schedulechargelist/controllers/schedulechargelist_controller.dart';

import '../../../../../main.dart';
import '../../../../app_common_widgets/common_import.dart';

class DoctorVisitList extends StatelessWidget {
  const DoctorVisitList({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SchedulechargelistController>(builder: (controller) {
      return controller.doctorsListData.isEmpty
          ? Center(
              child: AppText(
                text: 'No data found',
                fontSize: Sizes.px15,
                fontWeight: FontWeight.w600,
              ),
            )
          : ListView.builder(
              itemCount: controller.doctorsListData.length,
              physics: controller.doctorsListData.length < 3
                  ? const NeverScrollableScrollPhysics()
                  : const BouncingScrollPhysics(),
              padding: EdgeInsets.only(
                  bottom: hideBottomBar.value
                      ? Sizes.crossLength * 0.020
                      : Sizes.crossLength * 0.120),
              controller: controller.vistScrollController,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.only(top: getDynamicHeight(size: 0.015)),
                  child: Container(
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: ConstColor.whiteColor,
                      border:
                          Border.all(width: 0.5, color: ConstColor.buttonColor),
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                            left: Sizes.crossLength * 0.020,
                            right: Sizes.crossLength * 0.020,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: Sizes.crossLength * 0.010,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: AppText(
                                      text: controller.doctorsListData[index]
                                              .serviceName ??
                                          '',
                                      fontSize: Sizes.px14,
                                      letterSpacing: 0.3,
                                      fontColor: ConstColor.buttonColor,
                                      fontWeight: FontWeight.w600,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  SizedBox(
                                    height: getDynamicHeight(size: 0.005),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: Sizes.crossLength * 0.007,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  AppText(
                                    text: 'Economy AC',
                                    fontSize: Sizes.px12,
                                    letterSpacing: 0.3,
                                    fontColor: ConstColor.blackA5A5A5,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  AppText(
                                    text:
                                        '₹ ${controller.doctorsListData[index].eAC}',
                                    fontSize: Sizes.px14,
                                    letterSpacing: 0.3,
                                    fontColor: ConstColor.black4B4D4F,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: Sizes.crossLength * 0.005,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  AppText(
                                    text: 'Premium AC',
                                    fontSize: Sizes.px12,
                                    letterSpacing: 0.3,
                                    fontColor: ConstColor.blackA5A5A5,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  AppText(
                                    text:
                                        '₹ ${controller.doctorsListData[index].preMEAC}',
                                    fontSize: Sizes.px14,
                                    letterSpacing: 0.3,
                                    fontColor: ConstColor.black4B4D4F,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: Sizes.crossLength * 0.005,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  AppText(
                                    text: 'Semi Special',
                                    fontSize: Sizes.px12,
                                    letterSpacing: 0.3,
                                    fontColor: ConstColor.blackA5A5A5,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  AppText(
                                    text:
                                        '₹ ${controller.doctorsListData[index].semispl}',
                                    fontSize: Sizes.px14,
                                    letterSpacing: 0.3,
                                    fontColor: ConstColor.black4B4D4F,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: Sizes.crossLength * 0.005,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  AppText(
                                    text: 'Special',
                                    fontSize: Sizes.px12,
                                    letterSpacing: 0.3,
                                    fontColor: ConstColor.blackA5A5A5,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  AppText(
                                    text:
                                        '₹ ${controller.doctorsListData[index].spl}',
                                    fontSize: Sizes.px14,
                                    letterSpacing: 0.3,
                                    fontColor: ConstColor.black4B4D4F,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: Sizes.crossLength * 0.005,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  AppText(
                                    text: 'Deluxe',
                                    fontSize: Sizes.px12,
                                    letterSpacing: 0.3,
                                    fontColor: ConstColor.blackA5A5A5,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  AppText(
                                    text:
                                        '₹ ${controller.doctorsListData[index].deluxe}',
                                    fontSize: Sizes.px14,
                                    letterSpacing: 0.3,
                                    fontColor: ConstColor.black4B4D4F,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: Sizes.crossLength * 0.005,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  AppText(
                                    text: 'Suite',
                                    fontSize: Sizes.px12,
                                    letterSpacing: 0.3,
                                    fontColor: ConstColor.blackA5A5A5,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  AppText(
                                    text:
                                        '₹ ${controller.doctorsListData[index].suite}',
                                    fontSize: Sizes.px14,
                                    letterSpacing: 0.3,
                                    fontColor: ConstColor.black4B4D4F,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: Sizes.crossLength * 0.010,
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            );
    });
  }
}
