import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../custom_calender/calender_common_import.dart';
import '../../controllers/login_controller.dart';

class ShowCaalenderWidget extends StatelessWidget {
  const ShowCaalenderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(builder: (controller) {
      return SizedBox(
        height: 300,
        child: CustomCalendar(
          selectedDates: controller.selectedDate,
          streakDatesList: const [],
          unAvailableDatesList:
              controller.selectedDate != null ? [controller.selectedDate!] : [],
          onSelectedDates: (va) {
            controller.selectedDate = va[0];
            controller.showSelectedDateTime =
                DateFormat('MMM dd, yyyy').format(controller.selectedDate!);
            controller.update();
          },
        ),
      );
    });
  }
}
