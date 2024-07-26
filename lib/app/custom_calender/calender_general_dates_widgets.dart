import 'package:flutter/material.dart';
import 'package:venus/app/app_common_widgets/common_import.dart';

import '../../main.dart';
import 'calender_common_import.dart';
import 'event_calender_model.dart';

class CalendarGeneralDenseDate extends StatelessWidget {
  const CalendarGeneralDenseDate(
      {super.key,
      required this.calendarProperties,
      required this.pageViewElementDate,
      required this.pageViewDate});

  final CalendarProperties calendarProperties;
  final DateTime pageViewElementDate;
  final DateTime pageViewDate;

  @override
  Widget build(BuildContext context) {
    final Function()? dateSuitableDatesOnTap = getSuitableDatesOnTap(
      calendarProperties: calendarProperties,
      pageViewElementDate: pageViewElementDate,
    );

    final DatesProperties datesProperties = getSuitableDatesProperties(
      calendarProperties: calendarProperties,
      pageViewElementDate: pageViewElementDate,
      pageViewDate: pageViewDate,
    );

    Color? datesBackgroundColor =
        datesProperties.datesDecoration?.datesBackgroundColor;
    Color? datesTextColor = datesProperties.datesDecoration?.datesTextColor;
    TextStyle? datesTextStyle = datesProperties.datesDecoration?.datesTextStyle;
    Color? datesBorderColor = datesProperties.datesDecoration?.datesBorderColor;
    double? datesBorderRadius =
        datesProperties.datesDecoration?.datesBorderRadius;
    bool hide = datesProperties.hide ?? false;
    bool disable = datesProperties.disable ?? false;

    return !hide
        ? InkResponse(
            containedInkWell: true,
            highlightShape: BoxShape.rectangle,
            customBorder: datesBorderRadius != null
                ? RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.all(Radius.circular(datesBorderRadius)),
                  )
                : null,
            splashFactory: InkRipple.splashFactory,
            onTap: disable ? null : dateSuitableDatesOnTap,
            child: Row(
              children: [
                const Expanded(
                  child: SizedBox(),
                ),
                SizedBox(
                  width: 40,
                  child: Container(
                    margin: const EdgeInsets.all(2.0),
                    child: Container(
                      //Replace here with Ink after this fix https://github.com/flutter/flutter/issues/73315
                      decoration: BoxDecoration(
                        border: datesBorderColor != null
                            ? Border.all(color: datesBorderColor, width: 1)
                            : null,
                        borderRadius: datesBorderRadius != null
                            ? BorderRadius.all(
                                Radius.circular(datesBorderRadius))
                            : null,
                        color: datesBackgroundColor,
                      ),
                      child: Center(
                        child: Text(
                          pageViewElementDate.day.toString(),
                          style: datesTextStyle != null
                              ? datesTextStyle.copyWith(
                                  color: datesTextColor,
                                )
                              : TextStyle(color: datesTextColor),
                        ),
                      ),
                    ),
                  ),
                ),
                const Expanded(
                  child: SizedBox(),
                ),
              ],
            ),
          )
        : const SizedBox();
  }
}
// class CalendarGeneralDenseDate extends StatelessWidget {
//   const CalendarGeneralDenseDate(
//       {Key? key,
//       required this.pageViewElementDate,
//       required this.pageViewMonthDate})
//       : super(key: key);
//
//   final DateTime pageViewElementDate;
//   final DateTime pageViewMonthDate;
//
//   @override
//   Widget build(BuildContext context) {
//     return Consumer(
//       builder: (BuildContext context, WidgetRef ref, Widget? child) {
//         final DatesProperties dateSuitablePropertiesProviderValue = ref.watch(
//             dateSuitablePropertiesProvider(IndividualDateElementProperties(
//                     pageViewElementDate: pageViewElementDate,
//                     pageViewMonthDate: pageViewMonthDate))
//                 .select((value) => value));
//
//         DatesProperties datesProperties = dateSuitablePropertiesProviderValue;
//
//         Color? datesBackgroundColor =
//             datesProperties.decorationProperties?.datesBackgroundColor;
//         Color? datesTextColor =
//             datesProperties.decorationProperties?.datesTextColor;
//         TextStyle? datesTextStyle =
//             datesProperties.decorationProperties?.datesTextStyle;
//         Color? datesBorderColor =
//             datesProperties.decorationProperties?.datesBorderColor;
//         double? datesBorderRadius =
//             datesProperties.decorationProperties?.datesBorderRadius;
//
//         return OutlinedButton(
//           style: OutlinedButton.styleFrom(
//             padding: EdgeInsets.zero,
//             foregroundColor: Theme.of(context).colorScheme.onSurface,
//             side: BorderSide.none,
//             shape: datesBorderRadius != null
//                 ? RoundedRectangleBorder(
//                     borderRadius:
//                         BorderRadius.all(Radius.circular(datesBorderRadius)),
//                   )
//                 : null,
//           ).copyWith(elevation: ButtonStyleButton.allOrNull(0.0)),
//           onPressed: pageViewElementDate.month == pageViewMonthDate.month
//               ? () {
//                   // widget.onSelectedDate.call(widget.date);
//                 }
//               : null,
//           child: Row(
//             children: [
//               const Expanded(
//                 child: SizedBox(),
//               ),
//               SizedBox(
//                 width: 40,
//                 child: Container(
//                   margin: const EdgeInsets.all(4.0),
//                   child: Ink(
//                     decoration: BoxDecoration(
//                       border: datesBorderColor != null
//                           ? Border.all(color: datesBorderColor, width: 1)
//                           : null,
//                       borderRadius: datesBorderRadius != null
//                           ? BorderRadius.all(Radius.circular(datesBorderRadius))
//                           : null,
//                       color: datesBackgroundColor,
//                     ),
//                     child: Center(
//                       child: Text(
//                         pageViewElementDate.day.toString(),
//                         style: datesTextStyle != null
//                             ? datesTextStyle.copyWith(
//                                 color: datesTextColor,
//                               )
//                             : TextStyle(color: datesTextColor),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//               const Expanded(
//                 child: SizedBox(),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
// }

