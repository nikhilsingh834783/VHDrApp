import 'package:flutter/material.dart';
import 'package:venus/app/app_common_widgets/common_text.dart';
import 'package:venus/app/app_common_widgets/sizer_constant.dart';
import 'package:venus/app/core/them/const_color.dart';
import 'package:venus/app/modules/patientlist/controllers/patientlist_controller.dart';

wardCheckBoxes({required PatientlistController controller}) {
  return GridView.builder(
      padding: EdgeInsets.zero,
      itemCount: controller.wardList.length,
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
                  if (controller.selectedWardList
                      .contains(controller.wardList[i].wardName)) {
                    controller.selectedWardList
                        .remove(controller.wardList[i].wardName);
                  } else {
                    controller.selectedWardList
                        .add(controller.wardList[i].wardName!);
                  }
                  controller.update();
                },
                child: Row(
                  children: [
                    controller.selectedWardList
                            .contains(controller.wardList[i].wardName)
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
                      text: controller.wardList[i].wardName ?? '',
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

  //  Column(
  //   children: [
  //     Row(
  //       children: [
  //         Expanded(
  //           child: GestureDetector(
  //             onTap: () {
  //               if (controller.selectedWardList.contains('All')) {
  //                 controller.selectedWardList.remove('All');
  //               } else {
  //                 controller.selectedWardList.add('All');
  //               }
  //               controller.update();
  //             },
  //             child: Row(
  //               children: [
  //                 controller.selectedWardList.contains('All')
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
  //               if (controller.selectedWardList.contains('ER')) {
  //                 controller.selectedWardList.remove('ER');
  //               } else {
  //                 controller.selectedWardList.add('ER');
  //               }
  //               controller.update();
  //             },
  //             child: Row(
  //               children: [
  //                 controller.selectedWardList.contains('ER')
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
  //                   text: 'ER',
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
  //               if (controller.selectedWardList.contains('Flu/Covid')) {
  //                 controller.selectedWardList.remove('Flu/Covid');
  //               } else {
  //                 controller.selectedWardList.add('Flu/Covid');
  //               }
  //               controller.update();
  //             },
  //             child: Row(
  //               children: [
  //                 controller.selectedWardList.contains('Flu/Covid')
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
  //                   text: 'Flu/Covid',
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
  //               if (controller.selectedWardList.contains('I/ICU')) {
  //                 controller.selectedWardList.remove('I/ICU');
  //               } else {
  //                 controller.selectedWardList.add('I/ICU');
  //               }
  //               controller.update();
  //             },
  //             child: Row(
  //               children: [
  //                 controller.selectedWardList.contains('I/ICU')
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
  //                   text: 'I/ICU',
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
  //               if (controller.selectedWardList.contains('I/Ward')) {
  //                 controller.selectedWardList.remove('I/Ward');
  //               } else {
  //                 controller.selectedWardList.add('I/Ward');
  //               }
  //               controller.update();
  //             },
  //             child: Row(
  //               children: [
  //                 controller.selectedWardList.contains('I/Ward')
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
  //                   text: 'I/Ward',
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
  //               if (controller.selectedWardList.contains('HDU')) {
  //                 controller.selectedWardList.remove('HDU');
  //               } else {
  //                 controller.selectedWardList.add('HDU');
  //               }
  //               controller.update();
  //             },
  //             child: Row(
  //               children: [
  //                 controller.selectedWardList.contains('HDU')
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
  //                   text: 'HDU',
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
  //               if (controller.selectedWardList.contains('SPL')) {
  //                 controller.selectedWardList.remove('SPL');
  //               } else {
  //                 controller.selectedWardList.add('SPL');
  //               }
  //               controller.update();
  //             },
  //             child: Row(
  //               children: [
  //                 controller.selectedWardList.contains('SPL')
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
  //                   text: 'SPL',
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
  //               if (controller.selectedWardList.contains('Pre E/AC')) {
  //                 controller.selectedWardList.remove('Pre E/AC');
  //               } else {
  //                 controller.selectedWardList.add('Pre E/AC');
  //               }
  //               controller.update();
  //             },
  //             child: Row(
  //               children: [
  //                 controller.selectedWardList.contains('Pre E/AC')
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
  //                   text: 'Pre E/AC',
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
  //               if (controller.selectedWardList.contains('NICU')) {
  //                 controller.selectedWardList.remove('NICU');
  //               } else {
  //                 controller.selectedWardList.add('NICU');
  //               }
  //               controller.update();
  //             },
  //             child: Row(
  //               children: [
  //                 controller.selectedWardList.contains('NICU')
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
  //                   text: 'NICU',
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
  //               if (controller.selectedWardList.contains('E/AC')) {
  //                 controller.selectedWardList.remove('E/AC');
  //               } else {
  //                 controller.selectedWardList.add('E/AC');
  //               }
  //               controller.update();
  //             },
  //             child: Row(
  //               children: [
  //                 controller.selectedWardList.contains('E/AC')
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
  //                   text: 'E/AC',
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
  //               if (controller.selectedWardList.contains('Semi SPL')) {
  //                 controller.selectedWardList.remove('Semi SPL');
  //               } else {
  //                 controller.selectedWardList.add('Semi SPL');
  //               }
  //               controller.update();
  //             },
  //             child: Row(
  //               children: [
  //                 controller.selectedWardList.contains('Semi SPL')
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
  //                   text: 'Semi SPL',
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
  //               if (controller.selectedWardList.contains('Deluxe')) {
  //                 controller.selectedWardList.remove('Deluxe');
  //               } else {
  //                 controller.selectedWardList.add('Deluxe');
  //               }
  //               controller.update();
  //             },
  //             child: Row(
  //               children: [
  //                 controller.selectedWardList.contains('Deluxe')
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
  //                   text: 'Deluxe',
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
  //               if (controller.selectedWardList.contains('ICCU')) {
  //                 controller.selectedWardList.remove('ICCU');
  //               } else {
  //                 controller.selectedWardList.add('ICCU');
  //               }
  //               controller.update();
  //             },
  //             child: Row(
  //               children: [
  //                 controller.selectedWardList.contains('ICCU')
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
  //                   text: 'ICCU',
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
  //               if (controller.selectedWardList.contains('CT SICU')) {
  //                 controller.selectedWardList.remove('CT SICU');
  //               } else {
  //                 controller.selectedWardList.add('CT SICU');
  //               }
  //               controller.update();
  //             },
  //             child: Row(
  //               children: [
  //                 controller.selectedWardList.contains('CT SICU')
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
  //                   text: 'CT SICU',
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
  //               if (controller.selectedWardList.contains('PICU')) {
  //                 controller.selectedWardList.remove('PICU');
  //               } else {
  //                 controller.selectedWardList.add('PICU');
  //               }
  //               controller.update();
  //             },
  //             child: Row(
  //               children: [
  //                 controller.selectedWardList.contains('PICU')
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
  //                   text: 'PICU',
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
  //               if (controller.selectedWardList.contains('SUITE')) {
  //                 controller.selectedWardList.remove('SUITE');
  //               } else {
  //                 controller.selectedWardList.add('SUITE');
  //               }
  //               controller.update();
  //             },
  //             child: Row(
  //               children: [
  //                 controller.selectedWardList.contains('SUITE')
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
  //                   text: 'SUITE',
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
