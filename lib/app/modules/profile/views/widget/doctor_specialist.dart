import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:venus/app/modules/profile/controllers/profile_controller.dart';
import '../../../../app_common_widgets/common_text.dart';
import '../../../../app_common_widgets/sizer_constant.dart';
import '../../../../core/them/const_color.dart';

class DoctorSpecialist extends StatelessWidget {
  const DoctorSpecialist({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(builder: (controller) {
      return Container(
        decoration: const BoxDecoration(
          color: ConstColor.whiteColor,
          // border: Border.all(width: 0.5, color: ConstColor.graphColor),
          // borderRadius: BorderRadius.circular(10),
        ),
        height: getDynamicHeight(size: 0.395),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: getDynamicHeight(size: 0.015),
            vertical: getDynamicHeight(size: 0.020),
          ),
          child: ListView.builder(
            padding: EdgeInsets.zero,
            itemCount: controller.drSpecialitiesData.length,
            itemBuilder: (context, index) {
              final speciality = controller.drSpecialitiesData[index];
              return GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  controller.doctorSpecialityController.text =
                      speciality.speciality ?? '';
                  controller.doctorSpecialistNameController.hideMenu();
                  controller.update();
                  Get.back();
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 15),
                    Row(
                      children: [
                        Expanded(
                          child: AppText(text: speciality.speciality ?? ''),
                        ),
                      ],
                    ),
                    if (index != controller.drSpecialitiesData.length - 1)
                      const SizedBox(height: 15),
                    if (index != controller.drSpecialitiesData.length - 1)
                      const Divider(
                        thickness: 1,
                        height: 1,
                        color: ConstColor.greyACACAC,
                      ),
                  ],
                ),
              );
            },
          ),
        ),
      );
    });
  }
}

// class DoctorSpecialist extends StatelessWidget {
//   const DoctorSpecialist({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<ProfileController>(builder: (controller) {
//       return Container(
//         decoration: BoxDecoration(
//             color: ConstColor.whiteColor,
//             border: Border.all(width: 0.5, color: ConstColor.boldBlackColor),
//             borderRadius: BorderRadius.circular(10)),
//         height: getDynamicHeight(size: 0.395),
//         child: Padding(
//             padding: EdgeInsets.symmetric(
//                 horizontal: getDynamicHeight(size: 0.015),
//                 vertical: getDynamicHeight(size: 0.020)),
//             child: ListView.builder(
//                 padding: EdgeInsets.zero,
//                 itemCount: controller.drSpecialitiesData.length,
//                 itemBuilder: (item, index) {
//                   return GestureDetector(
//                     behavior: HitTestBehavior.opaque,
//                     onTap: () {
//                       controller.doctorSpecialityController.text =
//                           controller.drSpecialitiesData[index].speciality ?? '';
//                       controller.doctorSpecialistNameController.hideMenu();
//                       controller.update();
//                     },
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         const SizedBox(
//                           height: 15,
//                         ),
//                         Row(
//                           children: [
//                             Expanded(
//                               child: AppText(
//                                   text: controller.drSpecialitiesData[index]
//                                           .organization ??
//                                       ''),
//                             ),
//                           ],
//                         ),
//                         index == controller.drSpecialitiesData.length - 1
//                             ? const SizedBox()
//                             : const SizedBox(
//                                 height: 15,
//                               ),
//                         index == controller.drSpecialitiesData.length - 1
//                             ? const SizedBox()
//                             : const Divider(
//                                 thickness: 1,
//                                 height: 1,
//                                 color: ConstColor.greyACACAC,
//                               )
//                       ],
//                     ),
//                   );
//                 })),
//       );
//     });
//   }
// }
