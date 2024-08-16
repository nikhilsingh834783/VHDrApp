import 'package:flutter/material.dart';
import 'package:venus/app/modules/patientlist/controllers/patientlist_controller.dart';

import '../../../../app_common_widgets/common_import.dart';

organizationCheckBoxes({required PatientlistController controller}) {
  return GridView.builder(
      itemCount: controller.orgsList.length,
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
                  if (controller.selectedOrganizationList
                      .contains(controller.orgsList[i].organization)) {
                    controller.selectedOrganizationList
                        .remove(controller.orgsList[i].organization);
                  } else {
                    controller.selectedOrganizationList
                        .add(controller.orgsList[i].organization!);
                  }
                  controller.update();
                },
                child: Row(
                  children: [
                    controller.selectedOrganizationList
                            .contains(controller.orgsList[i].organization)
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
                      text: controller.orgsList[i].organization ?? '',
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
  //               if (controller.selectedOrganizationList.contains('All')) {
  //                 controller.selectedOrganizationList.remove('All');
  //               } else {
  //                 controller.selectedOrganizationList.add('All');
  //               }
  //               controller.update();
  //             },
  //             child: Row(
  //               children: [
  //                 controller.selectedOrganizationList.contains('All')
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
  //               if (controller.selectedOrganizationList.contains('Cash')) {
  //                 controller.selectedOrganizationList.remove('Cash');
  //               } else {
  //                 controller.selectedOrganizationList.add('Cash');
  //               }
  //               controller.update();
  //             },
  //             child: Row(
  //               children: [
  //                 controller.selectedOrganizationList.contains('Cash')
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
  //                   text: 'Cash',
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
  //               if (controller.selectedOrganizationList.contains('Cashless')) {
  //                 controller.selectedOrganizationList.remove('Cashless');
  //               } else {
  //                 controller.selectedOrganizationList.add('Cashless');
  //               }
  //               controller.update();
  //             },
  //             child: Row(
  //               children: [
  //                 controller.selectedOrganizationList.contains('Cashless')
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
  //                   text: 'Cashless',
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
  //               if (controller.selectedOrganizationList.contains('PMJAY')) {
  //                 controller.selectedOrganizationList.remove('PMJAY');
  //               } else {
  //                 controller.selectedOrganizationList.add('PMJAY');
  //               }
  //               controller.update();
  //             },
  //             child: Row(
  //               children: [
  //                 controller.selectedOrganizationList.contains('PMJAY')
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
  //                   text: 'PMJAY',
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
  //               if (controller.selectedOrganizationList.contains('Corporate')) {
  //                 controller.selectedOrganizationList.remove('Corporate');
  //               } else {
  //                 controller.selectedOrganizationList.add('Corporate');
  //               }
  //               controller.update();
  //             },
  //             child: Row(
  //               children: [
  //                 controller.selectedOrganizationList.contains('Corporate')
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
  //                   text: 'Corporate',
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
