import 'package:adaptive_sizer/adaptive_sizer.dart';
import 'package:flutter/material.dart';

import '../../presentation/theme/theme.dart';
import '../extensions/extensions.dart';

class SnackbarWidget extends StatelessWidget {
  const SnackbarWidget({
    super.key,
    required this.title,
    required this.message,
    this.error = false,
    this.textColor = ColorTheme.white,
  });

  final String title;
  final String message;
  final bool error;
  final Color textColor;

  Color get bgColor => error ? ColorTheme.fabRedBackground : ColorTheme.primary;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(10.0),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 2), // changes position of shadow
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
              width: 8,
              height: 60,
              decoration: BoxDecoration(
                color: bgColor,
                borderRadius: BorderRadius.all(Radius.circular(4)),
              )),
          SizedBox(width: 16),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: AppStyles.text14PxSemiBold.copyWith(color: bgColor),
              ),
              SizedBox(height: 4),
              Text(
                message,
                style: AppStyles.text14PxMedium.copyWith(color: Colors.black),
              ),
            ],
          )
        ],
      ),
    );
    // return IntrinsicHeight(
    //   child: Row(
    //     children: [
    //       Container(
    //         width: 10.w,
    //         decoration: BoxDecoration(
    //           color: bgColor,
    //           borderRadius: BorderRadius.horizontal(left: 10.circular),
    //         ),
    //       ),
    //       Expanded(
    //         child: Padding(
    //           padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 10.w),
    //           child: Column(
    //             mainAxisSize: MainAxisSize.min,
    //             crossAxisAlignment: CrossAxisAlignment.start,
    //             children: [
    //               Text(
    //                 title,
    //                 maxLines: 1,
    //                 overflow: TextOverflow.ellipsis,
    //                 style: AppStyles.text14PxMedium.copyWith(color: textColor),
    //               ),
    //               10.verticalSpace,
    //               Text(
    //                 message,
    //                 style: AppStyles.text14Px.copyWith(color: textColor),
    //                 maxLines: 2,
    //                 overflow: TextOverflow.ellipsis,
    //               ),
    //             ],
    //           ),
    //         ),
    //       ),
    //     ],
    //   ),
    // );
  }
}
