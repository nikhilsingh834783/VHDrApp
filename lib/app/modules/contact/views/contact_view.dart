// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:get/get.dart';
// import 'package:url_launcher/url_launcher.dart';
// import 'package:venus/app/app_common_widgets/common_import.dart';
//
// import '../../../../main.dart';
// import '../../../app_common_widgets/my_drawer.dart';
// import '../../bottomBar/controllers/bottom_bar_controller.dart';
// import '../controllers/contact_controller.dart';
// import '../models/contact_model.dart';
//
// class ContactView extends GetView<ContactController> {
//   const ContactView({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     Get.put(ContactController());
//     var botttomCntrl = Get.find<BottomBarController>();
//     return GetBuilder<ContactController>(
//       builder: (controller) {
//         return Scaffold(
//           key: controller.scaffoldKey,
//           appBar: AppBar(
//             title: AppText(
//               text: 'Contacts',
//               fontSize: Sizes.px22,
//               fontColor: ConstColor.headingTexColor,
//               fontWeight: FontWeight.w800,
//             ),
//             centerTitle: true,
//             backgroundColor: Colors.white,
//             elevation: 2,
//             excludeHeaderSemantics: false,
//             surfaceTintColor: Colors.white,
//             shadowColor: Colors.grey,
//             leading: IconButton(
//                 icon: SvgPicture.asset('assets/images/svg/menu.svg'),
//                 onPressed: () =>
//                     controller.scaffoldKey.currentState!.openDrawer()),
//           ),
//           backgroundColor: Colors.white,
//           // onDrawerChanged: (isop) {
//           //   if (!isop) {
//           //     FocusScope.of(context).unfocus();
//           //     controller.focusNode.unfocus();
//           //     var bottomBarController = Get.find<BottomBarController>();
//           //     bottomBarController.navigateToHome();
//           //     hideBottomBar.value = isop;
//           //     bottomBarController.update();
//           //   }
//           // },
//           onDrawerChanged: (isop) {
//             FocusScope.of(context).unfocus();
//             controller.focusNode.unfocus();
//             var bottomBarController = Get.put(BottomBarController());
//             hideBottomBar.value = isop;
//             bottomBarController.update();
//           },
//           drawer: const MyDrawer(),
//           body: Padding(
//             padding: EdgeInsets.only(
//               left: Sizes.crossLength * 0.020,
//               right: Sizes.crossLength * 0.020,
//             ),
//             child: Column(
//               children: [
//                 SizedBox(
//                   height: getDynamicHeight(size: 0.020),
//                 ),
//                 Row(
//                   children: [
//                     Expanded(
//                       // flex: 4,
//                       child: AppTextField(
//                         focusNode: controller.focusNode,
//                         controller: controller.searchController,
//                         // onTap: () {
//                         //   controller.update();
//                         // },
//                         onTap: () => controller.update(),
//                         onChanged: (text) {
//                           controller.getContacts(
//                               // searchPrefix: text.trim(), isLoader: false);
//                               searchPrefix: text,
//                               isLoader: false);
//                         },
//                         textInputAction: TextInputAction.done,
//                         contentPadding:
//                             const EdgeInsets.symmetric(horizontal: 30),
//                         onTapOutside: (event) {
//                           FocusScope.of(context).unfocus();
//                           controller.update();
//                         },
//                         onFieldSubmitted: (v) {
//                           if (controller.searchController.text
//                               .trim()
//                               .isNotEmpty) {
//                             controller.getContacts(
//                                 searchPrefix:
//                                     controller.searchController.text.trim(),
//                                 isLoader: false);
//                           }
//                           Future.delayed(const Duration(milliseconds: 800));
//                           controller.update();
//                         },
//                         suffixIcon: controller.searchController.text
//                                 .trim()
//                                 .isNotEmpty
//                             ? GestureDetector(
//                                 onTap: () {
//                                   FocusScope.of(context).unfocus();
//                                   controller.searchController.clear();
//                                   controller.getContacts(
//                                     searchPrefix:
//                                         controller.searchController.text.trim(),
//                                     isLoader: false,
//                                   );
//                                   // controller.getContacts(isLoader: false);
//                                 },
//                                 child: const Icon(Icons.cancel_outlined))
//                             : const SizedBox(),
//                         prefixIcon: SvgPicture.asset(
//                           ConstAsset.searchSvg,
//                           height: Sizes.crossLength * 0.020,
//                           width: Sizes.crossLength * 0.020,
//                         ),
//                         hintText: 'Search Contacts',
//                       ),
//                     ),
//                   ],
//                 ),
//                 SizedBox(
//                   height: getDynamicHeight(size: 0.020),
//                 ),
//                 Expanded(
//                   flex: 4,
//                   child: controller.contactListData.isEmpty
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
//                       : GridView.builder(
//                           shrinkWrap: true,
//                           controller: controller.contactScrollController,
//                           padding: EdgeInsets.only(
//                               bottom: hideBottomBar.value ? 35 : 65),
//                           gridDelegate:
//                               const SliverGridDelegateWithFixedCrossAxisCount(
//                             crossAxisCount: 2,
//                             childAspectRatio: 1.05,
//                           ),
//                           itemCount: controller.contactListData.length,
//                           itemBuilder: (context, index) {
//                             return Padding(
//                               padding: const EdgeInsets.all(8.0),
//                               child: Container(
//                                 decoration: BoxDecoration(
//                                   border:
//                                       Border.all(color: ConstColor.buttonColor),
//                                   color: Colors.white,
//                                   borderRadius: BorderRadius.circular(10),
//                                 ),
//                                 child: Center(
//                                   child: Column(
//                                     children: [
//                                       SizedBox(
//                                         height: getDynamicHeight(size: 0.02),
//                                       ),
//                                       AppText(
//                                         text: controller
//                                                 .contactListData[index].name ??
//                                             '',
//                                         fontSize: Sizes.px16,
//                                         fontColor: ConstColor.black4B4D4F,
//                                         fontWeight: FontWeight.w700,
//                                         textAlign: TextAlign.center,
//                                       ),
//                                       SizedBox(
//                                         height: getDynamicHeight(size: 0.008),
//                                       ),
//                                       AppText(
//                                         text: controller.contactListData[index]
//                                                 .contactNo ??
//                                             '',
//                                         fontSize: Sizes.px15,
//                                         fontColor: ConstColor.black5E5E5E,
//                                         fontWeight: FontWeight.w600,
//                                       ),
//                                       // SizedBox(
//                                       //   height: getDynamicHeight(size: 0.02),
//                                       // ),
//                                       Spacer(),
//
//                                       Row(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.center,
//                                         children: [
//                                           SizedBox(
//                                               width: Sizes.crossLength * 0.01),
//                                           GestureDetector(
//                                             onTap: () async {
//                                               FocusScope.of(context).unfocus();
//                                               controller.focusNode.unfocus();
//                                               final Uri whatsappUri = Uri(
//                                                 scheme: 'https',
//                                                 host: 'wa.me',
//                                                 path:
//                                                     '${controller.contactListData[index].contactNo}',
//                                                 queryParameters: {
//                                                   'text': 'Hello This ',
//                                                 },
//                                               );
//                                               await launchUrl(Uri.parse(
//                                                       whatsappUri.toString()))
//                                                   .then((value) =>
//                                                       FocusScope.of(context)
//                                                           .unfocus());
//                                               // if (await launchUrl(Uri.parse(
//                                               //     whatsappUri.toString()))) {
//                                               //   await launchUrl(Uri.parse(
//                                               //       whatsappUri.toString()));
//                                               // } else {
//                                               //   throw 'Could not launch $whatsappUri';
//                                               // }
//                                             },
//                                             child: Container(
//                                               width: Sizes.crossLength * 0.050,
//                                               height: Sizes.crossLength * 0.042,
//                                               decoration: const BoxDecoration(
//                                                   shape: BoxShape.circle,
//                                                   color:
//                                                       ConstColor.buttonColor),
//                                               child: Center(
//                                                 child: Padding(
//                                                   padding:
//                                                       const EdgeInsets.only(
//                                                           left: 2),
//                                                   child: SvgPicture.asset(
//                                                     'assets/images/svg/whatsapp.svg',
//                                                     height: 25,
//                                                   ),
//                                                 ),
//                                               ),
//                                             ),
//                                           ),
//                                           const SizedBox(width: 5),
//                                           SizedBox(
//                                             width: Sizes.crossLength * 0.080,
//                                             height: Sizes.crossLength * 0.040,
//                                             child: AppButton(
//                                                 radius: 50,
//                                                 fontSize: Sizes.px16,
//                                                 fontWeight: FontWeight.w500,
//                                                 text: 'Call',
//                                                 onPressed: () async {
//                                                   FocusScope.of(context)
//                                                       .unfocus();
//                                                   controller.focusNode
//                                                       .unfocus();
//                                                   final Uri launchUri = Uri(
//                                                     scheme: 'tel',
//                                                     path:
//                                                         '${controller.contactListData[index].contactNo}',
//                                                   );
//                                                   await launchUrl(launchUri)
//                                                       .then((value) =>
//                                                           FocusScope.of(context)
//                                                               .unfocus());
//                                                 }),
//                                           ),
//                                           SizedBox(
//                                               height: Sizes.crossLength * 0.06),
//                                         ],
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                             );
//                           },
//                         ),
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:venus/app/app_common_widgets/common_import.dart';

