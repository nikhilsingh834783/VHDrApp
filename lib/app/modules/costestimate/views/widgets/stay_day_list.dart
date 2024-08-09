import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:venus/app/app_common_widgets/common_import.dart';

import '../../controllers/costestimate_controller.dart';

class StayDayList extends StatelessWidget {
  const StayDayList({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CostestimateController>(builder: (controller) {
      return Container(
        decoration: BoxDecoration(
            color: ConstColor.whiteColor,
            borderRadius: BorderRadius.circular(10)),
        height: getDynamicHeight(size: 0.245),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: getDynamicHeight(size: 0.015),
          ),
          child: ListView.builder(
            padding: EdgeInsets.zero,
            itemCount: controller.stayDayList.length,
            shrinkWrap: true,
            itemBuilder: (context, item) {
              return GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  controller.stayDayController.text =
                      controller.stayDayList[item];
                  controller.update();
                  // controller.stayDayPopupMenuController.hideMenu();
                  Navigator.pop(context);
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText(
                      text: controller.stayDayList[item],
                      fontSize: Sizes.px14,
                      fontWeight: FontWeight.w500,
                    ),
                    SizedBox(
                      height: getDynamicHeight(size: 0.010),
                    ),
                    item == controller.stayDayList.length - 1
                        ? const SizedBox()
                        : const Divider(
                            thickness: 1,
                          ),
                  ],
                ),
              );
            },
          ),
        ),
      );
    });
  }
}
