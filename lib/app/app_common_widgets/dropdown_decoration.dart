import 'package:flutter/material.dart';

import 'common_import.dart';

dropDownDecoration({required String hintText}) {
  return InputDecoration(
    hintText: hintText,
    hintStyle: TextStyle(
      color: ConstColor.hintTextColor,
      fontSize: Sizes.px14,
      fontWeight: FontWeight.w400,
      fontFamily: CommonFontStyle.plusJakartaSans,
    ),
    contentPadding: EdgeInsets.only(
        left: Sizes.crossLength * 0.010,
        right: Sizes.crossLength * 0.015,
        top: Sizes.crossLength * 0.012,
        bottom: Sizes.crossLength * 0.010),
    border: OutlineInputBorder(
      borderSide: const BorderSide(color: ConstColor.borderColor, width: 1),
      borderRadius: BorderRadius.all(
        Radius.circular(Sizes.crossLength * 0.010),
      ),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: ConstColor.borderColor, width: 1),
      borderRadius: BorderRadius.all(
        Radius.circular(Sizes.crossLength * 0.010),
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: ConstColor.borderColor, width: 1),
      borderRadius: BorderRadius.all(
        Radius.circular(Sizes.crossLength * 0.010),
      ),
    ),
  );
}

commonTextStyle() {
  return TextStyle(
      fontFamily: CommonFontStyle.plusJakartaSans,
      color: ConstColor.boldBlackColor,
      fontSize: Sizes.px14,
      fontWeight: FontWeight.w400);
}
