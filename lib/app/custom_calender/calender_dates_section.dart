import 'package:flutter/material.dart';

import 'calender_common_import.dart';

class CalendarDatesSection extends StatelessWidget {
  const CalendarDatesSection(
      {super.key,
      required this.calendarProperties,
      required this.pageControllerState});

  final CalendarProperties calendarProperties;
  final PageControllerState pageControllerState;

  @override
  Widget build(BuildContext context) {
    if (calendarProperties.dateSelectionMode ==
                DatePickerSelectionMode.singleOrMultiple ||
            calendarProperties.dateSelectionMode ==
                DatePickerSelectionMode.disable
        // || dateSelectionMode == DatePickerSelectionMode.multiple
        ) {
      return ScrollablePageViewBuilder(
        calendarProperties: calendarProperties,
        pageControllerState: pageControllerState,
      );
    }
    // if (dateSelectionMode == DatePickerSelectionMode.range) {
    //   return const NonScrollablePageViewBuilder();
    // }
    else {
      return const SizedBox();
    }
  }
}
