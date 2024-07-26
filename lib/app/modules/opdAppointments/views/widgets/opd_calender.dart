import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:venus/app/app_common_widgets/common_import.dart';
import 'package:venus/app/custom_calender/calendar_widget.dart';

import '../../controllers/opd_appointments_controller.dart';

class OpdCalender extends StatelessWidget {
  const OpdCalender({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OpdAppointmentsController>(builder: (controller) {
      return Container(
        decoration: BoxDecoration(
            color: ConstColor.whiteColor,
            border: Border.all(width: 0.5, color: ConstColor.boldBlackColor),
            borderRadius: BorderRadius.circular(10)),
        // height: getDynamicHeight(size: 0.430),
        child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: getDynamicHeight(size: 0.015),
                vertical: getDynamicHeight(size: 0.020)),
            child: CustomCalendar(
              selectedDates: controller.selectedDate,
              streakDatesList: const [],
              unAvailableDatesList: [controller.selectedDate],
              onSelectedDates: (va) {
                controller.selectedDate = va[0];
                // controller.dateOfOperation.text =
                //     DateFormat('dd-MMM-yyyy').format(controller.selectedDate!);
                controller.selectDateController.hideMenu();
                controller.getOpdAppointments(isLoader: true);
                controller.update();
              },
            )),
      );
    });
  }
}
