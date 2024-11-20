import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../app_common_widgets/common_import.dart';
import '../../controllers/costestimate_controller.dart';

class ProcedureListViewOperation extends StatelessWidget {
  const ProcedureListViewOperation({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CostestimateController>(builder: (controller) {
      return Container(
        decoration: BoxDecoration(
            color: ConstColor.whiteColor,
            borderRadius: BorderRadius.circular(10)),
        height: getDynamicHeight(size: 0.395),
        child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: getDynamicHeight(size: 0.015),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AppText(
                      text: 'Select Surgery',
                      fontSize: Sizes.px16,
                      fontWeight: FontWeight.w600,
                      fontColor: ConstColor.black4B4D4F,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                AppTextField(
                  hintText: 'Enter surgery name',
                  onTapOutside: (event) {
                    FocusScope.of(context).unfocus();
                  },
                  onChanged: (text) {
                    controller.searchOpearationName(text.trim());
                  },
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                ),
                const SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: controller.searchOperationNameListData != null
                      ? controller.searchOperationNameListData!.isEmpty
                          ? Center(
                              child: AppText(
                                text: "No data found",
                                fontSize: Sizes.px16,
                                fontWeight: FontWeight.w600,
                              ),
                            )
                          : ListView.builder(
                              padding: EdgeInsets.only(
                                  bottom: Sizes.crossLength * 0.020),
                              itemCount: controller
                                  .searchOperationNameListData!.length,
                              itemBuilder: (item, index) {
                                return GestureDetector(
                                  behavior: HitTestBehavior.opaque,
                                  onTap: () {
                                    if (controller.selectedOperationId.contains(
                                        controller
                                            .searchOperationNameListData![index]
                                            .id)) {
                                      controller.selectedOperationId.remove(
                                          controller
                                              .searchOperationNameListData![
                                                  index]
                                              .id);
                                      controller.selectedOperationList.remove(
                                          controller
                                                  .searchOperationNameListData![
                                              index]);
                                    } else {
                                      controller.selectedOperationId.add(
                                          controller
                                              .searchOperationNameListData![
                                                  index]
                                              .id!);
                                      controller.selectedOperationList.add(
                                          controller
                                                  .searchOperationNameListData![
                                              index]);
                                    }
                                    controller.update();
                                  },
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: AppText(
                                                text: controller
                                                        .searchOperationNameListData![
                                                            index]
                                                        .operationName ??
                                                    ''),
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          controller.selectedOperationId
                                                  .contains(controller
                                                      .searchOperationNameListData![
                                                          index]
                                                      .id)
                                              ? GestureDetector(
                                                  onTap: () {
                                                    FocusScope.of(context)
                                                        .unfocus();
                                                    controller
                                                        .selectedOperationId
                                                        .remove(controller
                                                            .searchOperationNameListData![
                                                                index]
                                                            .id);
                                                    controller
                                                        .selectedOperationList
                                                        .remove(controller
                                                                .searchOperationNameListData![
                                                            index]);
                                                    controller.update();
                                                  },
                                                  child: const Icon(
                                                    Icons.cancel_outlined,
                                                    color:
                                                        ConstColor.buttonColor,
                                                  ))
                                              : const SizedBox()
                                        ],
                                      ),
                                      index ==
                                              controller
                                                      .searchOperationNameListData!
                                                      .length -
                                                  1
                                          ? const SizedBox()
                                          : const SizedBox(
                                              height: 15,
                                            ),
                                      index ==
                                              controller
                                                      .searchOperationNameListData!
                                                      .length -
                                                  1
                                          ? const SizedBox()
                                          : const Divider(
                                              thickness: 1,
                                              height: 1,
                                              color: ConstColor.greyACACAC,
                                            )
                                    ],
                                  ),
                                );
                              })
                      : controller.operationNameListData.isEmpty
                          ? Center(
                              child: AppText(
                                text: "No data found for selected surgeon",
                                fontSize: Sizes.px16,
                                fontWeight: FontWeight.w600,
                              ),
                            )
                          : ListView.builder(
                              padding: EdgeInsets.only(
                                  bottom: Sizes.crossLength * 0.020),
                              itemCount:
                                  controller.operationNameListData.length,
                              itemBuilder: (item, index) {
                                return GestureDetector(
                                  behavior: HitTestBehavior.opaque,
                                  onTap: () {
                                    if (controller.selectedOperationId.contains(
                                        controller
                                            .operationNameListData[index].id)) {
                                      controller.selectedOperationId.remove(
                                          controller
                                              .operationNameListData[index].id);
                                      controller.selectedOperationList.remove(
                                          controller
                                              .operationNameListData[index]);
                                    } else {
                                      controller.selectedOperationId.add(
                                          controller
                                              .operationNameListData[index]
                                              .id!);
                                      controller.selectedOperationList.add(
                                          controller
                                              .operationNameListData[index]);
                                    }
                                    controller.update();
                                  },
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: AppText(
                                                text: controller
                                                        .operationNameListData[
                                                            index]
                                                        .operationName ??
                                                    ''),
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          controller.selectedOperationId
                                                  .contains(controller
                                                      .operationNameListData[
                                                          index]
                                                      .id)
                                              ? GestureDetector(
                                                  onTap: () {
                                                    FocusScope.of(context)
                                                        .unfocus();
                                                    controller
                                                        .selectedOperationId
                                                        .remove(controller
                                                            .operationNameListData[
                                                                index]
                                                            .id);
                                                    controller
                                                        .selectedOperationList
                                                        .remove(controller
                                                                .operationNameListData[
                                                            index]);
                                                    controller.update();
                                                  },
                                                  child: const Icon(
                                                    Icons.cancel_outlined,
                                                    color:
                                                        ConstColor.buttonColor,
                                                  ))
                                              : const SizedBox()
                                        ],
                                      ),
                                      index ==
                                              controller.operationNameListData
                                                      .length -
                                                  1
                                          ? const SizedBox()
                                          : const SizedBox(
                                              height: 15,
                                            ),
                                      index ==
                                              controller.operationNameListData
                                                      .length -
                                                  1
                                          ? const SizedBox()
                                          : const Divider(
                                              thickness: 1,
                                              height: 1,
                                              color: ConstColor.greyACACAC,
                                            )
                                    ],
                                  ),
                                );
                              }),
                ),
              ],
            )),
      );
    });
  }
}
