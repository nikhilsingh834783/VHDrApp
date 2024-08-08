import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../app_common_widgets/common_import.dart';
import '../../controllers/otscheduler_controller.dart';

class OrganizationList extends StatelessWidget {
  const OrganizationList({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OtschedulerController>(builder: (controller) {
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
            child: Column(
              children: [
                Center(
                  child: AppText(
                    text: 'Select Organization',
                    fontSize: Sizes.px16,
                    fontWeight: FontWeight.w600,
                    fontColor: ConstColor.black4B4D4F,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                AppTextField(
                  hintText: 'Enter organization name',
                  onTapOutside: (event) {
                    FocusScope.of(context).unfocus();
                  },
                  onChanged: (text) {
                    controller.searchOrganization(text.trim());
                  },
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                ),
                const SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: controller.searchOrganizationListData != null
                      ? controller.searchOrganizationListData!.isEmpty
                          ? Center(
                              child: AppText(
                                text: 'No data found',
                                fontSize: Sizes.px15,
                                fontWeight: FontWeight.w600,
                              ),
                            )
                          : ListView.builder(
                              padding: EdgeInsets.zero,
                              itemCount:
                                  controller.searchOrganizationListData!.length,
                              itemBuilder: (item, index) {
                                return GestureDetector(
                                  behavior: HitTestBehavior.opaque,
                                  onTap: () {
                                    controller
                                        .organizationContoller.text = controller
                                            .searchOrganizationListData![index]
                                            .organization ??
                                        '';
                                    controller.selectedOrganization = controller
                                        .searchOrganizationListData![index]
                                        .orgId
                                        .toString();
                                    // controller.organizationNameController
                                    //     .hideMenu();
                                    controller.searchOrganizationListData =
                                        null;
                                    Navigator.pop(context);
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
                                                        .searchOrganizationListData![
                                                            index]
                                                        .organization ??
                                                    ''),
                                          ),
                                        ],
                                      ),
                                      index ==
                                              controller
                                                      .searchOrganizationListData!
                                                      .length -
                                                  1
                                          ? const SizedBox()
                                          : const SizedBox(
                                              height: 15,
                                            ),
                                      index ==
                                              controller
                                                      .searchOrganizationListData!
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
                      : ListView.builder(
                          padding: EdgeInsets.zero,
                          itemCount: controller.organizationListData.length,
                          itemBuilder: (item, index) {
                            return GestureDetector(
                              behavior: HitTestBehavior.opaque,
                              onTap: () {
                                controller.organizationContoller.text =
                                    controller.organizationListData[index]
                                            .organization ??
                                        '';
                                controller.selectedOrganization = controller
                                    .organizationListData[index].orgId
                                    .toString();
                                // controller.organizationNameController
                                //     .hideMenu();
                                Navigator.pop(context);
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
                                            text: controller
                                                    .organizationListData[index]
                                                    .organization ??
                                                ''),
                                      ),
                                    ],
                                  ),
                                  index ==
                                          controller
                                                  .organizationListData.length -
                                              1
                                      ? const SizedBox()
                                      : const SizedBox(
                                          height: 15,
                                        ),
                                  index ==
                                          controller
                                                  .organizationListData.length -
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
