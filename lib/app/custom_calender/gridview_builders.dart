import 'package:flutter/material.dart';
import 'package:venus/app/custom_calender/event_calender_model.dart';

import '../../main.dart';
import 'calender_common_import.dart';

class CalendarGridViewBuilder extends StatelessWidget {
  const CalendarGridViewBuilder(
      {super.key,
      required this.calendarProperties,
      required this.pageControllerState,
      required this.pageViewDate});

  final CalendarProperties calendarProperties;
  final PageControllerState pageControllerState;
  final DateTime pageViewDate;

  @override
  Widget build(BuildContext context) {
    if (calendarProperties.datePickerCalendarView ==
        DatePickerCalendarView.monthView) {
      return CalendarMonthViewGridViewBuilder(
        calendarProperties: calendarProperties,
        pageControllerState: pageControllerState,
        pageViewDate: pageViewDate,
      );
    }
    if (calendarProperties.datePickerCalendarView ==
        DatePickerCalendarView.weekView) {
      return CalendarWeekViewGridViewBuilder(
        calendarProperties: calendarProperties,
        pageControllerState: pageControllerState,
        pageViewDate: pageViewDate,
      );
    }
    // if (dateSelectionMode == DatePickerSelectionMode.range) {
    //   return DateRangeSelectionGridViewBuilder(
    //     pageViewMonthDate: pageViewMonthDate,
    //     pageViewElementsDates: pageViewElementsDates,
    //   );
    // }
    else {
      return const SizedBox();
    }
  }
}

class CalendarMonthViewGridViewBuilder extends StatelessWidget {
  const CalendarMonthViewGridViewBuilder(
      {super.key,
      required this.calendarProperties,
      required this.pageControllerState,
      required this.pageViewDate});

  final CalendarProperties calendarProperties;
  final PageControllerState pageControllerState;
  final DateTime pageViewDate;

  @override
  Widget build(BuildContext context) {
    final List<DateTime> pageViewElementsDates = getDatesForACalendarMonthAsUTC(
        dateTime: pageViewDate,
        startWeekday: getIntFromWeekday(calendarProperties.startWeekday));

    if (calendarProperties.dateSelectionMode ==
        DatePickerSelectionMode.disable) {
      return NoSelectionMonthViewGridViewBuilder(
        calendarProperties: calendarProperties,
        pageControllerState: pageControllerState,
        pageViewElementsDates: pageViewElementsDates,
        pageViewDate: pageViewDate,
      );
    }
    if (calendarProperties.dateSelectionMode ==
        DatePickerSelectionMode.singleOrMultiple) {
      return DateSingleMultipleSelectionMonthViewGridViewBuilder(
        calendarProperties: calendarProperties,
        pageControllerState: pageControllerState,
        pageViewElementsDates: pageViewElementsDates,
        pageViewDate: pageViewDate,
      );
    }
    // if (dateSelectionMode == DatePickerSelectionMode.range) {
    //   return DateRangeSelectionGridViewBuilder(
    //     pageViewMonthDate: pageViewMonthDate,
    //     pageViewElementsDates: pageViewElementsDates,
    //   );
    // }
    else {
      return const SizedBox();
    }
  }
}

class CalendarWeekViewGridViewBuilder extends StatelessWidget {
  const CalendarWeekViewGridViewBuilder(
      {super.key,
      required this.calendarProperties,
      required this.pageControllerState,
      required this.pageViewDate});

  final CalendarProperties calendarProperties;
  final PageControllerState pageControllerState;
  final DateTime pageViewDate;

