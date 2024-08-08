import 'dart:math';

import 'package:flutter/material.dart';
import 'package:venus/app/app_common_widgets/common_import.dart';

Widget commonSelectorPlaceHolder(BuildContext context, String hint) {
  return Container(
    height: 47,
    constraints: BoxConstraints(
      minWidth: MediaQuery.of(context).size.width,
      minHeight: 49,
    ),
    padding: const EdgeInsets.only(left: 10, right: 20),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(25),
      border: Border.all(
        color: ConstColor.borderColor.withOpacity(0.5),
        width: 0.5,
      ),
    ),
    child: Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: AppText(
              text: hint,
              fontColor: ConstColor.hintTextColor.withOpacity(0.4),
              fontSize: Sizes.px14,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        // Spacer(),
        Transform.rotate(
          angle: pi / 2,
          child: const Icon(
            Icons.arrow_forward_ios_rounded,
            color: ConstColor.appBarTitleColor,
          ),
        ),
      ],
    ),
  );
}