class CalendarGeneralDenseSplashDate extends StatelessWidget {
  const CalendarGeneralDenseSplashDate(
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
    final GlobalKey widgetKey = GlobalKey();

    final Function()? dateSuitableDatesOnTap = getSuitableDatesOnTap(
      calendarProperties: calendarProperties,
      pageViewElementDate: pageViewElementDate,
    );

    final DatesProperties datesProperties = getSuitableDatesProperties(
      calendarProperties: calendarProperties,
      pageViewElementDate: pageViewElementDate,
      pageViewDate: pageViewDate,
    );

    Color? datesBackgroundColor =
        datesProperties.datesDecoration?.datesBackgroundColor;
    Color? datesTextColor = datesProperties.datesDecoration?.datesTextColor;
    TextStyle? datesTextStyle = datesProperties.datesDecoration?.datesTextStyle;
    Color? datesBorderColor = datesProperties.datesDecoration?.datesBorderColor;
    double? datesBorderRadius =
        datesProperties.datesDecoration?.datesBorderRadius;
    bool hide = datesProperties.hide ?? false;
    bool disable = datesProperties.disable ?? false;
    bool isPrevious = (DateTime(
          pageViewElementDate.year,
          pageViewElementDate.month,
          pageViewElementDate.day,
        ).compareTo(DateTime(
            DateTime.now().year, DateTime.now().month, DateTime.now().day)) ==
        -1);

    return !hide
        ? InkResponse(
            // clipBehavior: Clip.antiAlias,
            // customBorder: const RoundedRectangleBorder(side: BorderSide.none),
            // borderRadius: datesBorderRadius != null
            //     ? BorderRadius.all(Radius.circular(datesBorderRadius))
            //     : null,
            focusColor: Colors.transparent,
            hoverColor: Colors.transparent,
            highlightColor: Colors.transparent,
            overlayColor: const WidgetStatePropertyAll(Colors.transparent),
            splashColor: Colors.transparent,
            splashFactory: NoSplash.splashFactory,
            enableFeedback: false,
            onTap: disable
                ? null
                : isPrevious
                    ? () {
                        Offset widgetCenterOffset =
                            getWidgetCenterOffsetInfo(widgetKey);
                        simulateTapOnAnOffset(widgetCenterOffset);
                      }
                    : previousDateEnable
                        ? () {
                            Offset widgetCenterOffset =
                                getWidgetCenterOffsetInfo(widgetKey);
                            simulateTapOnAnOffset(widgetCenterOffset);
                          }
                        : null,
            child: Row(
              children: [
                const Expanded(
                  child: SizedBox(),
                ),
                InkResponse(
                  containedInkWell: true,
                  // highlightColor: Colors.blue,
                  highlightShape: BoxShape.rectangle,
                  customBorder: datesBorderRadius != null
                      ? RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                              Radius.circular(datesBorderRadius)),
                        )
                      : null,

                  // recurssion
                  splashFactory: InkRipple.splashFactory,
                  onTap: disable
                      ? null
                      : !isPrevious
                          ? () {
                              if (!isPrevious) {
                                dateSuitableDatesOnTap!();
                              } else {}
                            }
                          : () {
                              if (previousDateEnable) {
                                dateSuitableDatesOnTap!();
                              }
                            },
                  // for diable ontap previous date
                  child: SizedBox(
                    width: 45,
                    child: Column(
                      children: [
                        SizedBox(
                          width: 50,
                          child: Container(
                            //Replace here with Ink after this fix https://github.com/flutter/flutter/issues/73315
                            decoration: BoxDecoration(
                              border: datesBorderColor != null
                                  ? Border.all(
                                      color: datesBorderColor, width: 1)
                                  : null,
                              // borderRadius: datesBorderRadius != null
                              //     ? BorderRadius.all(
                              //         Radius.circular(datesBorderRadius))
                              //     : null,
                              shape: BoxShape.circle,
                              color: datesBackgroundColor,
                            ),

                            // for changing color for text of calendar
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: Text(
                                  key: widgetKey,
                                  eventList != null
                                      ? eventList!.date!.day.toString()
                                      : '',
                                  overflow: TextOverflow.ellipsis,
                                  style: datesTextStyle != null
                                      ? datesTextStyle.copyWith(
                                          color: isPrevious
                                              ? previousDateEnable
                                                  ? datesTextColor
                                                  : ConstColor.hintTextColor
                                              : datesTextColor,
                                        )
                                      : TextStyle(
                                          color: isPrevious
                                              ? previousDateEnable
                                                  ? datesTextColor
                                                  : ConstColor.hintTextColor
                                              : datesTextColor),
                                ),
                              ),
                            ),
                          ),
                        ),
                        eventList != null && eventList!.eventCount != null
                            ? Text(
                                '(${eventList!.eventCount})',
                                style: TextStyle(
                                    fontFamily: CommonFontStyle.plusJakartaSans,
                                    fontSize: Sizes.px12,
                                    fontWeight: FontWeight.w600,
                                    color: ConstColor.buttonColor),
                              )
                            : const SizedBox()
                      ],
                    ),
                  ),
                ),
                const Expanded(
                  child: SizedBox(),
                ),
              ],
            ),
          )
        : const SizedBox();
  }
}

