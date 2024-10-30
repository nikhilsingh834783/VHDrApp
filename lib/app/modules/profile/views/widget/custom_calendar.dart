// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:intl/intl.dart';
// import 'package:venus/app/app_common_widgets/common_import.dart';
// import 'package:venus/app/custom_calender/calendar_widget.dart';
// import 'package:venus/app/modules/profile/controllers/profile_controller.dart';
//
// class SelectBirthDate extends StatelessWidget {
//   const SelectBirthDate({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<ProfileController>(builder: (controller) {
//       return Container(
//         decoration: BoxDecoration(
//             color: ConstColor.whiteColor,
//             border: Border.all(width: 0.5, color: ConstColor.boldBlackColor),
//             borderRadius: BorderRadius.circular(10)),
//         child: Padding(
//             padding: EdgeInsets.symmetric(
//                 horizontal: getDynamicHeight(size: 0.015),
//                 vertical: getDynamicHeight(size: 0.020)),
//             child: CustomCalendar(
//               selectedDates: controller.selectedDate,
//               streakDatesList: const [],
//               unAvailableDatesList: controller.selectedDate != null
//                   ? [controller.selectedDate!]
//                   : [],
//               onSelectedDates: (va) {
//                 controller.selectedDate = va[0];
//                 controller.dateOfOperation.text =
//                     DateFormat('dd/MM/yyyy').format(controller.selectedDate!);
//                 controller.selectDateController.hideMenu();
//                 controller.update();
//               },
//             )),
//       );
//     });
//   }
// }

//2
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:venus/app/app_common_widgets/common_import.dart';
import 'package:venus/app/custom_calender/calendar_widget.dart';
import '../../controllers/profile_controller.dart';
class DateofBirth extends StatelessWidget {
  const DateofBirth({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(builder: (controller) {
      return Container(
        decoration: BoxDecoration(
            color: ConstColor.whiteColor,
            borderRadius: BorderRadius.circular(10)),
        child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: getDynamicHeight(size: 0.015),
            ),
            child: CustomCalendar(
              selectedDates: controller.selectedDate,
              streakDatesList: const [],
              unAvailableDatesList: controller.selectedDate != null
                  ? [controller.selectedDate!]
                  : [],
              onSelectedDates: (va) {
                controller.selectedDate = va[0];
                controller.dateOfOperation.text =
                    DateFormat('dd/MM/yyyy').format(controller.selectedDate!);
                // controller.selectDateController.hideMenu();
                Navigator.pop(context);
                controller.update();
              },
            )),
      );
    });
  }
}
