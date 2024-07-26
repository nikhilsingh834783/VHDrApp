import 'package:flutter/material.dart';

import 'calender_common_import.dart';

class Calendar extends StatelessWidget {
  const Calendar({super.key, required this.calendarProperties});

  final CalendarProperties calendarProperties;

  @override
  Widget build(BuildContext context) {
    return CalendarView(calendarProperties: calendarProperties);
  }
}

class CalendarView extends StatefulWidget {
  const CalendarView({super.key, required this.calendarProperties});

  final CalendarProperties calendarProperties;

  @override
  State<CalendarView> createState() => _CalendarViewState();
}

class _CalendarViewState extends State<CalendarView> {
  late PageControllerState pageControllerState;
  bool isYearOpen = false;

  @override
  void initState() {
    pageControllerState = PageControllerState(widget.calendarProperties)
      ..init();
    super.initState();
  }

  @override
  void didUpdateWidget(covariant CalendarView oldWidget) {
    if (oldWidget.calendarProperties.initialViewMonthDateTime !=
            widget.calendarProperties.initialViewMonthDateTime ||
        oldWidget.calendarProperties.startDateOfCalendar !=
            widget.calendarProperties.startDateOfCalendar ||
        oldWidget.calendarProperties.endDateOfCalendar !=
            widget.calendarProperties.endDateOfCalendar ||
        oldWidget.calendarProperties.datePickerCalendarView !=
            widget.calendarProperties.datePickerCalendarView) {
      setState(() {
        pageControllerState = PageControllerState(widget.calendarProperties)
          ..init();
      });
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CalendarNavigatorHeaderSection(
            isYearOnen: (value) {
              if (!mounted) return;
              setState(() {
                isYearOpen = value;
              });
            },
            calendarProperties: widget.calendarProperties,
            pageControllerState: pageControllerState),
        // if (isYearOpen)
        CalendarWeekdayHeaderSection(
            calendarProperties: widget.calendarProperties),
        // Padding(
        //   padding: EdgeInsets.symmetric(horizontal: Sizes.crossLength * 0.010),
        //   child: const Divider(
        //     color: ConstColor.dividerColor,
        //   ),
        // ),
        // if (isYearOpen)
        CalendarDatesSection(
            calendarProperties: widget.calendarProperties,
            pageControllerState: pageControllerState),
      ],
    );
  }
}
