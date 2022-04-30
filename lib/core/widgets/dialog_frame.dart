import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../utils/app_constants.dart';

class AllDialogSkeleton extends StatefulWidget {
  final Widget child;
  final String title, icon;

  const AllDialogSkeleton({
    Key? key,
    required this.child,
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
        // margin: EdgeInsets.only(
        //     bottom: MediaQuery.of(context).size.height / 5),
        padding: EdgeInsets.symmetric(horizontal: 18.w),
        child: Dialog(

          clipBehavior: Clip.none,
          alignment: Alignment.center,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
          insetPadding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 0),
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
                    SvgPicture.asset(widget.icon,
                        color: primaryColor, height: 20.h, width: 20.w),
                    SizedBox(width: 8.w),
                    Expanded(
                      child: Text(widget.title, style: textStylePrimaryMed16),
                    ),
                    InkWell(
                      overlayColor:
                          MaterialStateProperty.all(Colors.transparent),
                      borderRadius: BorderRadius.circular(22.r),
                      onTap: () => Navigator.pop(context),
                      child: SvgPicture.asset('assets/icons/ic_close_red.svg',
                          width: 22.w, height: 22.h),
                    ),
                  ],
                ),
                widget.child,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
