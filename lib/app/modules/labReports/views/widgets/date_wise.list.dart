import 'package:flutter/material.dart';

import '../../../../app_common_widgets/common_import.dart';

class DateWiseList extends StatelessWidget {
  const DateWiseList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 5,
        ),
        SizedBox(
          height: getDynamicHeight(size: 0.040),
          child: Center(
            child: AppText(
              text: '12',
              fontSize: Sizes.px13,
              fontColor: ConstColor.black6B6B6B,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Divider(
          thickness: 1,
          color: ConstColor.blackColor.withOpacity(0.3),
        ),
        SizedBox(
          height: getDynamicHeight(size: 0.040),
          child: Center(
            child: AppText(
              text: '4.5',
              fontSize: Sizes.px13,
              fontColor: ConstColor.black6B6B6B,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Divider(
          thickness: 1,
          color: ConstColor.blackColor.withOpacity(0.3),
        ),
        SizedBox(
          height: getDynamicHeight(size: 0.040),
          child: Center(
            child: AppText(
              text: '40.5',
              fontSize: Sizes.px13,
              fontColor: ConstColor.black6B6B6B,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Divider(
          thickness: 1,
          color: ConstColor.blackColor.withOpacity(0.3),
        ),
        SizedBox(
          height: getDynamicHeight(size: 0.040),
          child: Center(
            child: AppText(
              text: '40.5',
              fontSize: Sizes.px13,
              fontColor: ConstColor.black6B6B6B,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Divider(
          thickness: 1,
          color: ConstColor.blackColor.withOpacity(0.3),
        ),
        SizedBox(
          height: getDynamicHeight(size: 0.040),
          child: Center(
            child: AppText(
              text: '40.5',
              fontSize: Sizes.px13,
              fontColor: ConstColor.black6B6B6B,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Divider(
          thickness: 1,
          color: ConstColor.blackColor.withOpacity(0.3),
        ),
        SizedBox(
          height: getDynamicHeight(size: 0.040),
          child: Center(
            child: AppText(
              text: '40.5',
              fontSize: Sizes.px13,
              fontColor: ConstColor.black6B6B6B,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Divider(
          thickness: 1,
          color: ConstColor.blackColor.withOpacity(0.3),
        ),
        SizedBox(
          height: getDynamicHeight(size: 0.040),
          child: Center(
            child: AppText(
              text: '40.5',
              fontSize: Sizes.px13,
              fontColor: ConstColor.black6B6B6B,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Divider(
          thickness: 1,
          color: ConstColor.blackColor.withOpacity(0.3),
        ),
        SizedBox(
          height: getDynamicHeight(size: 0.040),
          child: Center(
            child: AppText(
              text: '40.5',
              fontSize: Sizes.px13,
              fontColor: ConstColor.black6B6B6B,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Divider(
          thickness: 1,
          color: ConstColor.blackColor.withOpacity(0.3),
        ),
        // SizedBox(
        //   height: getDynamicHeight(size: 0.040),
        //   child: Center(
        //     child: AppText(
        //       text: '40.5',
        //       fontSize: Sizes.px13,
        //       fontColor: ConstColor.black6B6B6B,
        //       fontWeight: FontWeight.w500,
        //     ),
        //   ),
        // ),
        // Divider(
        //   thickness: 1,
        //   color: ConstColor.blackColor.withOpacity(0.3),
        // ),
        // SizedBox(
        //   height: getDynamicHeight(size: 0.040),
        //   child: Center(
        //     child: AppText(
        //       text: '40.5',
        //       fontSize: Sizes.px13,
        //       fontColor: ConstColor.black6B6B6B,
        //       fontWeight: FontWeight.w500,
        //     ),
        //   ),
        // ),
        const SizedBox(
          height: 5,
        )
      ],
    );
  }
}
