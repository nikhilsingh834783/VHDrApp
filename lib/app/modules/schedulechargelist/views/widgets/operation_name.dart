import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../app_common_widgets/common_import.dart';
import '../../controllers/schedulechargelist_controller.dart';

class OperationNameListView extends StatelessWidget {
  const OperationNameListView({super.key});

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
                itemCount: controller.operationNameListData.length,
                itemBuilder: (item, index) {
                  return GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () {
                      // controller.procedureController.text = controller
                      //         .operationNameListData[index].operationName ??
                      //     '';
                      // controller.selectedOperation =
                      //     controller.operationNameListData[index].id.toString();
                      // controller.procedurePopMenuController.hideMenu();
                      if (controller.selectedOperationId.contains(
                          controller.operationNameListData[index].id)) {
                        controller.selectedOperationId
                            .remove(controller.operationNameListData[index].id);
                        controller.selectedOperationList
                            .remove(controller.operationNameListData[index]);
                      } else {
                        controller.selectedOperationId
                            .add(controller.operationNameListData[index].id!);
                        controller.selectedOperationList
                            .add(controller.operationNameListData[index]);
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
                                  text: controller.operationNameListData[index]
                                          .operationName ??
                                      ''),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            controller.selectedOperationId.contains(
                                    controller.operationNameListData[index].id)
                                ? GestureDetector(
                                    onTap: () {
                                      FocusScope.of(context).unfocus();
                                      controller.selectedOperationId.remove(
                                          controller
                                              .operationNameListData[index].id);
                                      controller.selectedOperationList.remove(
                                          controller
                                              .operationNameListData[index]);
                                      controller.update();
                                    },
                                    child: const Icon(
                                      Icons.cancel_outlined,
                                      color: ConstColor.buttonColor,
                                    ))
                                : const SizedBox()
                          ],
                        ),
                        index == controller.operationNameListData.length - 1
                            ? const SizedBox()
                            : const SizedBox(
                                height: 15,
                              ),
                        index == controller.operationNameListData.length - 1
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