// class CalendarGeneralDenseSplashDate extends StatelessWidget {
//   const CalendarGeneralDenseSplashDate(
//       {Key? key,
//       required this.pageViewElementDate,
//       required this.pageViewMonthDate})
//       : super(key: key);
//
//   final DateTime pageViewElementDate;
//   final DateTime pageViewMonthDate;
//
//   @override
//   Widget build(BuildContext context) {
//     return Consumer(
//       builder: (BuildContext context, WidgetRef ref, Widget? child) {
//         final DatesProperties dateSuitablePropertiesProviderValue = ref.watch(
//             dateSuitablePropertiesProvider(IndividualDateElementProperties(
//                     pageViewElementDate: pageViewElementDate,
//                     pageViewMonthDate: pageViewMonthDate))
//                 .select((value) => value));
//
//         DatesProperties datesProperties = dateSuitablePropertiesProviderValue;
//
//         Color? datesBackgroundColor =
//             datesProperties.decorationProperties?.datesBackgroundColor;
//         Color? datesTextColor =
//             datesProperties.decorationProperties?.datesTextColor;
//         TextStyle? datesTextStyle =
//             datesProperties.decorationProperties?.datesTextStyle;
//         Color? datesBorderColor =
//             datesProperties.decorationProperties?.datesBorderColor;
//         double? datesBorderRadius =
//             datesProperties.decorationProperties?.datesBorderRadius;
//
//         return InkWell(
//           // clipBehavior: Clip.antiAlias,
//           // customBorder: const RoundedRectangleBorder(side: BorderSide.none),
//           // borderRadius: datesBorderRadius != null
//           //     ? BorderRadius.all(Radius.circular(datesBorderRadius))
//           //     : null,
//           // focusColor: Colors.transparent,
//           // hoverColor: Colors.transparent,
//           // highlightColor: Colors.transparent,
//           // overlayColor: MaterialStateProperty.all(Colors.transparent),
//           splashColor: Colors.transparent,
//           splashFactory: NoSplash.splashFactory,
//           enableFeedback: false,
//           onTap: pageViewElementDate.month == pageViewMonthDate.month
//               ? () {
//                   // Offset widgetCenterOffset =
//                   //     getWidgetCenterOffsetInfo(widgetKey);
//                   // simulateTapOnAnOffset(widgetCenterOffset);
//                 }
//               : null,
//           child: Row(
//             children: [
//               const Expanded(
//                 child: SizedBox(),
//               ),
//               OutlinedButton(
//                 style: OutlinedButton.styleFrom(
//                   minimumSize: Size.zero,
//                   // splashFactory: NoSplash.splashFactory,
//                   padding: EdgeInsets.zero,
//                   foregroundColor: Theme.of(context).colorScheme.onSurface,
//                   // backgroundColor: Theme.of(context).colorScheme.primary,
//                   tapTargetSize: MaterialTapTargetSize.shrinkWrap,
//                   side: BorderSide.none,
//                   // side: BorderSide(width: 1, color: Theme.of(context).dividerColor),
//                   shape: datesBorderRadius != null
//                       ? RoundedRectangleBorder(
//                           borderRadius: BorderRadius.all(
//                               Radius.circular(datesBorderRadius)),
//                         )
//                       : null,
//                 ).copyWith(elevation: ButtonStyleButton.allOrNull(0.0)),
//                 onPressed: pageViewElementDate.month == pageViewMonthDate.month
//                     ? () {
//                         // widget.onSelectedDate.call(widget.date);
//                       }
//                     : null,
//                 child: SizedBox(
//                   width: 40,
//                   child: Container(
//                     margin: const EdgeInsets.all(4.0),
//                     child: Ink(
//                       decoration: BoxDecoration(
//                         border: datesBorderColor != null
//                             ? Border.all(color: datesBorderColor, width: 1)
//                             : null,
//                         borderRadius: datesBorderRadius != null
//                             ? BorderRadius.all(
//                                 Radius.circular(datesBorderRadius))
//                             : null,
//                         color: datesBackgroundColor,
//                       ),
//                       child: Center(
//                         child: Text(
//                           // key: widgetKey,
//                           pageViewElementDate.day.toString(),
//                           style: datesTextStyle != null
//                               ? datesTextStyle.copyWith(
//                                   color: datesTextColor,
//                                 )
//                               : TextStyle(color: datesTextColor),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//               const Expanded(
//                 child: SizedBox(),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
// }

