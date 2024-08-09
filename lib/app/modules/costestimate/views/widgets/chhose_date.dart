import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:venus/app/app_common_widgets/common_import.dart';
import 'package:venus/app/custom_calender/calendar_widget.dart';

import '../../controllers/costestimate_controller.dart';

class ChooseDateView extends StatelessWidget {
  const ChooseDateView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CostestimateController>(builder: (controller) {
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
                controller.dateController.text =
                    DateFormat('dd-MMM-yyyy').format(controller.selectedDate!);
                // controller.selectDateController.hideMenu();
                Navigator.pop(context);
                controller.update();
              },
            )),
      );
    });
  }
}