import '../../../../main.dart';
import '../../../app_common_widgets/my_drawer.dart';
import '../../bottomBar/controllers/bottom_bar_controller.dart';
import '../controllers/contact_controller.dart';
import '../models/contact_model.dart';

class ContactView extends GetView<ContactController> {
  const ContactView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ContactController());
    var botttomCntrl = Get.find<BottomBarController>();
    return GetBuilder<ContactController>(
      builder: (controller) {
        return Scaffold(
          key: controller.scaffoldKey,
          appBar: AppBar(
            title: AppText(
              text: 'Contacts',
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
                icon: SvgPicture.asset('assets/images/svg/menu.svg'),
                onPressed: () =>
                    controller.scaffoldKey.currentState!.openDrawer()),
          ),
          backgroundColor: Colors.white,
          // onDrawerChanged: (isop) {
          //   if (!isop) {
          //     FocusScope.of(context).unfocus();
          //     controller.focusNode.unfocus();
          //     var bottomBarController = Get.find<BottomBarController>();
          //     bottomBarController.navigateToHome();
          //     hideBottomBar.value = isop;
          //     bottomBarController.update();
          //   }
          // },
          onDrawerChanged: (isop) {
            FocusScope.of(context).unfocus();
            controller.focusNode.unfocus();
            var bottomBarController = Get.put(BottomBarController());
            hideBottomBar.value = isop;
            bottomBarController.update();
          },
          drawer: const MyDrawer(),
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
                  height: getDynamicHeight(size: 0.020),
                ),
                Row(
                  children: [
                    Expanded(
                      // flex: 4,
                      child: AppTextField(
                        focusNode: controller.focusNode,
                        controller: controller.searchController,
                        // onTap: () {
                        //   controller.update();
                        // },
                        onTap: () => controller.update(),
                        onChanged: (text) {
                          controller.getContacts(
                            // searchPrefix: text.trim(), isLoader: false);
                              searchPrefix: text,
                              isLoader: false);
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
                            controller.getContacts(
                                searchPrefix:
                                controller.searchController.text.trim(),
                                isLoader: false);
                          }
                          Future.delayed(const Duration(milliseconds: 800));
                          controller.update();
                        },
                        suffixIcon: controller.searchController.text
                            .trim()
                            .isNotEmpty
                            ? GestureDetector(
                            onTap: () {
                              FocusScope.of(context).unfocus();
                              controller.searchController.clear();
                              controller.getContacts(
                                searchPrefix:
                                controller.searchController.text.trim(),
                                isLoader: false,
                              );
                              // controller.getContacts(isLoader: false);
                            },
                            child: const Icon(Icons.cancel_outlined))
                            : const SizedBox(),
                        prefixIcon: SvgPicture.asset(
                          ConstAsset.searchSvg,
                          height: Sizes.crossLength * 0.020,
                          width: Sizes.crossLength * 0.020,
                        ),
                        hintText: 'Search Contact',
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: getDynamicHeight(size: 0.020),
                ),
                Expanded(
                  flex: 4,
                  child: controller.contactListData.isEmpty
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
                      : GridView.builder(
                    shrinkWrap: true,
                    controller: controller.contactScrollController,
                    padding: EdgeInsets.only(
                        bottom: hideBottomBar.value ? 35 : 65),
                    gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 1.05,
                    ),
                    itemCount: controller.contactListData.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            border:
                            Border.all(color: ConstColor.buttonColor),
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: Column(
                              children: [
                                SizedBox(
                                  height: getDynamicHeight(size: 0.02),
                                ),
                                AppText(
                                  text: controller
                                      .contactListData[index].name ??
                                      '',
                                  fontSize: Sizes.px16,
                                  fontColor: ConstColor.black4B4D4F,
                                  fontWeight: FontWeight.w700,
                                  textAlign: TextAlign.center,
                                ),
                                SizedBox(
                                  height: getDynamicHeight(size: 0.008),
                                ),
                                AppText(
                                  text: controller.contactListData[index]
                                      .contactNo ??
                                      '',
                                  fontSize: Sizes.px15,
                                  fontColor: ConstColor.black5E5E5E,
                                  fontWeight: FontWeight.w600,
                                ),
                                // SizedBox(
                                //   height: getDynamicHeight(size: 0.02),
                                // ),
                                Spacer(),

                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                        width: Sizes.crossLength * 0.01),
                                    GestureDetector(
                                      onTap: () async {
                                        FocusScope.of(context).unfocus();
                                        controller.focusNode.unfocus();
                                        final Uri whatsappUri = Uri(
                                          scheme: 'https',
                                          host: 'wa.me',
                                          path:
                                          '${controller.contactListData[index].contactNo}',
                                          queryParameters: {
                                            'text': 'Hello This ',
                                          },
                                        );
                                        await launchUrl(Uri.parse(
                                            whatsappUri.toString()))
                                            .then((value) =>
                                            FocusScope.of(context)
                                                .unfocus());
                                        // if (await launchUrl(Uri.parse(
                                        //     whatsappUri.toString()))) {
                                        //   await launchUrl(Uri.parse(
                                        //       whatsappUri.toString()));
                                        // } else {
                                        //   throw 'Could not launch $whatsappUri';
                                        // }
                                      },
                                      child: Container(
                                        width: Sizes.crossLength * 0.050,
                                        height: Sizes.crossLength * 0.042,
                                        decoration: const BoxDecoration(
                                            shape: BoxShape.circle,
                                            color:
                                            ConstColor.buttonColor),
                                        child: Center(
                                          child: Padding(
                                            padding:
                                            const EdgeInsets.only(
                                                left: 2),
                                            child: SvgPicture.asset(
                                              'assets/images/svg/whatsapp.svg',
                                              height: 25,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 5),
                                    SizedBox(
                                      width: Sizes.crossLength * 0.080,
                                      height: Sizes.crossLength * 0.040,
                                      child: AppButton(
                                          radius: 50,
                                          fontSize: Sizes.px16,
                                          fontWeight: FontWeight.w500,
                                          text: 'Call',
                                          onPressed: () async {
                                            FocusScope.of(context)
                                                .unfocus();
                                            controller.focusNode
                                                .unfocus();
                                            final Uri launchUri = Uri(
                                              scheme: 'tel',
                                              path:
                                              '${controller.contactListData[index].contactNo}',
                                            );
                                            await launchUrl(launchUri)
                                                .then((value) =>
                                                FocusScope.of(context)
                                                    .unfocus());
                                          }),
                                    ),
                                    SizedBox(
                                        height: Sizes.crossLength * 0.06),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}