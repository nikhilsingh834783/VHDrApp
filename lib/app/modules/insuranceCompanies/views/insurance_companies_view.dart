// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:get/get.dart';
// import 'package:url_launcher/url_launcher.dart';
// import 'package:venus/app/modules/insuranceCompanies/views/widgets/cashless_list_view.dart';
// import 'package:venus/app/modules/insuranceCompanies/views/widgets/corporate_list_view.dart';
//
// // import '../../../app_common_widgets/common_text.dart';
// import '../../../../main.dart';
// import '../../../app_common_widgets/common_import.dart';
// import '../controllers/insurance_companies_controller.dart';
//
// class InsuranceCompaniesView extends GetView<InsuranceCompaniesController> {
//   const InsuranceCompaniesView({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     Get.put(InsuranceCompaniesController());
//     return GetBuilder<InsuranceCompaniesController>(builder: (controller) {
//       return Scaffold(
//         appBar: AppBar(
//           title: AppText(
//             text: 'Insurance Companies',
//             fontSize: Sizes.px22,
//             fontColor: ConstColor.headingTexColor,
//             fontWeight: FontWeight.w800,
//           ),
//           centerTitle: true,
//           backgroundColor: Colors.white,
//           elevation: 2,
//           surfaceTintColor: Colors.white,
//           shadowColor: Colors.grey,
//           leading: IconButton(
//             icon: const Icon(Icons.arrow_back),
//             onPressed: () => Navigator.pop(context),
//           ),
//         ),
//         backgroundColor: Colors.white,
//         body: Padding(
//           padding: EdgeInsets.only(
//             left: Sizes.crossLength * 0.020,
//             right: Sizes.crossLength * 0.020,
//           ),
//           child: Column(
//             children: [
//               SizedBox(
//                 height: Sizes.crossLength * 0.025,
//               ),
//               Row(
//                 children: [
//                   Expanded(
//                     child: SizedBox(
//                       height: getDynamicHeight(size: 0.045),
//                       child: AppButton(
//                         radius: 45,
//                         onPressed: () {
//                           controller.searchController.clear();
//                           controller.selectedTab =
//                               0; // Set selectedTab to 0 for "Cashless"
//                           controller.getInsuranceCompany(
//                               selectedTab: 'Cashless');
//                           controller.update();
//                         },
//                         text: "Cashless",
//                         fontSize: Sizes.px14,
//                         textColor: controller.selectedTab == 0
//                             ? ConstColor.whiteColor
//                             : ConstColor.black6B6B6B,
//                         bgColor: controller.selectedTab == 0
//                             ? ConstColor.buttonColor
//                             : ConstColor.whiteF2F2F2,
//                       ),
//                     ),
//                   ),
//                   SizedBox(
//                     width: getDynamicHeight(size: 0.015),
//                   ),
//                   Expanded(
//                     child: SizedBox(
//                       height: getDynamicHeight(size: 0.045),
//                       child: AppButton(
//                         radius: 45,
//                         onPressed: () {
//                           controller.searchController.clear();
//                           controller.getInsuranceCompany(
//                               selectedTab: 'Corporate');
//                           controller.selectedTab =
//                               1; // Set selectedTab to 1 for "Corporate"
//                           controller.update();
//                         },
//                         text: "Corporate",
//                         fontSize: Sizes.px14,
//                         textColor: controller.selectedTab == 1
//                             ? ConstColor.whiteColor
//                             : ConstColor.black6B6B6B,
//                         bgColor: controller.selectedTab == 1
//                             ? ConstColor.buttonColor
//                             : ConstColor.whiteF2F2F2,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               // SizedBox(
//               //   height: getDynamicHeight(size: 0.025),
//               // ),
//               // Row(
//               //   children: [
//               //     Expanded(
//               //       flex: 4,
//               //       child: AppTextField(
//               //         onChanged: (text) {},
//               //         onTapOutside: (event) {
//               //           FocusScope.of(context).unfocus();
//               //           hideBottomBar.value = false;
//               //           controller.update();
//               //         },
//               //         contentPadding:
//               //             const EdgeInsets.symmetric(horizontal: 30),
//               //         prefixIcon: SvgPicture.asset(
//               //           ConstAsset.searchSvg,
//               //           height: Sizes.crossLength * 0.020,
//               //           width: Sizes.crossLength * 0.020,
//               //         ),
//               //         hintText: 'Search Companies',
//               //       ),
//               //     ),
//               //   ],
//               // ),
//               SizedBox(
//                 height: getDynamicHeight(size: 0.020),
//               ),
//               Expanded(
//                 child: controller.selectedTab == 0
//                     ? const CashlessListView()
//                     : const CorporateListView(),
//               ),
//               controller.showShortButton && !hideBottomBar.value
//                   ? Padding(
//                       padding: const EdgeInsets.only(bottom: 70),
//                       child: Align(
//                         alignment: Alignment.bottomCenter,
//                         child: SizedBox(
//                           height: 45,
//                           width: 200,
//                           child: OutlinedButton.icon(
//                             icon: SvgPicture.asset(
//                               "assets/images/svg/call.svg",
//                               height: 20,
//                               colorFilter: const ColorFilter.mode(
//                                 ConstColor.whiteColor,
//                                 BlendMode.srcIn,
//                               ),
//                             ),
//                             label: AppText(
//                               text: "+91 987 654 3210",
//                               fontSize: Sizes.px14,
//                               fontWeight: FontWeight.w600,
//                               fontColor: ConstColor.whiteColor,
//                             ),
//                             onPressed: () async {
//                               final Uri launchUri = Uri(
//                                 scheme: 'tel',
//                                 path: '+91 987 654 3210',
//                               );
//                               await launchUrl(launchUri);
//                             },
//                             style: OutlinedButton.styleFrom(
//                               backgroundColor: ConstColor.buttonColor,
//                               side: const BorderSide(
//                                   width: 1.0, color: ConstColor.whiteColor),
//                             ),
//                           ),
//                         ),
//                       ),
//                     )
//                   // Padding(
//                   //   padding: const EdgeInsets.only(bottom: 70),
//                   //   child: Align(
//                   //     alignment: Alignment.bottomCenter,
//                   //     child: SizedBox(
//                   //         height: 45,
//                   //         width: getDynamicHeight(size: 0.175),
//                   //         child:
//                   //         AppButton(
//                   //           text: 'OT Schedule',
//                   //           onPressed: () {
//                   //             calenderType = 2;
//                   //             previousDateEnable = false;
//                   //             controller.update();
//                   //             var otschedulerController =
//                   //             Get.put(OtschedulerController());
//                   //             otschedulerController.selectedOperationId =
//                   //             [];
//                   //             otschedulerController.selectedOperationList =
//                   //             [];
//                   //             otschedulerController.selectedDate = null;
//                   //             otschedulerController
//                   //                 .searchAdditionalDoctorList = null;
//                   //             otschedulerController
//                   //                 .searchOperationNameListData = null;
//                   //             otschedulerController.getOrganizationList();
//                   //             otschedulerController.getOperationName();
//                   //             otschedulerController.getAdditionalSurgeon();
//                   //             Get.to(() => const OtschedulerView())!
//                   //                 .then((value) {
//                   //               calenderType = 1;
//                   //               previousDateEnable = true;
//                   //               controller.update();
//                   //             }).then((value) => controller
//                   //                 .getOpdSchdulesDates(isLoader: true));
//                   //           },
//                   //           bgColor: ConstColor.buttonColor,
//                   //           radius: 50,
//                   //         )),
//                   //   ),
//                   // )
//                   : const SizedBox()
//             ],
//           ),
//         ),
//       );
//     });
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:venus/app/modules/insuranceCompanies/views/widgets/cashless_list_view.dart';
import 'package:venus/app/modules/insuranceCompanies/views/widgets/corporate_list_view.dart';

