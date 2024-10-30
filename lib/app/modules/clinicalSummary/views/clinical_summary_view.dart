import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../../app_common_widgets/common_import.dart';
import '../controllers/clinical_summary_controller.dart';

class ClinicalSummaryView extends GetView<ClinicalSummaryController> {
  const ClinicalSummaryView({super.key});
  @override
  Widget build(BuildContext context) {
    Get.put(ClinicalSummaryController());
    return GetBuilder<ClinicalSummaryController>(
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            title: AppText(
              text: 'Clinical Summary',
              fontSize: Sizes.px22,
              fontColor: ConstColor.headingTexColor,
              fontWeight: FontWeight.w800,
            ),
            centerTitle: true,
            backgroundColor: Colors.white,
            elevation: 2,
            excludeHeaderSemantics: false,
            surfaceTintColor: Colors.white,
            shadowColor: Colors.grey,
            leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => Navigator.pop(context)),
          ),
          backgroundColor: Colors.white,
          // drawer: const MyDrawer(),
          body: Padding(
             padding: EdgeInsets.symmetric(
              horizontal: Sizes.crossLength * 0.020,
            ), 
            // padding: EdgeInsets.only(
            //   left: Sizes.crossLength * 0.020,
            //   right: Sizes.crossLength * 0.020,
            // ),
            child: Column(
              children: [
                SizedBox(
                  height: Sizes.crossLength * 0.025,
                ),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                          width: 1,
                          color: ConstColor.black6B6B6B.withOpacity(0.20))),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: getDynamicHeight(size: 0.012),
                      vertical: getDynamicHeight(size: 0.015),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AppText(
                          text: 'Patient Name',
                          fontSize: Sizes.px14,
                          fontColor: ConstColor.buttonColor,
                          fontWeight: FontWeight.w600,
                        ),
                        AppText(
                          text: 'Bed: 3',
                          fontSize: Sizes.px14,
                          fontColor: ConstColor.black6B6B6B,
                          fontWeight: FontWeight.w500,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: Sizes.crossLength * 0.015,
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: 4,
                    itemBuilder: (context, i) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onTap: () {
                            if (controller.selectedIndex.contains(i)) {
                              controller.selectedIndex.remove(i);
                            } else {
                              controller.selectedIndex = [];
                              controller.selectedIndex.add(i);
                            }
                            controller.update();
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: ConstColor.whiteColor,
                                border: Border.all(
                                    width: 1,
                                    color: controller.selectedIndex.contains(i)
                                        ? ConstColor.buttonColor
                                        : ConstColor.blackColor
                                            .withOpacity(0.2))),
                            child: Column(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                      borderRadius:
                                          controller.selectedIndex.contains(i)
                                              ? const BorderRadius.only(
                                                  topLeft: Radius.circular(10),
                                                  topRight: Radius.circular(10))
                                              : BorderRadius.circular(10),
                                      color:
                                          controller.selectedIndex.contains(i)
                                              ? ConstColor.buttonColor
                                                  .withOpacity(0.20)
                                              : ConstColor.whiteColor),
                                  padding: const EdgeInsets.all(12),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      AppText(
                                        text: i == 0
                                            ? 'Diagnosis'
                                            : i == 1
                                                ? 'Clinical Summary'
                                                : i == 2
                                                    ? 'Medical History'
                                                    : 'Treatment Given',
                                        fontSize: Sizes.px14,
                                        fontWeight: FontWeight.w500,
                                        fontColor: ConstColor.black6B6B6B,
                                      ),
                                      SvgPicture.asset(
                                          controller.selectedIndex.contains(i)
                                              ? ConstAsset.dropUp
                                              : ConstAsset.down)
                                    ],
                                  ),
                                ),
                                controller.selectedIndex.contains(i)
                                    ? Padding(
                                        padding: const EdgeInsets.all(15),
                                        child: AppText(
                                          letterSpacing: 0.3,
                                          text:
                                              "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
                                          fontSize: Sizes.px12,
                                          fontWeight: FontWeight.w400,
                                          fontColor: ConstColor.black6B6B6B,
                                        ),
                                      )
                                    : const SizedBox()
                              ],
                            ),
                          ),
                        ),
                      );

                      //  Padding(
                      //   padding: const EdgeInsets.only(top: 10),
                      //   child: Container(
                      //     decoration: BoxDecoration(
                      //       color: Colors.white,
                      //       borderRadius: BorderRadius.circular(10.0),
                      //       border: controller.selected == i
                      //           ? Border.all(
                      //               width: 1,
                      //               color: ConstColor.buttonColor,
                      //             )
                      //           : Border.all(
                      //               width: 1,
                      //               color:
                      //                   ConstColor.blackColor.withOpacity(0.2),
                      //             ),
                      //     ),
                      //     child: Theme(
                      //       data: Theme.of(context)
                      //           .copyWith(dividerColor: Colors.transparent),
                      //       child: ExpansionTile(
                      //           backgroundColor: Colors.white,
                      //           key: Key(i.toString()), //attention
                      //           title: Text(i.toString()),
                      //           collapsedShape: RoundedRectangleBorder(
                      //               side: BorderSide(
                      //                   color: ConstColor.blackColor
                      //                       .withOpacity(0.2),
                      //                   width: 1.0),
                      //               borderRadius: BorderRadius.circular(10.0)),
                      //           onExpansionChanged: ((newState) {
                      //             if (newState) {
                      //               print("true");
                      //             } else {
                      //               print("false....");
                      //             }
                      //           }),
                      //           children: [
                      //             Container(
                      //               height: 50,
                      //               width: 50,
                      //               color: Colors.red,
                      //             )
                      //           ]),
                      //     ),
                      //   ),
                      // );
                    },
                  ),
                ),
                SizedBox(
                  height: Sizes.crossLength * 0.025,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
