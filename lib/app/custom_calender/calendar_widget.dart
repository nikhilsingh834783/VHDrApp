import 'package:flutter/material.dart';

import '../app_common_widgets/common_import.dart';
import 'calender_common_import.dart';

class CustomCalendar extends StatelessWidget {
  const CustomCalendar(
      {super.key,
      this.isCalendarLock,
      required this.unAvailableDatesList,
      required this.streakDatesList,
      this.onSelectedDates,
      this.lockbtnTap,
      this.onRightBtnTap,
      this.selectedDates});
  final DateTime? selectedDates;
  final bool? isCalendarLock;
  final List<DateTime> unAvailableDatesList;
  final List<DateTime> streakDatesList;
  final void Function(List<DateTime>)? onSelectedDates;
  final void Function()? lockbtnTap;
  final void Function()? onRightBtnTap;

  @override
  Widget build(BuildContext context) {
    return CleanCalendar(
      weekdaysProperties: WeekdaysProperties(
          generalWeekdaysDecoration: WeekdaysDecoration(
              weekdayTextColor: ConstColor.buttonColor,
              weekdayTextStyle: TextStyle(
                  fontSize: Sizes.px18, // 20.spMin,
                  fontWeight: FontWeight.w700,
                  color: ConstColor.buttonColor,
                  fontFamily: CommonFontStyle.plusJakartaSans))),
      selectedDatesProperties: DatesProperties(
        datesDecoration: DatesDecoration(
            datesBorderRadius: 100,
            datesBackgroundColor: ConstColor.buttonColor.withOpacity(0.10),
            datesBorderColor: ConstColor.buttonColor,
            datesTextColor: ConstColor.boldBlackColor,
            datesTextStyle: TextStyle(
                fontSize: Sizes.px14,
                fontWeight: FontWeight.w600,
                fontFamily: CommonFontStyle.plusJakartaSans)),
      ),
      currentDateProperties: DatesProperties(
        datesDecoration: DatesDecoration(
            datesBorderRadius: 100,
            datesBackgroundColor: ConstColor.greyACACAC.withOpacity(0.1),
            datesBorderColor: ConstColor.appBarTitleColor,
            datesTextColor: ConstColor.boldBlackColor,
            datesTextStyle: TextStyle(
                fontSize: Sizes.px14,
                fontWeight: FontWeight.w600,
                fontFamily: CommonFontStyle.plusJakartaSans)),
      ),

      generalDatesProperties: DatesProperties(
        datesDecoration: DatesDecoration(
            datesBorderRadius: 1000,
            datesBackgroundColor: Colors.transparent,
            datesBorderColor: Colors.transparent,
            datesTextColor: ConstColor.boldBlackColor,
            datesTextStyle: TextStyle(
                fontSize: Sizes.px14,
                fontWeight: FontWeight.w600,
                fontFamily: CommonFontStyle.plusJakartaSans)),
      ),
      streakDatesProperties: DatesProperties(
        datesDecoration: DatesDecoration(
          datesTextStyle: TextStyle(
              fontSize: Sizes.px14,
              fontWeight: FontWeight.w600,
              fontFamily: CommonFontStyle.plusJakartaSans),
          datesBorderRadius: 50,
          datesBackgroundColor: ConstColor.appBarTitleColor.withOpacity(0.2),
          datesBorderColor: Colors.transparent,
          datesTextColor: ConstColor.boldBlackColor,
        ),
      ),
      leadingTrailingDatesProperties: DatesProperties(
        hide: true,
        datesDecoration: DatesDecoration(
            datesBorderRadius: 1000,
            datesBackgroundColor: Colors.transparent,
            datesBorderColor: Colors.transparent,
            datesTextColor: Colors.transparent,
            datesTextStyle: const TextStyle(color: Colors.transparent)),
      ),
      onRightBtnTap: onRightBtnTap,
      enableDenseViewForDates: true,
      enableDenseSplashForDates: true,
      datePickerCalendarView: DatePickerCalendarView.monthView,
      headerProperties: HeaderProperties(
        monthYearDecoration: MonthYearDecoration(
          monthYearTextStyle: TextStyle(
              fontFamily: CommonFontStyle.plusJakartaSans,
              fontSize: Sizes.px18,
              fontWeight: FontWeight.w700,
              color: ConstColor.buttonColor),
          monthYearTextColor: ConstColor.buttonColor,
        ),
        navigatorDecoration: NavigatorDecoration(
          navigateLeftButtonIcon: const Icon(Icons.arrow_back_ios,
              color: ConstColor.buttonColor, size: 20),
          navigateRightButtonIcon: const Icon(Icons.arrow_forward_ios,
              size: 20, color: ConstColor.buttonColor),
        ),
      ),
      isCalendarLock: isCalendarLock, // controller.isCalendarLock,
      datesForStreaks: streakDatesList,
      dateSelectionMode: DatePickerSelectionMode.singleOrMultiple,
      startWeekday: WeekDay.monday,
      initialViewMonthDateTime: selectedDates ?? DateTime.now(),
      selectedDates: unAvailableDatesList,
      lockBtnTap: lockbtnTap,
      onCalendarViewDate: (DateTime calendarViewDate) {},
      onSelectedDates: onSelectedDates,
    );
  }
}
