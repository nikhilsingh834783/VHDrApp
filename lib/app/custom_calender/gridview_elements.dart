import 'package:flutter/material.dart';

import 'calender_common_import.dart';
import 'event_calender_model.dart';

class CalendarDateWidget extends StatelessWidget {
  const CalendarDateWidget(
      {super.key,
      required this.calendarProperties,
      required this.pageViewElementDate,
      required this.pageViewDate,
      this.eventList});

  final CalendarProperties calendarProperties;
  final DateTime pageViewElementDate;
  final DateTime pageViewDate;
  final EventListModel? eventList;

  @override
  Widget build(BuildContext context) {
    if (calendarProperties.datesForStreaks.contains(pageViewElementDate)) {
      return GetSuitableCalendarStreakDateWidget(
          calendarProperties: calendarProperties,
          pageViewElementDate: pageViewElementDate,
          pageViewDate: pageViewDate);
    }
    if (!calendarProperties.datesForStreaks.contains(pageViewElementDate)) {
      return GetSuitableCalendarGeneralDateWidget(
        calendarProperties: calendarProperties,
        pageViewElementDate: pageViewElementDate,
        pageViewDate: pageViewDate,
        eventList: eventList,
      );
    } else {
      return const SizedBox();
    }
  }
}
