import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../app_common_widgets/common_import.dart';
import '../../controllers/schedulechargelist_controller.dart';

class OperationClassView extends StatelessWidget {
  const OperationClassView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SchedulechargelistController>(builder: (controller) {
      return Container(
        decoration: BoxDecoration(
            color: ConstColor.whiteColor,
            border: Border.all(width: 0.5, color: ConstColor.boldBlackColor),
            borderRadius: BorderRadius.circular(10)),
        height: getDynamicHeight(size: 0.395),
        child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: getDynamicHeight(size: 0.015),
                vertical: getDynamicHeight(size: 0.020)),
            child: ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: controller.operationClassListData.length,
                itemBuilder: (item, index) {
                  return GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () {
                      controller.operationClassController.text =
                          controller.operationClassListData[index].className ??
                              '';
                      controller.selectedClassId = controller
                          .operationClassListData[index].id
                          .toString();
                      controller.operationClassPopupController.hideMenu();
                      if (controller.selectedOperationId.isNotEmpty &&
                          controller.selectedClassId != null) {
                        controller.getSurgeries(isLoader: true);
                      }

                      controller.update();
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: AppText(
                                  text: controller.operationClassListData[index]
                                          .className ??
                                      ''),
                            ),
                          ],
                        ),
                        index == controller.operationClassListData.length - 1
                            ? const SizedBox()
                            : const SizedBox(
                                height: 15,
                              ),
                        index == controller.operationClassListData.length - 1
                            ? const SizedBox()
                            : const Divider(
                                thickness: 1,
                                height: 1,
                                color: ConstColor.greyACACAC,
                              )
                      ],
                    ),
                  );
                })),
      );
    });
  }
}
