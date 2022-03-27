import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/utils/app_constants.dart';

// ignore: must_be_immutable
class ProfileItemsWidgets extends StatelessWidget {
  final String title, icon;
  Color? color;
  String? leading;

  ProfileItemsWidgets(
      {Key? key,
        required this.title,
        required this.icon,
        this.color,
        this.leading})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 16.h),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.r),
          color: cWhiteColor,
          boxShadow: [textFieldShadow]),
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          SvgPicture.asset(icon,
              width: 24.w, height: 24.h, color: primaryColor),
          const SizedBox(width: 18),
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                  color: color ?? primaryColor,
                  fontSize: 16.sp,
                  fontFamily: 'Regular'),
            ),
          ),
          leading != null
              ? SvgPicture.asset('assets/icons/ic_arrow_right.svg')
              : Container()
        ],
      ),
    );
  }
}
