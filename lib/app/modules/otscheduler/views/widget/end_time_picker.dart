import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:venus/app/app_common_widgets/common_import.dart';

import '../../controllers/otscheduler_controller.dart';

class SelectEndTime extends StatelessWidget {
  const SelectEndTime({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OtschedulerController>(builder: (controller) {
      return Container(
        decoration: BoxDecoration(
            color: ConstColor.whiteColor,
            borderRadius: BorderRadius.circular(10)),
        height: 260,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(
                right: Sizes.crossLength * 0.020,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                      onTap: () {
                        controller.endTimeController.text =
                            '${controller.selectedHour.toString().padLeft(2, '0')}:${controller.selectedMinute.toString().padLeft(2, '0')} ${controller.isAm ? 'AM' : 'PM'}';
                        // controller.endTimePicker.hideMenu();
                        Navigator.pop(context);
                        controller.update();
                      },
                      child: AppText(
                        text: 'Done',
                        fontColor: ConstColor.buttonColor,
                        fontSize: Sizes.px15,
                        fontWeight: FontWeight.w500,
                      ))
                ],
              ),
            ),
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: CupertinoPicker(
                      itemExtent: 40,
                      onSelectedItemChanged: (int index) {
                        controller.selectedHour = index + 1;
                        controller.update();
                      },
                      scrollController: FixedExtentScrollController(
                          initialItem: controller.selectedHour - 1),
                      children: controller.buildHourPicker(),
                    ),
                  ),
                  AppText(
                    text: ':',
                    fontColor: ConstColor.black6B6B6B,
                    fontSize: Sizes.px16,
                  ),
                  Expanded(
                    child: CupertinoPicker(
                      itemExtent: 40,
                      onSelectedItemChanged: (int index) {
                        controller.selectedMinute = index;
                        controller.update();
                      },
                      scrollController: FixedExtentScrollController(
                          initialItem: controller.selectedMinute),
                      children: controller.buildMinutePicker(),
                    ),
                  ),
                  AppText(text: ':'),
                  Expanded(
                    child: CupertinoPicker(
                      itemExtent: 40,
                      onSelectedItemChanged: (int index) {
                        controller.isAm = index == 0;
                      },
                      scrollController: FixedExtentScrollController(
                          initialItem: controller.isAm ? 0 : 1),
                      children: controller.buildAmPmPicker(),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }
}
