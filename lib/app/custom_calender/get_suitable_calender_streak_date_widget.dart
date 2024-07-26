import 'package:flutter/material.dart';

import 'calender_common_import.dart';
import 'event_calender_model.dart';

class GetSuitableCalendarStreakDateWidget extends StatelessWidget {
  const GetSuitableCalendarStreakDateWidget(
      {super.key,
      required this.calendarProperties,
      required this.pageViewElementDate,
      required this.pageViewDate});

  final CalendarProperties calendarProperties;
  final DateTime pageViewElementDate;
  final DateTime pageViewDate;

  @override
  Widget build(BuildContext context) {
    /// Called when streak date have streak date just before and just after also.
    if (calendarProperties.datesForStreaks
            .contains(pageViewElementDate.add(const Duration(days: 1))) &&
        calendarProperties.datesForStreaks
            .contains(pageViewElementDate.subtract(const Duration(days: 1))) &&
        calendarProperties.datesForStreaks.contains(pageViewElementDate)) {
      if (calendarProperties.enableDenseViewForDates &&
          calendarProperties.enableDenseSplashForDates) {
        return CalendarStreakBetweenDenseSplashDate(
          calendarProperties: calendarProperties,
          pageViewElementDate: pageViewElementDate,
          pageViewDate: pageViewDate,
        );
      }
      if (calendarProperties.enableDenseViewForDates) {
        return CalendarStreakBetweenExpandedDate(
          calendarProperties: calendarProperties,
          pageViewElementDate: pageViewElementDate,
          pageViewDate: pageViewDate,
        );
      }
      if (!calendarProperties.enableDenseViewForDates) {
        return CalendarStreakBetweenExpandedDate(
          calendarProperties: calendarProperties,
          pageViewElementDate: pageViewElementDate,
          pageViewDate: pageViewDate,
        );
      } else {
        return const SizedBox();
      }
    }

    /// Called when streak date have a streak date just after.
    if (calendarProperties.datesForStreaks
        .contains(pageViewElementDate.add(const Duration(days: 1)))) {
      if (calendarProperties.enableDenseViewForDates &&
          calendarProperties.enableDenseSplashForDates) {
        return CalendarStreakStartDenseSplashDate(
          calendarProperties: calendarProperties,
          pageViewElementDate: pageViewElementDate,
          pageViewDate: pageViewDate,
        );
      }
      if (calendarProperties.enableDenseViewForDates) {
        return CalendarStreakStartDenseDate(
          calendarProperties: calendarProperties,
          pageViewElementDate: pageViewElementDate,
          pageViewDate: pageViewDate,
        );
      }
      if (!calendarProperties.enableDenseViewForDates) {
        return CalendarStreakStartExpandedDate(
          calendarProperties: calendarProperties,
          pageViewElementDate: pageViewElementDate,
          pageViewDate: pageViewDate,
        );
      } else {
        return const SizedBox();
      }
    }

    /// Called when streak date have a streak date just before.
    if (calendarProperties.datesForStreaks
        .contains(pageViewElementDate.subtract(const Duration(days: 1)))) {
      if (calendarProperties.enableDenseViewForDates &&
          calendarProperties.enableDenseSplashForDates) {
        return CalendarStreakEndDenseSplashDate(
          calendarProperties: calendarProperties,
          pageViewElementDate: pageViewElementDate,
          pageViewDate: pageViewDate,
        );
      }
      if (calendarProperties.enableDenseViewForDates) {
        return CalendarStreakEndDenseDate(
          calendarProperties: calendarProperties,
          pageViewElementDate: pageViewElementDate,
          pageViewDate: pageViewDate,
        );
      }
      if (!calendarProperties.enableDenseViewForDates) {
        return CalendarStreakEndExpandedDate(
          calendarProperties: calendarProperties,
          pageViewElementDate: pageViewElementDate,
          pageViewDate: pageViewDate,
        );
      } else {
        return const SizedBox();
      }
    }

    /// Called when streak date doesn't have streak date just before and just after also.
    if (calendarProperties.datesForStreaks.contains(pageViewElementDate)) {
      if (calendarProperties.enableDenseViewForDates &&
          calendarProperties.enableDenseSplashForDates) {
        return CalendarStreakSingleDenseSplashDate(
          calendarProperties: calendarProperties,
          pageViewElementDate: pageViewElementDate,
          pageViewDate: pageViewDate,
        );
      }
      if (calendarProperties.enableDenseViewForDates) {
        return CalendarStreakSingleDenseDate(
          calendarProperties: calendarProperties,
          pageViewElementDate: pageViewElementDate,
          pageViewDate: pageViewDate,
        );
      }
      if (!calendarProperties.enableDenseViewForDates) {
        return CalendarStreakSingleExpandedDate(
          calendarProperties: calendarProperties,
          pageViewElementDate: pageViewElementDate,
          pageViewDate: pageViewDate,
        );
      } else {
        return const SizedBox();
      }
    } else {
      return const SizedBox();
    }
  }
}

class GetSuitableCalendarGeneralDateWidget extends StatelessWidget {
  const GetSuitableCalendarGeneralDateWidget(
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
    if (calendarProperties.enableDenseViewForDates &&
        calendarProperties.enableDenseSplashForDates) {
      return CalendarGeneralDenseSplashDate(
        calendarProperties: calendarProperties,
        pageViewElementDate: pageViewElementDate,
        pageViewDate: pageViewDate,
        eventList: eventList,
      );
    }
    if (calendarProperties.enableDenseViewForDates) {
      return CalendarGeneralDenseDate(
        calendarProperties: calendarProperties,
        pageViewElementDate: pageViewElementDate,
        pageViewDate: pageViewDate,
      );
    }
    if (!calendarProperties.enableDenseViewForDates) {
      return CalendarGeneralExpandedDate(
        calendarProperties: calendarProperties,
        pageViewElementDate: pageViewElementDate,
        pageViewDate: pageViewDate,
      );
    } else {
      return const SizedBox();
    }
  }
}