import '../../../../main.dart';
import '../../../app_common_widgets/common_import.dart';
import '../controllers/insurance_companies_controller.dart';

class InsuranceCompaniesView extends GetView<InsuranceCompaniesController> {
  const InsuranceCompaniesView({super.key});
  @override
  Widget build(BuildContext context) {
    Get.put(InsuranceCompaniesController());
    return GetBuilder<InsuranceCompaniesController>(builder: (controller) {
      return Scaffold(
        appBar: AppBar(
          title: AppText(
            text: 'Insurance Companies',
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
            onPressed: () => Navigator.pop(context),
          ),
        ),
        backgroundColor: Colors.white,
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
              Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: getDynamicHeight(size: 0.045),
                      child: AppButton(
                        radius: 45,
                        onPressed: () {
                          controller.searchController.clear();
                          controller.selectedTab = 0;
                          controller.getInsuranceCompany(
                              selectedTab: 'Cashless');
                          controller.update();
                        },
                        text: "Cashless",
                        fontSize: Sizes.px14,
                        textColor: controller.selectedTab == 0
                            ? ConstColor.whiteColor
                            : ConstColor.black6B6B6B,
                        bgColor: controller.selectedTab == 0
                            ? ConstColor.buttonColor
                            : ConstColor.whiteF2F2F2,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: getDynamicHeight(size: 0.015),
                  ),
                  Expanded(
                    child: SizedBox(
                      height: getDynamicHeight(size: 0.045),
                      child: AppButton(
                        radius: 45,
                        onPressed: () {
                          controller.searchController.clear();
                          controller.getInsuranceCompany(
                              selectedTab: 'Corporate');
                          controller.selectedTab =
                              1; // Set selectedTab to 1 for "Corporate"
                          controller.update();
                        },
                        text: "Corporate",
                        fontSize: Sizes.px14,
                        textColor: controller.selectedTab == 1
                            ? ConstColor.whiteColor
                            : ConstColor.black6B6B6B,
                        bgColor: controller.selectedTab == 1
                            ? ConstColor.buttonColor
                            : ConstColor.whiteF2F2F2,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: getDynamicHeight(size: 0.025),
              ),
              Row(
                children: [
                  Expanded(
                    flex: 4,
                    child: AppTextField(
                      onChanged: (text) {
                        controller.getInsuranceCompany(
                            isloader: false,
                            prefixText: text,
                            selectedTab: controller.selectedTab == 0
                                ? 'Cashless'
                                : 'Corporate');
                      },
                      onTapOutside: (event) {
                        FocusScope.of(context).unfocus();
                        hideBottomBar.value = false;
                        controller.update();
                      },
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 30),
                      controller: controller.searchController,
                      suffixIcon:
                          controller.searchController.text.trim().isNotEmpty
                              ? GestureDetector(
                                  onTap: () {
                                    FocusScope.of(context).unfocus();
                                    controller.searchController.clear();
                                    controller.getInsuranceCompany(
                                        isloader: false,
                                        selectedTab: controller.selectedTab == 0
                                            ? 'Cashless'
                                            : 'Corporate');
                                  },
                                  child: const Icon(Icons.cancel_outlined))
                              : const SizedBox(),
                      prefixIcon: SvgPicture.asset(
                        ConstAsset.searchSvg,
                        height: Sizes.crossLength * 0.020,
                        width: Sizes.crossLength * 0.020,
                      ),
                      hintText: 'Search Companies',
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: getDynamicHeight(size: 0.020),
              ),
              Expanded(
                child: controller.selectedTab == 0
                    ? const CashlessListView()
                    : const CorporateListView(),
              ),
              controller.showShortButton && !hideBottomBar.value
                  ? Padding(
                      padding: const EdgeInsets.only(bottom: 70),
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: SizedBox(
                          height: 45,
                          width: 200,
                          child: OutlinedButton.icon(
                            icon: SvgPicture.asset(
                              "assets/images/svg/call.svg",
                              height: 20,
                              colorFilter: const ColorFilter.mode(
                                ConstColor.whiteColor,
                                BlendMode.srcIn,
                              ),
                            ),
                            label: AppText(
                              text: "+91 987 654 3210",
                              fontSize: Sizes.px14,
                              fontWeight: FontWeight.w600,
                              fontColor: ConstColor.whiteColor,
                            ),
                            onPressed: () async {
                              final Uri launchUri = Uri(
                                scheme: 'tel',
                                path: '+91 987 654 3210',
                              );
                              await launchUrl(launchUri);
                            },
                            style: OutlinedButton.styleFrom(
                              backgroundColor: ConstColor.buttonColor,
                              side: const BorderSide(
                                  width: 1.0, color: ConstColor.whiteColor),
                            ),
                          ),
                        ),
                      ),
                    )
                  // Padding(
                  //   padding: const EdgeInsets.only(bottom: 70),
                  //   child: Align(
                  //     alignment: Alignment.bottomCenter,
                  //     child: SizedBox(
                  //         height: 45,
                  //         width: getDynamicHeight(size: 0.175),
                  //         child:
                  //         AppButton(
                  //           text: 'OT Schedule',
                  //           onPressed: () {
                  //             calenderType = 2;
                  //             previousDateEnable = false;
                  //             controller.update();
                  //             var otschedulerController =
                  //             Get.put(OtschedulerController());
                  //             otschedulerController.selectedOperationId =
                  //             [];
                  //             otschedulerController.selectedOperationList =
                  //             [];
                  //             otschedulerController.selectedDate = null;
                  //             otschedulerController
                  //                 .searchAdditionalDoctorList = null;
                  //             otschedulerController
                  //                 .searchOperationNameListData = null;
                  //             otschedulerController.getOrganizationList();
                  //             otschedulerController.getOperationName();
                  //             otschedulerController.getAdditionalSurgeon();
                  //             Get.to(() => const OtschedulerView())!
                  //                 .then((value) {
                  //               calenderType = 1;
                  //               previousDateEnable = true;
                  //               controller.update();
                  //             }).then((value) => controller
                  //                 .getOpdSchdulesDates(isLoader: true));
                  //           },
                  //           bgColor: ConstColor.buttonColor,
                  //           radius: 50,
                  //         )),
                  //   ),
                  // )
                  : const SizedBox()
            ],
          ),
        ),
      );
    });
  }
}
