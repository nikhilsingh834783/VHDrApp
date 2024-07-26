import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:venus/app/app_common_widgets/common_import.dart';

import '../../controllers/costestimate_controller.dart';

class HighRiskView extends StatelessWidget {
  const HighRiskView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CostestimateController>(builder: (controller) {
      return Container(
        decoration: BoxDecoration(
            color: ConstColor.whiteColor,
            borderRadius: BorderRadius.circular(10)),
        height: getDynamicHeight(size: 0.125),
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: getDynamicHeight(size: 0.015),
              vertical: getDynamicHeight(size: 0.020)),
          child: ListView.builder(
            padding: EdgeInsets.zero,
            itemCount: controller.highRiskList.length,
            shrinkWrap: true,
            itemBuilder: (context, item) {
              return GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  controller.highRiskController.text =
                      controller.highRiskList[item];
                  controller.highRiskPopController.hideMenu();
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: getDynamicHeight(size: 0.005),
                    ),
                    AppText(
                      text: controller.highRiskList[item],
                      fontSize: Sizes.px14,
                      fontWeight: FontWeight.w500,
                    ),
                    SizedBox(
                      height: getDynamicHeight(size: 0.005),
                    ),
                    item == controller.highRiskList.length - 1
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