class CalendarGeneralExpandedDate extends StatelessWidget {
  const CalendarGeneralExpandedDate(
      {super.key,
      required this.calendarProperties,
      required this.pageViewElementDate,
      required this.pageViewDate});

  final CalendarProperties calendarProperties;
  final DateTime pageViewElementDate;
  final DateTime pageViewDate;

  @override
  Widget build(BuildContext context) {
    final Function()? dateSuitableDatesOnTap = getSuitableDatesOnTap(
      calendarProperties: calendarProperties,
      pageViewElementDate: pageViewElementDate,
    );

    final DatesProperties datesProperties = getSuitableDatesProperties(
      calendarProperties: calendarProperties,
      pageViewElementDate: pageViewElementDate,
      pageViewDate: pageViewDate,
    );

    Color? datesBackgroundColor =
        datesProperties.datesDecoration?.datesBackgroundColor;
    Color? datesTextColor = datesProperties.datesDecoration?.datesTextColor;
    TextStyle? datesTextStyle = datesProperties.datesDecoration?.datesTextStyle;
    Color? datesBorderColor = datesProperties.datesDecoration?.datesBorderColor;
    double? datesBorderRadius =
        datesProperties.datesDecoration?.datesBorderRadius;
    bool hide = datesProperties.hide ?? false;
    bool disable = datesProperties.disable ?? false;

    return !hide
        ? InkResponse(
            containedInkWell: true,
            highlightShape: BoxShape.rectangle,
            customBorder: datesBorderRadius != null
                ? RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.all(Radius.circular(datesBorderRadius)),
                  )
                : null,
            splashFactory: InkRipple.splashFactory,
            onTap: disable ? null : dateSuitableDatesOnTap,
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Container(
                //Replace here with Ink after this fix https://github.com/flutter/flutter/issues/73315
                decoration: BoxDecoration(
                  border: datesBorderColor != null
                      ? Border.all(color: datesBorderColor, width: 1)
                      : null,
                  borderRadius: datesBorderRadius != null
                      ? BorderRadius.all(Radius.circular(datesBorderRadius))
                      : null,
                  color: datesBackgroundColor,
                ),
                child: Center(
                  child: Text(
                    pageViewElementDate.day.toString(),
                    style: datesTextStyle != null
                        ? datesTextStyle.copyWith(
                            color: datesTextColor,
                          )
                        : TextStyle(color: datesTextColor),
                  ),
                ),
              ),
            ),
          )
        : const SizedBox();
  }
}