  @override
  Widget build(BuildContext context) {
    final List<DateTime> pageViewElementsDates = getDatesForACalendarWeekAsUTC(
        dateTime: pageViewDate,
        startWeekday: getIntFromWeekday(calendarProperties.startWeekday));

    if (calendarProperties.dateSelectionMode ==
        DatePickerSelectionMode.disable) {
      return NoSelectionWeekViewGridViewBuilder(
        calendarProperties: calendarProperties,
        pageControllerState: pageControllerState,
        pageViewElementsDates: pageViewElementsDates,
        pageViewDate: pageViewDate,
      );
    }
    if (calendarProperties.dateSelectionMode ==
        DatePickerSelectionMode.singleOrMultiple) {
      return DateSingleMultipleSelectionWeekViewGridViewBuilder(
        calendarProperties: calendarProperties,
        pageControllerState: pageControllerState,
        pageViewElementsDates: pageViewElementsDates,
        pageViewDate: pageViewDate,
      );
    }
    // if (dateSelectionMode == DatePickerSelectionMode.range) {
    //   return DateRangeSelectionGridViewBuilder(
    //     pageViewMonthDate: pageViewMonthDate,
    //     pageViewElementsDates: pageViewElementsDates,
    //   );
    // }
    else {
      return const SizedBox();
    }
  }
}

// class DateRangeSelectionGridViewBuilder extends StatelessWidget {
//   const DateRangeSelectionGridViewBuilder(
//       {Key? key,
//       required this.pageViewElementsDates,
//       required this.pageViewMonthDate})
//       : super(key: key);
//
//   final List<DateTime> pageViewElementsDates;
//   final DateTime pageViewMonthDate;
//
//   @override
//   Widget build(BuildContext context) {
//     /// It is important that we create Global key locally as the latest build by PageView builder is not the current page.
//     /// So storing keys in provider based on latest build would result in saving global keys of next page in PageView leading to undesired results.
//     /// To avoid this undesired behaviour we provide this local Global key list to gesture detector functions directly.
//     /// To verify that log the date time inside PageView builder.
//     List<GlobalKey> pageViewElementsGlobalKeys = List<GlobalKey>.generate(
//         42,
//             (index) =>
//             GlobalKey(debugLabel: "${pageViewElementsDates[index]}"))
//         .toList();
//
//     final GestureDetectorStateProvider
//     readGestureDetectorStateProviderProviderValue =
//     ref.read(gestureDetectorStateProviderProvider);
//
//     return GestureDetector(
//           onPanStart: (details) {
//             readGestureDetectorStateProviderProviderValue.initialise(
//                 pageViewElementsDates: pageViewElementsDates,
//                 pageViewElementsGlobalKeys: pageViewElementsGlobalKeys);
//             readGestureDetectorStateProviderProviderValue.onPanStart(details);
//           },
//           onPanUpdate: (details) =>
//               readGestureDetectorStateProviderProviderValue
//                   .onPanUpdate(details),
//           child: GridView.builder(
//             gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//               childAspectRatio: 1,
//               crossAxisCount: 7,
//               mainAxisExtent: 40,
//             ),
//             itemCount: 42,
//             physics: const NeverScrollableScrollPhysics(),
//             shrinkWrap: true,
//             itemBuilder: (context, index) {
//               return CalendarDateWidget(
//                 key: pageViewElementsGlobalKeys[index],
//                 pageViewElementDate: pageViewElementsDates[index],
//                 pageViewDate: pageViewMonthDate,
//               );
//             },
//           ),
//         );
//   }
// }

class NoSelectionMonthViewGridViewBuilder extends StatelessWidget {
  const NoSelectionMonthViewGridViewBuilder(
      {super.key,
      required this.calendarProperties,
      required this.pageControllerState,
      required this.pageViewElementsDates,
      required this.pageViewDate});

  final CalendarProperties calendarProperties;
  final PageControllerState pageControllerState;
  final List<DateTime> pageViewElementsDates;
  final DateTime pageViewDate;

