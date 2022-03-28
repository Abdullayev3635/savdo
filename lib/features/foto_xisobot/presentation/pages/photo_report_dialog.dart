import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:savdo_agnet_client/core/utils/app_constants.dart';

import '../../../../core/widgets/dialog_frame.dart';

class PhotoReportDialog extends StatefulWidget {
  const PhotoReportDialog({Key? key}) : super(key: key);

  @override
  _PhotoReportDialogState createState() => _PhotoReportDialogState();
}

class _PhotoReportDialogState extends State<PhotoReportDialog> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height / 5),
      reverse: true,
      child: AllDialogSkeleton(
        title: 'Foto hisobot',
        icon: 'assets/icons/ic_camera.svg',
        children: [
          SizedBox(height: 23.h),
          Container(
            height: 60.h,
            margin: EdgeInsets.only(bottom: 16.h),
            padding: EdgeInsets.only(left: 18.w, right: 10.w),
            decoration: BoxDecoration(
                color: cTextFieldColor,
                borderRadius: BorderRadius.circular(10.r)),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    'Region tanlang',
                    style: TextStyle(
                        color: primaryColor,
                        fontFamily: 'Medium',
                        fontSize: 14.sp),
                  ),
                ),
                SvgPicture.asset('assets/icons/ic_dropdown.svg')
              ],
            ),
          ),
          Container(
            height: 60.h,
            margin: EdgeInsets.only(bottom: 16.h),
            padding: EdgeInsets.only(left: 18.w, right: 10.w),
            decoration: BoxDecoration(
                color: cTextFieldColor,
                borderRadius: BorderRadius.circular(10.r)),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    'Mijoz tanlang',
                    style: TextStyle(
                      color: primaryColor,
                      fontFamily: 'Medium',
                      fontSize: 14.sp,
                    ),
                  ),
                ),
                SvgPicture.asset('assets/icons/ic_dropdown.svg')
              ],
            ),
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                    onTap: () {},
                    overlayColor: MaterialStateProperty.all(Colors.transparent),
                    child: SvgPicture.asset('assets/icons/ic_add_image.svg')),
                InkWell(
                    onTap: () {},
                    overlayColor: MaterialStateProperty.all(Colors.transparent),
                    child: SvgPicture.asset('assets/icons/ic_add_image.svg')),
                InkWell(
                    onTap: () {},
                    overlayColor: MaterialStateProperty.all(Colors.transparent),
                    child: SvgPicture.asset('assets/icons/ic_add_image.svg')),
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.r),
              color: cTextFieldColor,
            ),
            height: 60.h,
            margin: EdgeInsets.only(top: 16.h),
            padding: EdgeInsets.fromLTRB(15.w, 2.h, 5.w, 0.h),
            child: Center(
              child: Row(
                children: [
                  SizedBox(width: 5.w),
                  Expanded(
                    child: TextFormField(
                      cursorColor: primaryColor,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Izoh",
                        hintStyle: TextStyle(
                            fontSize: 14.sp,
                            color: cHintTextColor,
                            fontFamily: "Regular"),
                      ),
                      style: TextStyle(
                          fontSize: 16.sp,
                          color: primaryColor,
                          fontFamily: "Regular"),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 24.h),
          ElevatedButton(
              onPressed: () {},
              style: buttonStyle,
              child: const Text(
                'Davom etish',
                textAlign: TextAlign.center,
              )),
        ],
      ),
    );
  }
}
