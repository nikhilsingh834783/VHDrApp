import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../main.dart';
import '../app_common_widgets/common_import.dart';
import 'calender_common_import.dart';

class CalendarNavigatorHeaderSection extends StatelessWidget {
  const CalendarNavigatorHeaderSection(
      {super.key,
      required this.calendarProperties,
      required this.pageControllerState,
      this.isYearOnen});

  final CalendarProperties calendarProperties;
  final PageControllerState pageControllerState;
  final ValueSetter? isYearOnen;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: pageControllerState,
        builder: (BuildContext context, Widget? child) {
          final DateTime pageViewDateTime =
              pageControllerState.pageViewDateTime;
          final List<String> monthsSymbolsList = [];
          calendarProperties.monthsSymbol.toMap().forEach((key, value) {
            monthsSymbolsList.add(value);
          });

          // bool shouldShowResetButton = calendarProperties
          //             .datePickerCalendarView ==
          //         DatePickerCalendarView.weekView
          //     ? DateUtils.dateOnly(
          //             calendarProperties.initialViewMonthDateTime) !=
          //         DateUtils.dateOnly(pageViewDateTime)
          //     : DateUtils.dateOnly(calendarProperties.initialViewMonthDateTime
          //             .copyWith(day: 1)) !=
          //         DateUtils.dateOnly(pageViewDateTime.copyWith(day: 1));

          // Widget navigatorResetButtonIcon = calendarProperties.headerProperties
          //         .navigatorDecoration?.navigatorResetButtonIcon ??
          //     const Icon(
          //       Icons.calendar_today,
          //     );

          Widget navigateLeftButtonIcon = calendarProperties.headerProperties
                  .navigatorDecoration?.navigateLeftButtonIcon ??
              const Icon(
                Icons.arrow_back_ios,
                size: 12,
              );

          Widget navigateRightButtonIcon = calendarProperties.headerProperties
                  .navigatorDecoration?.navigateRightButtonIcon ??
              const Icon(
                Icons.arrow_forward_ios,
                size: 12,
              );

          Color? monthYearTextColor = calendarProperties
              .headerProperties.monthYearDecoration?.monthYearTextColor;

          TextStyle? monthYearTextStyle = calendarProperties
                  .headerProperties.monthYearDecoration?.monthYearTextStyle ??
              Theme.of(context).textTheme.titleSmall;

          bool isPreviousLock = (DateTime(
                pageViewDateTime.year,
                pageViewDateTime.month,
              ).compareTo(
                  DateTime(DateTime.now().year, DateTime.now().month))) >
              0;

          return Container(
            margin: const EdgeInsets.only(left: 10, right: 10),
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    Text(
                      "${monthsSymbolsList[pageViewDateTime.month - 1]} ${pageViewDateTime.year}",
                      // overflow: TextOverflow.ellipsis,
                      style: monthYearTextColor != null
                          ? monthYearTextStyle!
                              .copyWith(color: monthYearTextColor)
                          : monthYearTextStyle,
                    ),
                    // if (calendarProperties.isLock != null)
                    //   Padding(
                    //     padding: const EdgeInsets.only(left: 8.5),
                    //     child: calendarProperties.isLock!
                    //         ? GestureDetector(
                    //             onTap: calendarProperties.lockBtnTap,
                    //             child: SvgPicture.asset(AssetSvgs.lockicon))
                    //         : SvgPicture.asset(AssetSvgs.unlockicon),
                    //   ),
                  ],
                ),
                Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    // false
                    //     ? IconButton(
                    //       visualDensity:
                    //           VisualDensity(horizontal: -4, vertical: -4),
                    //       onPressed: () {
                    //         pageControllerState.pageController.jumpToPage(
                    //           pageControllerState.initialIndex,
                    //           // duration: kTabScrollDuration,
                    //           // curve: Curves.ease
                    //         );
                    //       },
                    //       padding: EdgeInsets.zero,
                    //       icon: navigatorResetButtonIcon,
                    //     )
                    //     : SizedBox(),
                    if (isPreviousLock || previousDateEnable)
                      GestureDetector(
                          onTap: () {
                            if (calendarProperties.isLock != null &&
                                !calendarProperties.isLock!) {
                              calendarProperties.onRightBtnTap!();
                            } else {
                              pageControllerState.pageController.previousPage(
                                  duration: kTabScrollDuration,
                                  curve: Curves.ease);
                            }
                          },
                          child: navigateLeftButtonIcon),
                    const SizedBox(
                      width: 20,
                    ),
                    GestureDetector(
                        onTap: () {
                          if (calendarProperties.isLock != null &&
                              !calendarProperties.isLock!) {
                            calendarProperties.onRightBtnTap!();
                          } else {
                            pageControllerState.pageController.nextPage(
                                duration: kTabScrollDuration,
                                curve: Curves.ease);
                          }
                        },
                        child: navigateRightButtonIcon),
                  ],
                ),
              ],
            ),
          );
        });
  }
}

Widget yearsView(int midYear) {
  return Container(
    decoration: const BoxDecoration(
      // color: ConstColor.colorF4F5F9,
      color: Colors.blue,
      borderRadius: BorderRadius.all(Radius.circular(30)),
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          width: Get.width,
          decoration: const BoxDecoration(
              // color: ConstColor.color1E3F84,
              color: ConstColor.boldBlackColor,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30), topRight: Radius.circular(30))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              // toggleBtn(false),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AppText(
                    text: Get.size.shortestSide < 600
                        ? '${(midYear - 4)} - ${(midYear + 4)}'
                        : '${(midYear - 4)} - ${(midYear + 7)}',
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    fontColor: ConstColor.whiteColor,
                  ),
                  // Icon(
                  //   Icons.arrow_drop_down,
                  //   color: ConstColor.color009846,
                  //   size: 30.w,
                  // )
                ],
              ),
              // toggleBtn(true),
            ],
          ),
        ),
        GridView.builder(
            shrinkWrap: true,
            itemCount: Get.size.shortestSide < 600 ? 9 : 12,
            physics: const BouncingScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: Get.size.shortestSide < 600 ? 3 / 2 : 2.5,
              mainAxisSpacing: 0,
              crossAxisCount: 3,
              crossAxisSpacing: 0,
            ),
            itemBuilder: (context, index) {
              int thisYear;
              if (index < 4) {
                thisYear = midYear - (4 - index);
              } else if (index > 4) {
                thisYear = midYear + (index - 4);
              } else {
                thisYear = midYear;
              }

              return ListTile(
                  onTap: () {
                    if (DateTime(thisYear).isAfter(DateTime.now())) {
                    } else {
                      // currentDateTime =
                      //  DateTime(thisYear, currentDateTime.month);
                      // _getCalendar();
                      // currentView = CalendarViews.months;
                    }

                    // update();
                  },
                  title: Center(
                      child: AppText(
                    text: thisYear.toString(),
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                    fontColor: ConstColor.blackColor,
                  )));
            }),
        const SizedBox(
          height: 20,
        )
      ],
    ),
  );
}