  @override
  Widget build(BuildContext context) {
    return
        // IgnorePointer(
        // child: GridView.builder(
        //   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        //     childAspectRatio: 1,
        //     crossAxisCount: 7,
        //     mainAxisExtent: 40,
        //   ),
        //   itemCount: 42,
        //   shrinkWrap: true,
        //   physics: const NeverScrollableScrollPhysics(),
        //   itemBuilder: (context, index) {
        //     return CalendarDateWidget(
        //       pageViewElementDate: pageViewElementsDates[index],
        //       pageViewMonthDate: pageViewMonthDate,
        //     );
        //   },
        // ),

        IgnorePointer(
      child: GridView.custom(
        // shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          childAspectRatio: 1,
          crossAxisCount: 7,
          mainAxisExtent: 40,
        ),

        childrenDelegate: SliverChildListDelegate(
          List.generate(
            42,
            (index) => CalendarDateWidget(
              calendarProperties: calendarProperties,
              pageViewElementDate: pageViewElementsDates[index],
              pageViewDate: pageViewDate,
            ),
          ),
          addRepaintBoundaries: false,
        ),
      ),
    );
  }
}

class DateSingleMultipleSelectionMonthViewGridViewBuilder
    extends StatefulWidget {
  const DateSingleMultipleSelectionMonthViewGridViewBuilder({
    super.key,
    required this.calendarProperties,
    required this.pageControllerState,
    required this.pageViewElementsDates,
    required this.pageViewDate,
  });

  final CalendarProperties calendarProperties;
  final PageControllerState pageControllerState;
  final List<DateTime> pageViewElementsDates;

  final DateTime pageViewDate;

  @override
  State<DateSingleMultipleSelectionMonthViewGridViewBuilder> createState() =>
      _DateSingleMultipleSelectionMonthViewGridViewBuilderState();
}

class _DateSingleMultipleSelectionMonthViewGridViewBuilderState
    extends State<DateSingleMultipleSelectionMonthViewGridViewBuilder> {
  List<EventListModel> eventCountList = [];
  @override
  void initState() {
    super.initState();
    getDate();
  }

  @override
  Widget build(BuildContext context) {
    /// It is important that we create Global key locally as the latest build by PageView builder is not the current page.
    /// So storing keys in provider based on latest build would result in saving global keys of next page in PageView leading to undesired results.
    /// To avoid this undesired behaviour we provide this local Global key list to gesture detector functions directly.
    /// To verify that log the date time inside PageView builder.
    List<GlobalKey> pageViewElementsGlobalKeys = List<GlobalKey>.generate(
            42,
            (index) =>
                GlobalKey(debugLabel: "${widget.pageViewElementsDates[index]}"))
        .toList();

    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        childAspectRatio: 1,
        crossAxisCount: 7,
        mainAxisExtent: 50,
      ),
      itemCount: 42,
      padding: EdgeInsets.zero,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return CalendarDateWidget(
          key: pageViewElementsGlobalKeys[index],
          calendarProperties: widget.calendarProperties,
          pageViewElementDate: widget.pageViewElementsDates[index],
          pageViewDate: widget.pageViewDate,
          eventList: eventCountList[index],
        );
      },
    );
  }

  getDate() {
    eventCountList = [];
    for (int i = 0; i < widget.pageViewElementsDates.length; i++) {
      // print(widget.pageViewElementsDates[i]);
      EventListModel data =
          EventListModel(date: widget.pageViewElementsDates[i]);
      eventCountList.add(data);

      // print(pageViewElementsDates[i]);
    }
    if (calenderType == 0) {
      for (int i = 0; i < eventCountList.length; i++) {
        for (int j = 0; j < appointMentsDate.length; j++) {
          if (DateTime.parse(appointMentsDate[j].selectedDate!).day ==
                  eventCountList[i].date!.day &&
              DateTime.parse(appointMentsDate[j].selectedDate!).month ==
                  eventCountList[i].date!.month &&
              DateTime.parse(appointMentsDate[j].selectedDate!).year ==
                  eventCountList[i].date!.year) {
            EventListModel data = EventListModel(
                date: eventCountList[i].date,
                eventCount: appointMentsDate[j].cnt.toString());
            eventCountList[i] = data;
          }
        }
      }
    }

    if (calenderType == 1) {
      for (int i = 0; i < eventCountList.length; i++) {
        for (int j = 0; j < procedureDates.length; j++) {
          if (DateTime.parse(procedureDates[j].selectedDate!).day ==
                  eventCountList[i].date!.day &&
              DateTime.parse(procedureDates[j].selectedDate!).month ==
                  eventCountList[i].date!.month &&
              DateTime.parse(procedureDates[j].selectedDate!).year ==
                  eventCountList[i].date!.year) {
            EventListModel data = EventListModel(
                date: eventCountList[i].date,
                eventCount: procedureDates[j].cnt.toString());
            eventCountList[i] = data;
          }
        }
      }
    }
  }
}