// class CalendarGeneralExpandedDate extends StatelessWidget {
//   const CalendarGeneralExpandedDate(
//       {Key? key,
//       required this.pageViewElementDate,
//       required this.pageViewMonthDate})
//       : super(key: key);
//
//   final DateTime pageViewElementDate;
//   final DateTime pageViewMonthDate;
//
//   @override
//   Widget build(BuildContext context) {
//     return Consumer(
//       builder: (BuildContext context, WidgetRef ref, Widget? child) {
//         final DatesProperties dateSuitablePropertiesProviderValue = ref.watch(
//             dateSuitablePropertiesProvider(IndividualDateElementProperties(
//                     pageViewElementDate: pageViewElementDate,
//                     pageViewMonthDate: pageViewMonthDate))
//                 .select((value) => value));
//
//         DatesProperties datesProperties = dateSuitablePropertiesProviderValue;
//
//         Color? datesBackgroundColor =
//             datesProperties.decorationProperties?.datesBackgroundColor;
//         Color? datesTextColor =
//             datesProperties.decorationProperties?.datesTextColor;
//         TextStyle? datesTextStyle =
//             datesProperties.decorationProperties?.datesTextStyle;
//         Color? datesBorderColor =
//             datesProperties.decorationProperties?.datesBorderColor;
//         double? datesBorderRadius =
//             datesProperties.decorationProperties?.datesBorderRadius;
//
//         return OutlinedButton(
//           // clipBehavior: Clip.antiAlias,
//           style: OutlinedButton.styleFrom(
//             padding: EdgeInsets.zero,
//             foregroundColor: Theme.of(context).colorScheme.onSurface,
//             // backgroundColor: Theme.of(context).colorScheme.primary,
//             // tapTargetSize: MaterialTapTargetSize.shrinkWrap,
//             side: BorderSide.none,
//             // side: BorderSide(width: 1, color: Theme.of(context).dividerColor),
//             shape: datesBorderRadius != null
//                 ? RoundedRectangleBorder(
//                     borderRadius:
//                         BorderRadius.all(Radius.circular(datesBorderRadius)),
//                   )
//                 : null,
//           ).copyWith(elevation: ButtonStyleButton.allOrNull(0.0)),
//           onPressed: pageViewElementDate.month == pageViewMonthDate.month
//               ? () {
//                   // widget.onSelectedDate.call(widget.date);
//                 }
//               : null,
//           child: Padding(
//             padding: const EdgeInsets.all(4.0),
//             child: Ink(
//               decoration: BoxDecoration(
//                 border: datesBorderColor != null
//                     ? Border.all(color: datesBorderColor, width: 1)
//                     : null,
//                 borderRadius: datesBorderRadius != null
//                     ? BorderRadius.all(Radius.circular(datesBorderRadius))
//                     : null,
//                 color: datesBackgroundColor,
//               ),
//               child: Center(
//                 child: Text(
//                   pageViewElementDate.day.toString(),
//                   style: datesTextStyle != null
//                       ? datesTextStyle.copyWith(
//                           color: datesTextColor,
//                         )
//                       : TextStyle(color: datesTextColor),
//                 ),
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
