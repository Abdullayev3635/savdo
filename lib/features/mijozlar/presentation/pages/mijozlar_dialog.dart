import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:savdo_agnet_client/core/utils/app_constants.dart';

import '../../../../core/widgets/dialog_frame.dart';


class MijozlarDialog extends StatefulWidget {
  const MijozlarDialog({Key? key}) : super(key: key);

  @override
  _MijozlarDialogState createState() => _MijozlarDialogState();
}

class _MijozlarDialogState extends State<MijozlarDialog> {
  @override
  Widget build(BuildContext context) {
    return AllDialogSkeleton(
      title: 'Mijozlar',
      icon: 'assets/icons/ic_two_person.svg',
      children: [
        SizedBox(height: 34.h,),
        ElevatedButton(
            onPressed: () {},
            style: buttonStyle,
            child: Text(
              'Yangi mijoz qo’shish',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: cWhiteColor, fontFamily: 'Regular', fontSize: 16.sp),
            )),
        SizedBox(height: 16.h),
        ElevatedButton(
            onPressed: () {},
            style: buttonStyle,
            child: Text(
              'Mijoz ma’lumotlarini o’zgartirish',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: cWhiteColor, fontFamily: 'Regular', fontSize: 16.sp),
            )),
      ],
    );
  }
}
