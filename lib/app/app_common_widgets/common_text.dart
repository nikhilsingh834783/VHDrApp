import 'package:flutter/material.dart';
import 'package:venus/app/app_common_widgets/app_font_name.dart';
import 'package:venus/app/app_common_widgets/sizer_constant.dart';

import '../core/them/const_color.dart';

class AppText extends Text {
  AppText(
      {super.key,
      required String text,
      Color? fontColor,
      double? fontSize,
      int? maxLine,
      TextOverflow? overflow,
      TextAlign? textAlign,
      TextDecoration? textDecoration,
      FontWeight? fontWeight,
      String? amalfiFontFamily,
      FontStyle? amalfiFontstyle,
      double? letterSpacing,
      double? height})
      : super(text,
            softWrap: true,
            overflow: overflow,
            maxLines: maxLine,
            style: TextStyle(
                fontStyle: amalfiFontstyle ?? FontStyle.normal,
                letterSpacing: letterSpacing ?? 0,
                decoration: textDecoration ?? TextDecoration.none,
                decorationColor: ConstColor.headingTexColor,
                fontSize: fontSize ?? Sizes.px14,
                color: fontColor ?? ConstColor.blackColor,
                fontWeight: fontWeight ?? FontWeight.w400,
                height: height ?? 0.00,
                fontFamily:
                    amalfiFontFamily ?? CommonFontStyle.plusJakartaSans),
            textAlign: textAlign);
}
