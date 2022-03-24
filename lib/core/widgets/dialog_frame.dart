import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../utils/app_constants.dart';



class AllDialogSkeleton extends StatefulWidget {
  List<Widget> children;
  final String title, icon;

  AllDialogSkeleton({
    Key? key,
    required this.children,
    required this.title,
    required this.icon,
  }) : super(key: key);

  @override
  State<AllDialogSkeleton> createState() => _AllDialogSkeletonState();
}

class _AllDialogSkeletonState extends State<AllDialogSkeleton> {
  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 18.w),
        child: Dialog(
          clipBehavior: Clip.none,
          alignment: Alignment.center,
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
          insetPadding: const EdgeInsets.symmetric(vertical: 20, horizontal: 0),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration:
            BoxDecoration(borderRadius: BorderRadius.circular(20.r)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    SvgPicture.asset(widget.icon,color: primaryColor,height: 20.h,width: 20.w),
                    SizedBox(width: 8.w),
                    Expanded(
                      child: Text(
                        widget.title,
                        style: TextStyle(
                            fontSize: 16.sp,
                            fontFamily: 'Medium',
                            color: primaryColor),
                      ),
                    ),
                    InkWell(
                      borderRadius: BorderRadius.circular(22.r),
                      onTap: () => Navigator.pop(context),
                      child: SvgPicture.asset('assets/icons/ic_close_red.svg',
                          width: 22.w, height: 22.h),
                    ),
                  ],
                ),
                Column(
                  children: widget.children,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
