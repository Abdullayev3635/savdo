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
Color cShadowColor = const Color(0xff2F3081).withOpacity(0.04);
Color primaryColor07= primaryColor.withOpacity(0.7);


//All Shadow
BoxShadow textFieldShadow = BoxShadow(color: cShadowColor, blurRadius: 40);

// All keys for local caches
const String userData = 'user_data';

// All table names for local databases
const String categoryBox = 'category_box';
const String subCategoryBox = 'sub_category_box';
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


// buttons Style

ButtonStyle buttonStyle = ButtonStyle(
    fixedSize: MaterialStateProperty.all(Size(352.w, 65.h)),
    backgroundColor: MaterialStateProperty.all(primaryColor),
    elevation: MaterialStateProperty.all(0),
    shape: MaterialStateProperty.all(RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10))));


// lock number style
//
// const numStyle =
//     TextStyle(fontSize: 30, fontWeight: FontWeight.w400, color: cWhiteColor);
