import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../app_common_widgets/common_import.dart';
import '../../controllers/schedulechargelist_controller.dart';

class SurgerListView extends StatelessWidget {
  const SurgerListView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SchedulechargelistController>(builder: (controller) {
      return controller.surgeryListData.isEmpty
          ? Center(
              child: AppText(
                text: 'No data found',
                fontSize: Sizes.px15,
                fontWeight: FontWeight.w600,
              ),
            )
          : ListView.builder(
              itemCount: controller.surgeryListData.length,
              padding: const EdgeInsets.only(bottom: 70),
              controller: controller.surgryScrollController,
              physics: const BouncingScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.only(top: getDynamicHeight(size: 0.015)),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: ConstColor.whiteColor,
                      border:
                          Border.all(width: 0.6, color: ConstColor.buttonColor),
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
                                height: Sizes.crossLength * 0.015,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: AppText(
                                      text: controller.surgeryListData[index]
                                              .operationName ??
                                          '',
                                      fontSize: Sizes.px14,
                                      letterSpacing: 0.3,
                                      fontColor: ConstColor.black4B4D4F,
                                      fontWeight: FontWeight.w600,
                                      maxLine: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 15,
                                  ),
                                  AppText(
                                    text:
                                        '₹ ${controller.surgeryListData[index].testRate ?? ''}',
                                    fontSize: Sizes.px14,
                                    letterSpacing: 0.3,
                                    fontColor: ConstColor.black4B4D4F,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: Sizes.crossLength * 0.015,
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
