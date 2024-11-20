// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:get/get.dart';
//
// import '../../../../main.dart';
// import '../../../app_common_widgets/common_import.dart';
// import '../controllers/hospital_doctors_controller.dart';
//
// class HospitalDoctorsView extends GetView<HospitalDoctorsController> {
//   const HospitalDoctorsView({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     Get.put(HospitalDoctorsController());
//     return GetBuilder<HospitalDoctorsController>(
//       builder: (controller) {
//         return Scaffold(
//           appBar: AppBar(
//             title: AppText(
//               text: 'Hospital Doctors',
//               fontSize: Sizes.px22,
//               fontColor: ConstColor.headingTexColor,
//               fontWeight: FontWeight.w800,
//             ),
//             centerTitle: true,
//             backgroundColor: Colors.white,
//             elevation: 2,
//             surfaceTintColor: Colors.white,
//             shadowColor: Colors.grey,
//             leading: IconButton(
//               icon: const Icon(Icons.arrow_back),
//               onPressed: () => Navigator.pop(context),
//             ),
//           ),
//           backgroundColor: Colors.white,
//           body: Padding(
//             padding: EdgeInsets.only(
//               left: Sizes.crossLength * 0.020,
//               right: Sizes.crossLength * 0.020,
//             ),
//             child: Column(
//               children: [
//                 SizedBox(
//                   height: Sizes.crossLength * 0.025,
//                 ),
//                 Row(
//                   children: [
//                     Expanded(
//                       flex: 4,
//                       child: AppTextField(
//                         controller: controller.searchController,
//                         onTap: () {
//                           controller.update();
//                         },
//                         onChanged: (text) {
//                           controller.getHospitalDoctors(
//                               searchPrefix: text.trim(), isLoader: false);
//                         },
//                         textInputAction: TextInputAction.done,
//                         contentPadding:
//                             const EdgeInsets.symmetric(horizontal: 30),
//                         onTapOutside: (event) {
//                           FocusScope.of(context).unfocus();
//
//                           controller.update();
//                         },
//                         onFieldSubmitted: (v) {
//                           if (controller.searchController.text
//                               .trim()
//                               .isNotEmpty) {
//                             controller.getHospitalDoctors(
//                                 searchPrefix:
//                                     controller.searchController.text.trim(),
//                                 isLoader: false);
//                           }
//                           Future.delayed(const Duration(milliseconds: 800));
//                           controller.update();
//                         },
//                         suffixIcon:
//                             controller.searchController.text.trim().isNotEmpty
//                                 ? GestureDetector(
//                                     onTap: () {
//                                       FocusScope.of(context).unfocus();
//                                       controller.searchController.clear();
//                                       controller.getHospitalDoctors(
//                                           isLoader: false);
//                                     },
//                                     child: const Icon(Icons.cancel_outlined))
//                                 : const SizedBox(),
//                         prefixIcon: SvgPicture.asset(
//                           ConstAsset.searchSvg,
//                           height: Sizes.crossLength * 0.020,
//                           width: Sizes.crossLength * 0.020,
//                         ),
//                         hintText: 'Search Patient',
//                       ),
//                     ),
//                   ],
//                 ),
//                 SizedBox(
//                   height: getDynamicHeight(size: 0.020),
//                 ),
//                 Expanded(
//                   flex: 4,
//                   child: controller.hospitalListData.isEmpty
//                       ? Center(
//                           child: Padding(
//                             padding: EdgeInsets.only(
//                                 bottom: Sizes.crossLength * 0.050),
//                             child: AppText(
//                               text: 'No data found',
//                               fontSize: Sizes.px15,
//                               fontWeight: FontWeight.w600,
//                             ),
//                           ),
//                         )
//                       : ListView.builder(
//                           itemCount: controller.hospitalListData.length,
//                           controller: controller.doctorsScrollController,
//                           padding: EdgeInsets.only(
//                               bottom: hideBottomBar.value ? 25 : 70),
//                           shrinkWrap: true,
//                           itemBuilder: (context, index) {
//                             return Padding(
//                               padding: EdgeInsets.only(
//                                   top: getDynamicHeight(size: 0.015)),
//                               child: Container(
//                                 height: Sizes.crossLength * 0.080,
//                                 // width: Sizes.crossLength * 0.380,
//                                 decoration: BoxDecoration(
//                                   boxShadow: [
//                                     BoxShadow(
//                                       color: Colors.grey.withOpacity(0.1),
//                                       spreadRadius: 3.0,
//                                     ),
//                                   ],
//                                   borderRadius: BorderRadius.circular(10),
//                                   color: ConstColor.whiteColor,
//                                   border: Border.all(
//                                     color:
//                                         ConstColor.buttonColor.withOpacity(0.4),
//                                   ),
//                                 ),
//                                 child: Row(
//                                   children: [
//                                     SizedBox(
//                                       width: Sizes.crossLength * 0.010,
//                                     ),
//                                     Container(
//                                       height: Sizes.crossLength * 0.060,
//                                       width: Sizes.crossLength * 0.060,
//                                       decoration: BoxDecoration(
//                                         borderRadius: BorderRadius.circular(
//                                             Sizes.crossLength * 0.010),
//                                         border: Border.all(
//                                             color: ConstColor.blackA5A5A5),
//                                       ),
//                                       child:
//                                           Image.asset(ConstAsset.profileImage),
//                                     ),
//                                     SizedBox(
//                                       width: Sizes.crossLength * 0.010,
//                                     ),
//                                     Expanded(
//                                       child: Column(
//                                         crossAxisAlignment:
//                                             CrossAxisAlignment.start,
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.center,
//                                         children: [
//                                           AppText(
//                                             text: controller
//                                                     .hospitalListData[index]
//                                                     .name ??
//                                                 '',
//                                             fontSize: Sizes.px14,
//                                             fontColor: ConstColor.black4B4D4F,
//                                             fontWeight: FontWeight.w600,
//                                           ),
//                                           SizedBox(
//                                               height:
//                                                   Sizes.crossLength * 0.005),
//                                           AppText(
//                                             text: controller
//                                                     .hospitalListData[index]
//                                                     .speciality ??
//                                                 '',
//                                             fontSize: Sizes.px12,
//                                             fontColor: ConstColor.blackA5A5A5,
//                                             fontWeight: FontWeight.w500,
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             );
//                           },
//                         ),
//                 )
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:venus/app/modules/bottomBar/controllers/bottom_bar_controller.dart';

