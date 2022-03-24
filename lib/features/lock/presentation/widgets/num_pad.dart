import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:savdo_agnet_client/features/main/presentation/pages/main_page.dart';

import '../../../../core/utils/app_constants.dart';
import '../../../../core/widgets/auth.dart';
import 'number.dart';

SizedBox numPad(TextEditingController _pinPutController, BuildContext context) {
  return SizedBox(
    height: 360.h,
    width: 330.w,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            number(_pinPutController, '1'),
            number(_pinPutController, '2'),
            number(_pinPutController, '3'),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            number(_pinPutController, '4'),
            number(_pinPutController, '5'),
            number(_pinPutController, '6'),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            number(_pinPutController, '7'),
            number(_pinPutController, '8'),
            number(_pinPutController, '9'),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              height: 41.h,
              width: cNumberLockW90.w,
              child: GestureDetector(
                  onTap: () async {
                    try {
                      final isAuthenticated = await LocalAuthApi.authenticate();
                      if (isAuthenticated) {
                        Navigator.pushReplacement(
                          context,
                          CupertinoPageRoute(
                              builder: (context) =>
                                  const MainPage()),
                        );
                      }
                    } catch (e) {
                      debugPrint(e.toString());
                    }
                  },
                  child: SvgPicture.asset(
                    'assets/icons/finger-scan.svg',
                    color: Colors.white,
                    height: 41.h,
                  )),
            ),
            number(_pinPutController, '0'),
            GestureDetector(
              onTap: () {
                if (_pinPutController.text.isNotEmpty) {
                  _pinPutController.text = _pinPutController.text
                      .substring(0, _pinPutController.text.length - 1);
                  _pinPutController.selection = TextSelection.collapsed(
                      offset: _pinPutController.text.length);
                }
              },
              behavior: HitTestBehavior.translucent,
              child: SizedBox(
                height: cNumberLockH90.h,
                width: cNumberLockW90.w,
                child: Center(
                  child: SvgPicture.asset(
                    "assets/icons/arrow-left.svg",
                    width: 41.w,
                    height: 41.h,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}
