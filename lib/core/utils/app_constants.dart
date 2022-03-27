import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// All colors
const primaryColor = Color(0xff4447E2);
const cImageBackgroundColor = Color(0xff3F41D3);
const cBlackColor = Color(0xFF000000);
const cOrangeColor = Color(0xffFC5833);
const cIndicatorColor = Color(0xffEB5757);
const cPriceColor = Color(0xffDC200E);
const cOrange2Color = Color(0xffE7431E);
const cBackgroundColor = Color(0xffF5F5FA);
const cTextFieldColor = Color(0xffF3F4FD);
const cHintTextColor = Color(0xffA7C2D8);
const cGrayColor = Color(0xFF333333);
const cWhiteColor = Color(0xFFFFFFFF);
const cInActiveColor = Color(0xFF6E71F4);
const cImageB2Color = Color(0xFFF1F4F8);
Color cShadowColor = const Color(0xff2F3081).withOpacity(0.04);
Color primaryColor07 = primaryColor.withOpacity(0.7);

//All Shadow
BoxShadow textFieldShadow = BoxShadow(color: cShadowColor, blurRadius: 40);

// All keys for local caches
const String userData = 'user_data';

// All table names for local databases
const String catalogBox = 'catalog_box';
const String korzinaBox = 'korzina_box';
const String newHistoryBox = 'new_history_box';
const String oldHistoryBox = 'old_history_box';
const String profileBox = 'profile_box';
const String forSendBox = 'for_send_box';

// All sizes
const double cRadius10 = 10.0;
const double cRadius12 = 12.0;
const double cRadius16 = 16.0;
const double cRadius22 = 22.0;

const double cNumberLockW90 = 95.0;
const double cNumberLockH90 = 90.0;
const double cNumberLockText42 = 42.0;

// versions
const String version = "1.0.2";

// textStyles
TextStyle textStylePrimary16 =
    TextStyle(fontSize: 16.sp, color: primaryColor, fontFamily: "Regular");
TextStyle textStylePrimary14 =
    TextStyle(fontSize: 14.sp, color: primaryColor, fontFamily: "Regular");
TextStyle activeTextStyle =
    TextStyle(color: primaryColor, fontFamily: 'Regular', fontSize: 16.sp);
TextStyle inActiveTextStyle =
    TextStyle(color: cWhiteColor, fontFamily: 'Regular', fontSize: 16.sp);
TextStyle dateTextStyle = TextStyle(
    fontSize: 10.sp, color: const Color(0xff939EB4), fontFamily: 'Medium');
// buttons Style

ButtonStyle inActiveButtonStyle = ButtonStyle(
  elevation: MaterialStateProperty.all(0),
  fixedSize: MaterialStateProperty.all(Size(90.w, 50.h)),
  backgroundColor: MaterialStateProperty.all(primaryColor.withOpacity(0.1)),
  // overlayColor: MaterialStateProperty.all(primaryColor.withOpacity(0.2)),
  shape: MaterialStateProperty.all(RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(10),
  )),
);
ButtonStyle activeButtonStyle = ButtonStyle(
  fixedSize: MaterialStateProperty.all(Size(90.w, 50.h)),
  backgroundColor: MaterialStateProperty.all(primaryColor),
  shape: MaterialStateProperty.all(RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(10),
  )),
);

ButtonStyle buttonStyle = ButtonStyle(
    textStyle: MaterialStateProperty.all(
        TextStyle(color: cWhiteColor, fontFamily: 'Regular', fontSize: 16.sp)),
    fixedSize: MaterialStateProperty.all(Size(382.w, 65.h)),
    backgroundColor: MaterialStateProperty.all(primaryColor),
    elevation: MaterialStateProperty.all(0),
    shape: MaterialStateProperty.all(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))));

// BoxConstraints
BoxConstraints boxConstraintsTextField = BoxConstraints(
    maxWidth: 30.w, maxHeight: 30.h, minHeight: 25.h, minWidth: 25.w);