import '../../../../main.dart';
import '../../../app_common_widgets/common_import.dart';
import '../controllers/hospital_doctors_controller.dart';

class HospitalDoctorsView extends GetView<HospitalDoctorsController> {
  const HospitalDoctorsView({super.key});
  @override
  Widget build(BuildContext context) {
    Get.put(HospitalDoctorsController());
    return GetBuilder<HospitalDoctorsController>(
      builder: (controller) {
        return PopScope(
          onPopInvokedWithResult: (bool didPop, Object? result) async {
            // This can be async and you can check your condition
            backButtonPress();
          },
          child: Scaffold(
            appBar: AppBar(
              title: AppText(
                text: 'Hospital Doctors',
                fontSize: Sizes.px22,
                fontColor: ConstColor.headingTexColor,
                fontWeight: FontWeight.w800,
              ),
              centerTitle: true,
              backgroundColor: Colors.white,
              elevation: 2,
              surfaceTintColor: Colors.white,
              shadowColor: Colors.grey,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => backButtonPress(),
              ),
            ),
            backgroundColor: Colors.white,
            body: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: Sizes.crossLength * 0.020,
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: Sizes.crossLength * 0.025,
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 4,
                        child: AppTextField(
                          controller: controller.searchController,
                          onTap: () {
                            controller.update();
                          },
                          onChanged: (text) {
                            controller.getHospitalDoctors(
                                searchPrefix: text.trim(), isLoader: false);
                          },
                          textInputAction: TextInputAction.done,
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 30),
                          onTapOutside: (event) {
                            FocusScope.of(context).unfocus();

                            controller.update();
                          },
                          onFieldSubmitted: (v) {
                            if (controller.searchController.text
                                .trim()
                                .isNotEmpty) {
                              controller.getHospitalDoctors(
                                  searchPrefix:
                                      controller.searchController.text.trim(),
                                  isLoader: false);
                            }
                            Future.delayed(const Duration(milliseconds: 800));
                            controller.update();
                          },
                          suffixIcon:
                              controller.searchController.text.trim().isNotEmpty
                                  ? GestureDetector(
                                      onTap: () {
                                        FocusScope.of(context).unfocus();
                                        controller.searchController.clear();
                                        controller.getHospitalDoctors(
                                            isLoader: false);
                                      },
                                      child: const Icon(Icons.cancel_outlined))
                                  : const SizedBox(),
                          prefixIcon: SvgPicture.asset(
                            ConstAsset.searchSvg,
                            height: Sizes.crossLength * 0.020,
                            width: Sizes.crossLength * 0.020,
                          ),
                          hintText: 'Search Specialist and Doctor',
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: getDynamicHeight(size: 0.020),
                  ),
                  Expanded(
                    flex: 4,
                    child: controller.hospitalListData.isEmpty
                        ? Center(
                            child: Padding(
                              padding: EdgeInsets.only(
                                  bottom: Sizes.crossLength * 0.050),
                              child: AppText(
                                text: 'No data found',
                                fontSize: Sizes.px15,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          )
                        : ListView.builder(
                            itemCount: controller.hospitalListData.length,
                            controller: controller.doctorsScrollController,
                            padding: EdgeInsets.only(
                                bottom: hideBottomBar.value ? 25 : 70),
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: EdgeInsets.only(
                                    top: getDynamicHeight(size: 0.015)),
                                child: Container(
                                  height: Sizes.crossLength * 0.080,
                                  // width: Sizes.crossLength * 0.380,
                                  decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.1),
                                        spreadRadius: 3.0,
                                      ),
                                    ],
                                    borderRadius: BorderRadius.circular(10),
                                    color: ConstColor.whiteColor,
                                    border: Border.all(
                                      color: ConstColor.buttonColor
                                          .withOpacity(0.4),
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width: Sizes.crossLength * 0.010,
                                      ),
                                      Container(
                                        height: Sizes.crossLength * 0.060,
                                        width: Sizes.crossLength * 0.060,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                              Sizes.crossLength * 0.010),
                                          border: Border.all(
                                              color: ConstColor.blackA5A5A5),
                                        ),
                                        child: Image.asset(
                                            ConstAsset.profileImage),
                                      ),
                                      SizedBox(
                                        width: Sizes.crossLength * 0.010,
                                      ),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            AppText(
                                              text: controller
                                                      .hospitalListData[index]
                                                      .name ??
                                                  '',
                                              fontSize: Sizes.px14,
                                              fontColor: ConstColor.black4B4D4F,
                                              fontWeight: FontWeight.w600,
                                            ),
                                            SizedBox(
                                                height:
                                                    Sizes.crossLength * 0.005),
                                            AppText(
                                              text: controller
                                                      .hospitalListData[index]
                                                      .speciality ??
                                                  '',
                                              fontSize: Sizes.px12,
                                              fontColor: ConstColor.blackA5A5A5,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
