import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:venus/app/app_common_widgets/common_import.dart';

import '../../controllers/costestimate_controller.dart';

class ConsultantSurgeonListView extends StatelessWidget {
  const ConsultantSurgeonListView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CostestimateController>(builder: (controller) {
      return Container(
        decoration: BoxDecoration(
            color: ConstColor.whiteColor,
            borderRadius: BorderRadius.circular(10)),
        height: getDynamicHeight(size: 0.500),
        child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: getDynamicHeight(size: 0.015),
                vertical: getDynamicHeight(size: 0.0)),
            child: Column(
              children: [
                Center(
                  child: AppText(
                    text: 'Select Surgeon',
                    fontSize: Sizes.px16,
                    fontWeight: FontWeight.w600,
                    fontColor: ConstColor.black4B4D4F,
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                AppTextField(
                  hintText: 'Enter doctor name',
                  onTapOutside: (event) {
                    FocusScope.of(context).unfocus();
                  },
                  onChanged: (text) {
                    controller.searchAdditionalSurgeon(text.trim());
                  },
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                ),
                const SizedBox(
                  height: 15,
                ),
                Expanded(
                  child: controller.searchAdditionalDoctorList != null
                      ? controller.searchAdditionalDoctorList!.isEmpty
                          ? Center(
                              child: AppText(
                                text: "No data found",
                                fontSize: Sizes.px16,
                                fontWeight: FontWeight.w600,
                              ),
                            )
                          : ListView.builder(
                              padding: EdgeInsets.zero,
                              itemCount:
                                  controller.searchAdditionalDoctorList!.length,
                              itemBuilder: (item, index) {
                                return GestureDetector(
                                  behavior: HitTestBehavior.opaque,
                                  onTap: () {
                                    controller
                                        .consultantController.text = controller
                                            .searchAdditionalDoctorList![index]
                                            .docName ??
                                        '';
                                    // controller.selectedOrganization = controller
                                    //     .searchAdditionalDoctorList![index].orgId
                                    //     .toString();
                                    // controller.additionalSurgeonController
                                    //     .hideMenu();
                                    // Get.back();
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
                                                        .searchAdditionalDoctorList![
                                                            index]
                                                        .docName ??
                                                    ''),
                                          ),
                                        ],
                                      ),
                                      index ==
                                              controller
                                                      .searchAdditionalDoctorList!
                                                      .length -
                                                  1
                                          ? const SizedBox()
                                          : const SizedBox(
                                              height: 15,
                                            ),
                                      index ==
                                              controller
                                                      .searchAdditionalDoctorList!
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
                          itemCount: controller.additionalDoctorList.length,
                          itemBuilder: (item, index) {
                            return GestureDetector(
                              behavior: HitTestBehavior.opaque,
                              onTap: () {
                                controller.consultantController.text =
                                    controller.additionalDoctorList[index]
                                            .docName ??
                                        '';
                                // controller.selectedOrganization = controller
                                //     .additionalDoctorList[index].orgId
                                //     .toString();
                                // controller.additionalSurgeonController
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
                                                    .additionalDoctorList[index]
                                                    .docName ??
                                                ''),
                                      ),
                                    ],
                                  ),
                                  index ==
                                          controller
                                                  .additionalDoctorList.length -
                                              1
                                      ? const SizedBox()
                                      : const SizedBox(
                                          height: 15,
                                        ),
                                  index ==
                                          controller
                                                  .additionalDoctorList.length -
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
