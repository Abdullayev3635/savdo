import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/app_constants.dart';

Widget number(TextEditingController _pinPutController, String number) {
  return GestureDetector(
    onTap: () {
      if (_pinPutController.text.length != 4 &&
          _pinPutController.text.length != 5) {
        _pinPutController.text = _pinPutController.text + number;
      }
      _pinPutController.selection =
          TextSelection.collapsed(offset: _pinPutController.text.length);
    },
    behavior: HitTestBehavior.translucent,
    excludeFromSemantics: true,
    child: SizedBox(
      height: cNumberLockH90.h,
      width: cNumberLockW90.w,
      child: Center(
        child: Text(
          number,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 38.sp,
              fontFamily: 'Medium',
              color: cWhiteColor),
        ),
      ),
    ),
  );
}
