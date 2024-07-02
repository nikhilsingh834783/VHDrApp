import 'package:flutter/material.dart';
import 'package:venus/app/app_common_widgets/common_text.dart';
import 'package:venus/app/app_common_widgets/sizer_constant.dart';
import 'package:venus/app/core/them/const_color.dart';
import 'package:venus/app/modules/patientlist/controllers/patientlist_controller.dart';

floorCheckBoxes({required PatientlistController controller}) {
  return GridView.builder(
      itemCount: controller.floorsList.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, childAspectRatio: 4),
      itemBuilder: (context, i) {
        return Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () {
                  if (controller.selectedFloorList
                      .contains(controller.floorsList[i].floorName)) {
                    controller.selectedFloorList
                        .remove(controller.floorsList[i].floorName);
                  } else {
                    controller.selectedFloorList
                        .add(controller.floorsList[i].floorName!);
                  }
                  controller.update();
                },
                child: Row(
                  children: [
                    controller.selectedFloorList
                            .contains(controller.floorsList[i].floorName)
                        ? Container(
                            height: getDynamicHeight(size: 0.020),
                            width: getDynamicHeight(size: 0.020),
                            decoration: BoxDecoration(
                                color: ConstColor.grey858585,
                                border: Border.all(
                                    width: 1, color: ConstColor.grey858585),
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(3))),
                            child: Center(
                              child: Icon(Icons.check,
                                  color: ConstColor.whiteColor,
                                  size: getDynamicHeight(size: 0.016)),
                            ),
                          )
                        : Container(
                            height: getDynamicHeight(size: 0.020),
                            width: getDynamicHeight(size: 0.020),
                            decoration: BoxDecoration(
                                border: Border.all(
                                    width: 1, color: ConstColor.greyACACAC),
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(3))),
                          ),
                    SizedBox(
                      width: Sizes.crossLength * 0.010,
                    ),
                    AppText(
                      text: controller.floorsList[i].floorName ?? '',
                      fontSize: Sizes.px14,
                      fontColor: ConstColor.blackTextColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      });

  // Column(
  //   children: [
  //     Row(
  //       children: [
  //         Expanded(
  //           child: GestureDetector(
  //             onTap: () {
  //               if (controller.selectedFloorList.contains('All')) {
  //                 controller.selectedFloorList.remove('All');
  //               } else {
  //                 controller.selectedFloorList.add('All');
  //               }
  //               controller.update();
  //             },
  //             child: Row(
  //               children: [
  //                 controller.selectedFloorList.contains('All')
  //                     ? Container(
  //                         height: getDynamicHeight(size: 0.020),
  //                         width: getDynamicHeight(size: 0.020),
  //                         decoration: BoxDecoration(
  //                             color: ConstColor.grey858585,
  //                             border: Border.all(
  //                                 width: 1, color: ConstColor.grey858585),
  //                             borderRadius:
  //                                 const BorderRadius.all(Radius.circular(3))),
  //                         child: Center(
  //                           child: Icon(Icons.check,
  //                               color: ConstColor.whiteColor,
  //                               size: getDynamicHeight(size: 0.016)),
  //                         ),
  //                       )
  //                     : Container(
  //                         height: getDynamicHeight(size: 0.020),
  //                         width: getDynamicHeight(size: 0.020),
  //                         decoration: BoxDecoration(
  //                             border: Border.all(
  //                                 width: 1, color: ConstColor.greyACACAC),
  //                             borderRadius:
  //                                 const BorderRadius.all(Radius.circular(3))),
  //                       ),
  //                 SizedBox(
  //                   width: Sizes.crossLength * 0.010,
  //                 ),
  //                 AppText(
  //                   text: 'All',
  //                   fontSize: Sizes.px14,
  //                   fontColor: ConstColor.blackTextColor,
  //                   fontWeight: FontWeight.w600,
  //                 ),
  //               ],
  //             ),
  //           ),
  //         ),
  //         Expanded(
  //           child: GestureDetector(
  //             onTap: () {
  //               if (controller.selectedFloorList.contains('Ground')) {
  //                 controller.selectedFloorList.remove('Ground');
  //               } else {
  //                 controller.selectedFloorList.add('Ground');
  //               }
  //               controller.update();
  //             },
  //             child: Row(
  //               children: [
  //                 controller.selectedFloorList.contains('Ground')
  //                     ? Container(
  //                         height: getDynamicHeight(size: 0.020),
  //                         width: getDynamicHeight(size: 0.020),
  //                         decoration: BoxDecoration(
  //                             color: ConstColor.grey858585,
  //                             border: Border.all(
  //                                 width: 1, color: ConstColor.grey858585),
  //                             borderRadius:
  //                                 const BorderRadius.all(Radius.circular(3))),
  //                         child: Center(
  //                           child: Icon(Icons.check,
  //                               color: ConstColor.whiteColor,
  //                               size: getDynamicHeight(size: 0.016)),
  //                         ),
  //                       )
  //                     : Container(
  //                         height: getDynamicHeight(size: 0.020),
  //                         width: getDynamicHeight(size: 0.020),
  //                         decoration: BoxDecoration(
  //                             border: Border.all(
  //                                 width: 1, color: ConstColor.greyACACAC),
  //                             borderRadius:
  //                                 const BorderRadius.all(Radius.circular(3))),
  //                       ),
  //                 SizedBox(
  //                   width: Sizes.crossLength * 0.010,
  //                 ),
  //                 AppText(
  //                   text: 'Ground',
  //                   fontSize: Sizes.px14,
  //                   fontColor: ConstColor.blackTextColor,
  //                   fontWeight: FontWeight.w600,
  //                 ),
  //               ],
  //             ),
  //           ),
  //         )
  //       ],
  //     ),
  //     SizedBox(
  //       height: Sizes.crossLength * 0.015,
  //     ),
  //     Row(
  //       children: [
  //         Expanded(
  //           child: GestureDetector(
  //             onTap: () {
  //               if (controller.selectedFloorList.contains('First')) {
  //                 controller.selectedFloorList.remove('First');
  //               } else {
  //                 controller.selectedFloorList.add('First');
  //               }
  //               controller.update();
  //             },
  //             child: Row(
  //               children: [
  //                 controller.selectedFloorList.contains('First')
  //                     ? Container(
  //                         height: getDynamicHeight(size: 0.020),
  //                         width: getDynamicHeight(size: 0.020),
  //                         decoration: BoxDecoration(
  //                             color: ConstColor.grey858585,
  //                             border: Border.all(
  //                                 width: 1, color: ConstColor.grey858585),
  //                             borderRadius:
  //                                 const BorderRadius.all(Radius.circular(3))),
  //                         child: Center(
  //                           child: Icon(Icons.check,
  //                               color: ConstColor.whiteColor,
  //                               size: getDynamicHeight(size: 0.016)),
  //                         ),
  //                       )
  //                     : Container(
  //                         height: getDynamicHeight(size: 0.020),
  //                         width: getDynamicHeight(size: 0.020),
  //                         decoration: BoxDecoration(
  //                             border: Border.all(
  //                                 width: 1, color: ConstColor.greyACACAC),
  //                             borderRadius:
  //                                 const BorderRadius.all(Radius.circular(3))),
  //                       ),
  //                 SizedBox(
  //                   width: Sizes.crossLength * 0.010,
  //                 ),
  //                 AppText(
  //                   text: 'First',
  //                   fontSize: Sizes.px14,
  //                   fontColor: ConstColor.blackTextColor,
  //                   fontWeight: FontWeight.w600,
  //                 ),
  //               ],
  //             ),
  //           ),
  //         ),
  //         Expanded(
  //           child: GestureDetector(
  //             onTap: () {
  //               if (controller.selectedFloorList.contains('Second')) {
  //                 controller.selectedFloorList.remove('Second');
  //               } else {
  //                 controller.selectedFloorList.add('Second');
  //               }
  //               controller.update();
  //             },
  //             child: Row(
  //               children: [
  //                 controller.selectedFloorList.contains('Second')
  //                     ? Container(
  //                         height: getDynamicHeight(size: 0.020),
  //                         width: getDynamicHeight(size: 0.020),
  //                         decoration: BoxDecoration(
  //                             color: ConstColor.grey858585,
  //                             border: Border.all(
  //                                 width: 1, color: ConstColor.grey858585),
  //                             borderRadius:
  //                                 const BorderRadius.all(Radius.circular(3))),
  //                         child: Center(
  //                           child: Icon(Icons.check,
  //                               color: ConstColor.whiteColor,
  //                               size: getDynamicHeight(size: 0.016)),
  //                         ),
  //                       )
  //                     : Container(
  //                         height: getDynamicHeight(size: 0.020),
  //                         width: getDynamicHeight(size: 0.020),
  //                         decoration: BoxDecoration(
  //                             border: Border.all(
  //                                 width: 1, color: ConstColor.greyACACAC),
  //                             borderRadius:
  //                                 const BorderRadius.all(Radius.circular(3))),
  //                       ),
  //                 SizedBox(
  //                   width: Sizes.crossLength * 0.010,
  //                 ),
  //                 AppText(
  //                   text: 'Second',
  //                   fontSize: Sizes.px14,
  //                   fontColor: ConstColor.blackTextColor,
  //                   fontWeight: FontWeight.w600,
  //                 ),
  //               ],
  //             ),
  //           ),
  //         )
  //       ],
  //     ),
  //     SizedBox(
  //       height: Sizes.crossLength * 0.015,
  //     ),
  //     Row(
  //       children: [
  //         Expanded(
  //           child: GestureDetector(
  //             onTap: () {
  //               if (controller.selectedFloorList.contains('Third')) {
  //                 controller.selectedFloorList.remove('Third');
  //               } else {
  //                 controller.selectedFloorList.add('Third');
  //               }
  //               controller.update();
  //             },
  //             child: Row(
  //               children: [
  //                 controller.selectedFloorList.contains('Third')
  //                     ? Container(
  //                         height: getDynamicHeight(size: 0.020),
  //                         width: getDynamicHeight(size: 0.020),
  //                         decoration: BoxDecoration(
  //                             color: ConstColor.grey858585,
  //                             border: Border.all(
  //                                 width: 1, color: ConstColor.grey858585),
  //                             borderRadius:
  //                                 const BorderRadius.all(Radius.circular(3))),
  //                         child: Center(
  //                           child: Icon(Icons.check,
  //                               color: ConstColor.whiteColor,
  //                               size: getDynamicHeight(size: 0.016)),
  //                         ),
  //                       )
  //                     : Container(
  //                         height: getDynamicHeight(size: 0.020),
  //                         width: getDynamicHeight(size: 0.020),
  //                         decoration: BoxDecoration(
  //                             border: Border.all(
  //                                 width: 1, color: ConstColor.greyACACAC),
  //                             borderRadius:
  //                                 const BorderRadius.all(Radius.circular(3))),
  //                       ),
  //                 SizedBox(
  //                   width: Sizes.crossLength * 0.010,
  //                 ),
  //                 AppText(
  //                   text: 'Third',
  //                   fontSize: Sizes.px14,
  //                   fontColor: ConstColor.blackTextColor,
  //                   fontWeight: FontWeight.w600,
  //                 ),
  //               ],
  //             ),
  //           ),
  //         ),
  //         Expanded(
  //           child: GestureDetector(
  //             onTap: () {
  //               if (controller.selectedFloorList.contains('Fourth')) {
  //                 controller.selectedFloorList.remove('Fourth');
  //               } else {
  //                 controller.selectedFloorList.add('Fourth');
  //               }
  //               controller.update();
  //             },
  //             child: Row(
  //               children: [
  //                 controller.selectedFloorList.contains('Fourth')
  //                     ? Container(
  //                         height: getDynamicHeight(size: 0.020),
  //                         width: getDynamicHeight(size: 0.020),
  //                         decoration: BoxDecoration(
  //                             color: ConstColor.grey858585,
  //                             border: Border.all(
  //                                 width: 1, color: ConstColor.grey858585),
  //                             borderRadius:
  //                                 const BorderRadius.all(Radius.circular(3))),
  //                         child: Center(
  //                           child: Icon(Icons.check,
  //                               color: ConstColor.whiteColor,
  //                               size: getDynamicHeight(size: 0.016)),
  //                         ),
  //                       )
  //                     : Container(
  //                         height: getDynamicHeight(size: 0.020),
  //                         width: getDynamicHeight(size: 0.020),
  //                         decoration: BoxDecoration(
  //                             border: Border.all(
  //                                 width: 1, color: ConstColor.greyACACAC),
  //                             borderRadius:
  //                                 const BorderRadius.all(Radius.circular(3))),
  //                       ),
  //                 SizedBox(
  //                   width: Sizes.crossLength * 0.010,
  //                 ),
  //                 AppText(
  //                   text: 'Fourth',
  //                   fontSize: Sizes.px14,
  //                   fontColor: ConstColor.blackTextColor,
  //                   fontWeight: FontWeight.w600,
  //                 ),
  //               ],
  //             ),
  //           ),
  //         ),
  //       ],
  //     ),
  //     SizedBox(
  //       height: Sizes.crossLength * 0.015,
  //     ),
  //     Row(
  //       children: [
  //         Expanded(
  //           child: GestureDetector(
  //             onTap: () {
  //               if (controller.selectedFloorList.contains('Waiting Area')) {
  //                 controller.selectedFloorList.remove('Waiting Area');
  //               } else {
  //                 controller.selectedFloorList.add('Waiting Area');
  //               }
  //               controller.update();
  //             },
  //             child: Row(
  //               children: [
  //                 controller.selectedFloorList.contains('Waiting Area')
  //                     ? Container(
  //                         height: getDynamicHeight(size: 0.020),
  //                         width: getDynamicHeight(size: 0.020),
  //                         decoration: BoxDecoration(
  //                             color: ConstColor.grey858585,
  //                             border: Border.all(
  //                                 width: 1, color: ConstColor.grey858585),
  //                             borderRadius:
  //                                 const BorderRadius.all(Radius.circular(3))),
  //                         child: Center(
  //                           child: Icon(Icons.check,
  //                               color: ConstColor.whiteColor,
  //                               size: getDynamicHeight(size: 0.016)),
  //                         ),
  //                       )
  //                     : Container(
  //                         height: getDynamicHeight(size: 0.020),
  //                         width: getDynamicHeight(size: 0.020),
  //                         decoration: BoxDecoration(
  //                             border: Border.all(
  //                                 width: 1, color: ConstColor.greyACACAC),
  //                             borderRadius:
  //                                 const BorderRadius.all(Radius.circular(3))),
  //                       ),
  //                 SizedBox(
  //                   width: Sizes.crossLength * 0.010,
  //                 ),
  //                 AppText(
  //                   text: 'Waiting Area',
  //                   fontSize: Sizes.px14,
  //                   fontColor: ConstColor.blackTextColor,
  //                   fontWeight: FontWeight.w600,
  //                 ),
  //               ],
  //             ),
  //           ),
  //         ),
  //       ],
  //     ),
  //   ],
  // );
}