class NoSelectionWeekViewGridViewBuilder extends StatelessWidget {
  const NoSelectionWeekViewGridViewBuilder(
      {super.key,
      required this.calendarProperties,
      required this.pageControllerState,
      required this.pageViewElementsDates,
      required this.pageViewDate});

  final CalendarProperties calendarProperties;
  final PageControllerState pageControllerState;
  final List<DateTime> pageViewElementsDates;
  final DateTime pageViewDate;

  @override
  Widget build(BuildContext context) {
    return
        // IgnorePointer(
        // child: GridView.builder(
        //   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        //     childAspectRatio: 1,
        //     crossAxisCount: 7,
        //     mainAxisExtent: 40,
        //   ),
        //   itemCount: 42,
        //   shrinkWrap: true,
        //   physics: const NeverScrollableScrollPhysics(),
        //   itemBuilder: (context, index) {
        //     return CalendarDateWidget(
        //       pageViewElementDate: pageViewElementsDates[index],
        //       pageViewMonthDate: pageViewMonthDate,
        //     );
        //   },
        // ),

        IgnorePointer(
      child: GridView.custom(
        // shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          childAspectRatio: 1,
          crossAxisCount: 7,
          mainAxisExtent: 40,
        ),

        childrenDelegate: SliverChildListDelegate(
          List.generate(
            7,
            (index) => CalendarDateWidget(
              calendarProperties: calendarProperties,
              pageViewElementDate: pageViewElementsDates[index],
              pageViewDate: pageViewDate,
            ),
          ),
          addRepaintBoundaries: false,
        ),
      ),
    );
  }
}

class DateSingleMultipleSelectionWeekViewGridViewBuilder
    extends StatelessWidget {
  const DateSingleMultipleSelectionWeekViewGridViewBuilder(
      {super.key,
      required this.calendarProperties,
      required this.pageControllerState,
      required this.pageViewElementsDates,
      required this.pageViewDate});

  final CalendarProperties calendarProperties;
  final PageControllerState pageControllerState;
  final List<DateTime> pageViewElementsDates;
  final DateTime pageViewDate;

  @override
  Widget build(BuildContext context) {
    /// It is important that we create Global key locally as the latest build by PageView builder is not the current page.
    /// So storing keys in provider based on latest build would result in saving global keys of next page in PageView leading to undesired results.
    /// To avoid this undesired behaviour we provide this local Global key list to gesture detector functions directly.
    /// To verify that log the date time inside PageView builder.
    List<GlobalKey> pageViewElementsGlobalKeys = List<GlobalKey>.generate(7,
            (index) => GlobalKey(debugLabel: "${pageViewElementsDates[index]}"))
        .toList();

    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        childAspectRatio: 1,
        crossAxisCount: 7,
        mainAxisExtent: 40,
      ),
      itemCount: 7,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return CalendarDateWidget(
          key: pageViewElementsGlobalKeys[index],
          calendarProperties: calendarProperties,
          pageViewElementDate: pageViewElementsDates[index],
          pageViewDate: pageViewDate,
        );
      },
    );
  }
}
