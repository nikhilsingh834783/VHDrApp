import 'package:flutter/material.dart';

import 'calender_common_import.dart';

class CalendarWeekdayHeaderSection extends StatelessWidget {
  const CalendarWeekdayHeaderSection(
      {super.key, required this.calendarProperties});

  final CalendarProperties calendarProperties;

  @override
  Widget build(BuildContext context) {
    List<String> weekdaysSymbolsList =
        getWeekdaysSymbolsListBasedOnStartingWeekday(
            startWeekday: calendarProperties.startWeekday,
            weekdaysSymbol: calendarProperties.weekdaysSymbol);
    List<WeekdaysDecoration> weekdaysDecorationsList =
        getWeekdaysDecorationListBasedOnStartingWeekday(
            startWeekday: calendarProperties.startWeekday,
            weekdaysProperties: calendarProperties.weekdaysProperties);
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        childAspectRatio: 1,
        crossAxisCount: 7,
        mainAxisExtent: 40,
      ),
      itemCount: calendarProperties.weekdaysSymbol.toMap().length,
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      itemBuilder: (context, index) => CalendarWeekdaySymbol(
        symbol: weekdaysSymbolsList[index],
        weekdayDecoration: weekdaysDecorationsList[index],
      ),
    );
  }
}

class CalendarWeekdaySymbol extends StatelessWidget {
  const CalendarWeekdaySymbol(
      {super.key, required this.symbol, required this.weekdayDecoration});

  final String symbol;

  final WeekdaysDecoration? weekdayDecoration;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        symbol.toString(),
        style: weekdayDecoration?.weekdayTextStyle
                ?.copyWith(color: weekdayDecoration?.weekdayTextColor) ??
            const TextStyle()
                .copyWith(color: weekdayDecoration?.weekdayTextColor),
        maxLines: 1,
        overflow: TextOverflow.clip,
      ),
    );
  }
}
