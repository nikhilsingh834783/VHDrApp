import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:venus/app/modules/schedulechargelist/controllers/schedulechargelist_controller.dart';

import '../../../../../main.dart';
import '../../../../app_common_widgets/common_import.dart';

class RoomListView extends StatelessWidget {
  const RoomListView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SchedulechargelistController>(builder: (controller) {
      return controller.roomsData.isEmpty
          ? Center(
              child: AppText(
                text: 'No data found',
                fontSize: Sizes.px15,
                fontWeight: FontWeight.w600,
              ),
            )
          : ListView.builder(
              itemCount: controller.roomsData.length,
              physics: controller.roomsData.length < 3
                  ? const NeverScrollableScrollPhysics()
                  : const BouncingScrollPhysics(),
              controller: controller.roomScrollController,
              padding: EdgeInsets.only(
                  bottom: hideBottomBar.value
                      ? Sizes.crossLength * 0.020
                      : Sizes.crossLength * 0.120),
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
                                height: Sizes.crossLength * 0.015,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: AppText(
                                      text: controller
                                              .roomsData[index].serviceName ??
                                          '',
                                      fontSize: Sizes.px14,
                                      letterSpacing: 0.3,
                                      fontColor: ConstColor.buttonColor,
                                      fontWeight: FontWeight.w600,
                                      maxLine: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  SizedBox(
                                    width: Sizes.crossLength * 0.015,
                                  ),
                                  AppText(
                                    text:
                                        '₹ ${controller.roomsData[index].rate}',
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
