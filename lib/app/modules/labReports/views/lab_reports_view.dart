// // ignore_for_file: must_be_immutable

// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:get/get.dart';
// import 'package:venus/main.dart';

// import '../../../app_common_widgets/common_import.dart';
// import '../controllers/lab_reports_controller.dart';

// class LabReportsView extends GetView<LabReportsController> {
//   String patientName;
//   String bedNumber;
//   LabReportsView(
//       {super.key, required this.patientName, required this.bedNumber});
//   @override
//   Widget build(BuildContext context) {
//     Get.put(LabReportsController());
//     return GetBuilder<LabReportsController>(
//       builder: (controller) {
//         return Scaffold(
//           // appBar: AppBar(
//           //   title: AppText(
//           //     text: 'Lab Reports',
//           //     fontSize: Sizes.px22,
//           //     fontColor: ConstColor.headingTexColor,
//           //     fontWeight: FontWeight.w800,
//           //   ),
//           //   centerTitle: true,
//           //   backgroundColor: Colors.white,
//           //   elevation: 2,
//           //   excludeHeaderSemantics: false,
//           //   surfaceTintColor: Colors.white,
//           //   shadowColor: Colors.grey,
//           //   leading: IconButton(
//           //       icon: const Icon(Icons.arrow_back),
//           //       onPressed: () => Navigator.pop(context)),
//           // ),
//           backgroundColor: Colors.white,
//           // drawer: const MyDrawer(),
//           body: GestureDetector(
//             onPanUpdate: (s) {
//               hideBottomBar.value = false;
//               controller.showSwipe = false;
//               controller.update();
//             },
//             onTap: () {
//               hideBottomBar.value = false;
//               controller.showSwipe = false;
//               controller.update();
//             },
//             child: controller.labReportsList.isEmpty &&
//                     controller.allReportsList.isEmpty &&
//                     controller.allDatesList.isEmpty
//                 ? Column(children: [
//                     AppBar(
//                       title: AppText(
//                         text: 'Lab Reports',
//                         fontSize: Sizes.px22,
//                         fontColor: ConstColor.headingTexColor,
//                         fontWeight: FontWeight.w800,
//                       ),
//                       centerTitle: true,
//                       backgroundColor: Colors.white,
//                       elevation: 2,
//                       excludeHeaderSemantics: false,
//                       surfaceTintColor: Colors.white,
//                       shadowColor: Colors.grey,
//                       leading: IconButton(
//                           icon: const Icon(Icons.arrow_back),
//                           onPressed: () => Navigator.pop(context)),
//                     ),
//                     Expanded(
//                       child: Center(
//                         child: AppText(
//                           text: 'No data found',
//                           fontSize: Sizes.px15,
//                           fontWeight: FontWeight.w600,
//                         ),
//                       ),
//                     )
//                   ])
//                 : Stack(
//                     children: [
//                       Column(
//                         children: [
//                           AppBar(
//                             title: AppText(
//                               text: 'Lab Reports',
//                               fontSize: Sizes.px22,
//                               fontColor: ConstColor.headingTexColor,
//                               fontWeight: FontWeight.w800,
//                             ),
//                             centerTitle: true,
//                             backgroundColor: Colors.white,
//                             elevation: 2,
//                             excludeHeaderSemantics: false,
//                             surfaceTintColor: Colors.white,
//                             shadowColor: Colors.grey,
//                             leading: IconButton(
//                                 icon: const Icon(Icons.arrow_back),
//                                 onPressed: () => Navigator.pop(context)),
//                           ),
//                           Expanded(
//                             child: Padding(
//                               padding: EdgeInsets.only(
//                                 left: Sizes.crossLength * 0.020,
//                                 right: Sizes.crossLength * 0.020,
//                               ),
//                               child: Column(
//                                 children: [
//                                   SizedBox(
//                                     height: Sizes.crossLength * 0.025,
//                                   ),
//                                   Container(
//                                     decoration: BoxDecoration(
//                                         borderRadius: BorderRadius.circular(10),
//                                         border: Border.all(
//                                             width: 1,
//                                             color: ConstColor.black6B6B6B
//                                                 .withOpacity(0.20))),
//                                     child: Padding(
//                                       padding: EdgeInsets.symmetric(
//                                         horizontal:
//                                             getDynamicHeight(size: 0.012),
//                                         vertical: getDynamicHeight(size: 0.015),
//                                       ),
//                                       child: Row(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.spaceBetween,
//                                         children: [
//                                           Expanded(
//                                             child: AppText(
//                                               text: patientName,
//                                               fontSize: Sizes.px14,
//                                               fontColor: ConstColor.buttonColor,
//                                               fontWeight: FontWeight.w600,
//                                               maxLine: 1,
//                                               overflow: TextOverflow.ellipsis,
//                                             ),
//                                           ),
//                                           SizedBox(
//                                             width: Sizes.crossLength * 0.015,
//                                           ),
//                                           bedNumber != ''
//                                               ? AppText(
//                                                   text: 'Bed: $bedNumber',
//                                                   fontSize: Sizes.px14,
//                                                   fontColor:
//                                                       ConstColor.black6B6B6B,
//                                                   fontWeight: FontWeight.w500,
//                                                 )
//                                               : const SizedBox(),
//                                         ],
//                                       ),
//                                     ),
//                                   ),
//                                   SizedBox(
//                                     height: Sizes.crossLength * 0.015,
//                                   ),
//                                   Expanded(
//                                     child: ListView.builder(
//                                       padding: EdgeInsets.zero,
//                                       controller:
//                                           controller.allscrollController,
//                                       itemCount:
//                                           controller.allReportsList.length,
//                                       shrinkWrap: true,
//                                       itemBuilder: (item, index) {
//                                         List dateLists =
//                                             controller.dateWiseReport(controller
//                                                     .allReportsList[index]
//                                                     .data ??
//                                                 []);
//                                         return Column(
//                                           children: [
//                                             const SizedBox(
//                                               height: 10,
//                                             ),
//                                             AppText(
//                                                 text: controller
//                                                         .allReportsList[index]
//                                                         .reportName ??
//                                                     ""),
//                                             const SizedBox(
//                                               height: 15,
//                                             ),
//                                             Container(
//                                               decoration: BoxDecoration(
//                                                 color: ConstColor.whiteColor,
//                                                 borderRadius:
//                                                     BorderRadius.circular(12),
//                                                 border: Border.all(
//                                                   width: 1,
//                                                   color: ConstColor.blackColor
//                                                       .withOpacity(0.3),
//                                                 ),
//                                               ),
//                                               child: IntrinsicHeight(
//                                                 child: Row(
//                                                   crossAxisAlignment:
//                                                       CrossAxisAlignment
//                                                           .stretch,
//                                                   children: [
//                                                     // Expanded(
//                                                     //     flex: 4,
//                                                     //     child: StartingHeading(
//                                                     //       allReportsData: controller
//                                                     //               .allReportsList[
//                                                     //                   index]
//                                                     //               .data ??
//                                                     //           [],
//                                                     //       height: 500,
//                                                     //     )),
//                                                     VerticalDivider(
//                                                       thickness: 1,
//                                                       color: ConstColor
//                                                           .blackColor
//                                                           .withOpacity(0.3),
//                                                       width: 1,
//                                                     ),
//                                                     // SizedBox(
//                                                     //     width: getDynamicHeight(
//                                                     //         size: 0.075),
//                                                     //     child: ReferenceWidget(
//                                                     //       allReportsData: controller
//                                                     //               .allReportsList[
//                                                     //                   index]
//                                                     //               .data ??
//                                                     //           [],
//                                                     //       height: 500,
//                                                     //     )),
//                                                     VerticalDivider(
//                                                       thickness: 1,
//                                                       color: ConstColor
//                                                           .blackColor
//                                                           .withOpacity(0.3),
//                                                       width: 1,
//                                                     ),
//                                                     Expanded(
//                                                       flex: 7,
//                                                       child: SizedBox(
//                                                         width: Get.width,
//                                                         height:
//                                                             Sizes.crossLength *
//                                                                 .540,
//                                                         child: ListView.builder(
//                                                             padding:
//                                                                 EdgeInsets.zero,
//                                                             scrollDirection:
//                                                                 Axis.horizontal,
//                                                             shrinkWrap: true,
//                                                             itemCount: dateLists
//                                                                 .length,
//                                                             itemBuilder:
//                                                                 (context,
//                                                                     index) {
//                                                               return IntrinsicHeight(
//                                                                 child: Row(
//                                                                   mainAxisAlignment:
//                                                                       MainAxisAlignment
//                                                                           .center,
//                                                                   children: [
//                                                                     Column(
//                                                                       children: [
//                                                                         Container(
//                                                                           decoration:
//                                                                               const BoxDecoration(
//                                                                             color:
//                                                                                 ConstColor.buttonColor,
//                                                                           ),
//                                                                           height:
//                                                                               50,
//                                                                           width:
//                                                                               getDynamicHeight(size: 0.070),
//                                                                           child:
//                                                                               Center(
//                                                                             child:
//                                                                                 AppText(
//                                                                               text: "${dateLists[index]}",
//                                                                               fontSize: Sizes.px13,
//                                                                               fontColor: ConstColor.whiteColor,
//                                                                               fontWeight: FontWeight.w700,
//                                                                               textAlign: TextAlign.center,
//                                                                             ),
//                                                                           ),
//                                                                         ),
//                                                                         const SizedBox(
//                                                                           height:
//                                                                               5,
//                                                                         ),
//                                                                         IntrinsicHeight(
//                                                                           child:
//                                                                               SizedBox(
//                                                                             height:
//                                                                                 Sizes.crossLength * .750,
//                                                                             width:
//                                                                                 getDynamicHeight(size: 0.070),
//                                                                             child: ListView.builder(
//                                                                                 padding: EdgeInsets.zero,
//                                                                                 shrinkWrap: true,
//                                                                                 itemCount: controller.allReportsList[index].data!.length,
//                                                                                 physics: const NeverScrollableScrollPhysics(),
//                                                                                 // controller: controller.scrollController3[index],
//                                                                                 itemBuilder: (item, i) {
//                                                                                   return IntrinsicHeight(
//                                                                                     child: Column(
//                                                                                       children: [
//                                                                                         SizedBox(
//                                                                                           height: getDynamicHeight(size: 0.050),
//                                                                                           child: Center(
//                                                                                             child: dateLists[index] == "${controller.allReportsList[index].data![i].date.toString().split('-')[0]}-${controller.allReportsList[index].data![i].date.toString().split('-')[1]}"
//                                                                                                 ? Column(
//                                                                                                     children: [
//                                                                                                       AppText(
//                                                                                                         text: controller.allReportsList[index].data![i].value ?? '-',
//                                                                                                         fontSize: Sizes.px13,
//                                                                                                         fontColor: ConstColor.black6B6B6B,
//                                                                                                         fontWeight: FontWeight.w500,
//                                                                                                         textAlign: TextAlign.center,
//                                                                                                         maxLine: 2,
//                                                                                                         overflow: TextOverflow.ellipsis,
//                                                                                                       ),
//                                                                                                       AppText(
//                                                                                                         text: controller.allReportsList[index].data![i].unit ?? '-',
//                                                                                                         fontSize: Sizes.px9,
//                                                                                                         fontColor: ConstColor.black6B6B6B,
//                                                                                                         fontWeight: FontWeight.w500,
//                                                                                                         textAlign: TextAlign.center,
//                                                                                                       ),
//                                                                                                     ],
//                                                                                                   )
//                                                                                                 : const SizedBox(),
//                                                                                           ),
//                                                                                         ),
//                                                                                         Divider(
//                                                                                           thickness: 1,
//                                                                                           color: ConstColor.blackColor.withOpacity(0.3),
//                                                                                         ),
//                                                                                       ],
//                                                                                     ),
//                                                                                   );
//                                                                                 }),
//                                                                           ),
//                                                                         )
//                                                                       ],
//                                                                     ),
//                                                                     VerticalDivider(
//                                                                       thickness:
//                                                                           1,
//                                                                       color: ConstColor
//                                                                           .blackColor
//                                                                           .withOpacity(
//                                                                               0.3),
//                                                                       width: 1,
//                                                                     ),
//                                                                   ],
//                                                                 ),
//                                                               );
//                                                             }),
//                                                       ),
//                                                     )
//                                                   ],
//                                                 ),
//                                               ),
//                                             )
//                                           ],
//                                         );
//                                       },
//                                     ),
//                                   ),
//                                   // Container(
//                                   //   height: Sizes.crossLength * .600,
//                                   //   clipBehavior: Clip.hardEdge,
//                                   //   decoration: BoxDecoration(
//                                   //     color: ConstColor.whiteColor,
//                                   //     borderRadius:
//                                   //         BorderRadius.circular(12),
//                                   //     border: Border.all(
//                                   //       width: 1,
//                                   //       color: ConstColor.blackColor
//                                   //           .withOpacity(0.3),
//                                   //     ),
//                                   //   ),
//                                   //   child: IntrinsicHeight(
//                                   //     child: Row(
//                                   //       crossAxisAlignment:
//                                   //           CrossAxisAlignment.stretch,
//                                   //       children: [
//                                   //         const Expanded(
//                                   //             flex: 4,
//                                   //             child: StartingHeading()),
//                                   //         VerticalDivider(
//                                   //           thickness: 1,
//                                   //           color: ConstColor.blackColor
//                                   //               .withOpacity(0.3),
//                                   //           width: 1,
//                                   //         ),
//                                   //         SizedBox(
//                                   //             width: getDynamicHeight(
//                                   //                 size: 0.075),
//                                   //             child:
//                                   //                 const ReferenceWidget()),
//                                   //         VerticalDivider(
//                                   //           thickness: 1,
//                                   //           color: ConstColor.blackColor
//                                   //               .withOpacity(0.3),
//                                   //           width: 1,
//                                   //         ),
//                                   //         Expanded(
//                                   //           flex: 7,
//                                   //           child: SizedBox(
//                                   //             width: Get.width,
//                                   //             height:
//                                   //                 Sizes.crossLength * .540,
//                                   //             child: ListView.builder(
//                                   //                 padding: EdgeInsets.zero,
//                                   //                 scrollDirection:
//                                   //                     Axis.horizontal,
//                                   //                 shrinkWrap: true,
//                                   //                 itemCount: controller
//                                   //                     .allDatesList.length,
//                                   //                 itemBuilder:
//                                   //                     (context, index) {
//                                   //                   return IntrinsicHeight(
//                                   //                     child: Row(
//                                   //                       mainAxisAlignment:
//                                   //                           MainAxisAlignment
//                                   //                               .center,
//                                   //                       children: [
//                                   //                         Column(
//                                   //                           children: [
//                                   //                             Container(
//                                   //                               decoration:
//                                   //                                   const BoxDecoration(
//                                   //                                 color: ConstColor
//                                   //                                     .buttonColor,
//                                   //                               ),
//                                   //                               height: 50,
//                                   //                               width: getDynamicHeight(
//                                   //                                   size:
//                                   //                                       0.070),
//                                   //                               child:
//                                   //                                   Center(
//                                   //                                 child:
//                                   //                                     AppText(
//                                   //                                   text:
//                                   //                                       "${controller.allDatesList[index]}",
//                                   //                                   fontSize:
//                                   //                                       Sizes.px13,
//                                   //                                   fontColor:
//                                   //                                       ConstColor.whiteColor,
//                                   //                                   fontWeight:
//                                   //                                       FontWeight.w700,
//                                   //                                   textAlign:
//                                   //                                       TextAlign.center,
//                                   //                                 ),
//                                   //                               ),
//                                   //                             ),
//                                   //                             const SizedBox(
//                                   //                               height: 5,
//                                   //                             ),
//                                   //                             IntrinsicHeight(
//                                   //                               child:
//                                   //                                   SizedBox(
//                                   //                                 height: Sizes
//                                   //                                         .crossLength *
//                                   //                                     .540,
//                                   //                                 width: getDynamicHeight(
//                                   //                                     size:
//                                   //                                         0.070),
//                                   //                                 child: ListView.builder(
//                                   //                                     padding: EdgeInsets.zero,
//                                   //                                     shrinkWrap: true,
//                                   //                                     itemCount: controller.labReportsList.length,
//                                   //                                     controller: controller.scrollController3[index],
//                                   //                                     itemBuilder: (item, i) {
//                                   //                                       return IntrinsicHeight(
//                                   //                                         child: Column(
//                                   //                                           children: [
//                                   //                                             SizedBox(
//                                   //                                               height: getDynamicHeight(size: 0.050),
//                                   //                                               child: Center(
//                                   //                                                 child: controller.allDatesList[index] == "${controller.labReportsList[i].date.toString().split('-')[0]}-${controller.labReportsList[i].date.toString().split('-')[1]}"
//                                   //                                                     ? Column(
//                                   //                                                         children: [
//                                   //                                                           AppText(
//                                   //                                                             text: controller.labReportsList[i].value ?? '-',
//                                   //                                                             fontSize: Sizes.px13,
//                                   //                                                             fontColor: ConstColor.black6B6B6B,
//                                   //                                                             fontWeight: FontWeight.w500,
//                                   //                                                             textAlign: TextAlign.center,
//                                   //                                                             maxLine: 2,
//                                   //                                                             overflow: TextOverflow.ellipsis,
//                                   //                                                           ),
//                                   //                                                           AppText(
//                                   //                                                             text: controller.labReportsList[i].unit ?? '-',
//                                   //                                                             fontSize: Sizes.px9,
//                                   //                                                             fontColor: ConstColor.black6B6B6B,
//                                   //                                                             fontWeight: FontWeight.w500,
//                                   //                                                             textAlign: TextAlign.center,
//                                   //                                                           ),
//                                   //                                                         ],
//                                   //                                                       )
//                                   //                                                     : const SizedBox(),
//                                   //                                               ),
//                                   //                                             ),
//                                   //                                             Divider(
//                                   //                                               thickness: 1,
//                                   //                                               color: ConstColor.blackColor.withOpacity(0.3),
//                                   //                                             ),
//                                   //                                           ],
//                                   //                                         ),
//                                   //                                       );
//                                   //                                     }),
//                                   //                               ),
//                                   //                             )
//                                   //                           ],
//                                   //                         ),
//                                   //                         VerticalDivider(
//                                   //                           thickness: 1,
//                                   //                           color: ConstColor
//                                   //                               .blackColor
//                                   //                               .withOpacity(
//                                   //                                   0.3),
//                                   //                           width: 1,
//                                   //                         ),
//                                   //                       ],
//                                   //                     ),
//                                   //                   );
//                                   //                 }),
//                                   //           ),
//                                   //         )
//                                   //       ],
//                                   //     ),
//                                   //   ),
//                                   // ),

//                                   SizedBox(
//                                     height: Sizes.crossLength * 0.025,
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                       controller.showSwipe
//                           ? Container(
//                               height: Get.height,
//                               width: Get.width,
//                               color: Colors.black.withOpacity(0.5),
//                               child: Column(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 children: [
//                                   SvgPicture.asset(
//                                       'assets/images/svg/swipe.svg'),
//                                   const SizedBox(
//                                     height: 12,
//                                   ),
//                                   Center(
//                                     child: AppText(
//                                       text:
//                                           'Swipe right for more reports (if available)',
//                                       fontSize: Sizes.px15,
//                                       fontColor: Colors.white,
//                                       fontWeight: FontWeight.w600,
//                                       textAlign: TextAlign.center,
//                                     ),
//                                   )
//                                 ],
//                               ),
//                             )
//                           : const SizedBox()
//                     ],
//                   ),
//           ),
//         );
//       },
//     );
//   }
// }
