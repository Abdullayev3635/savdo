import 'package:flutter/material.dart';

// All colors
// const cFirstColor = Color(0xFF2972FE);
// const cSecondColor = Color(0xFF6499FF);
// const cBackInputColor = Color(0xFFFAFAFA);
// const cBackButtonColor = Color(0xFFF2F2F2);
// const cTextColor = Color(0xFF475E6A);
// const cBlackColor = Color(0xFF000000);
//
// const cRedColor = Color(0xFFFF3030);
// const cGrayColor = Color(0xFF949494);
// const cGrayColor2 = Color(0xFF4F4F4F);
// const cGrayColor3 = Color(0xFFE9E9E9);
// const cGrayColor4 = Color(0xFF333333);
// const cYellowColor = Color(0xFFFFC92F);
// const cBackColorIcon = Color(0xFF99BAFF);
// const cBackColor = Color(0xFFF8F8F8);

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

// All gradient
const cFirstGradient = RadialGradient(
    colors: [Colors.transparent, Color(0xffF7F7FF)],
    center: Alignment(1, 2),
    radius: 1.0);

// const cSecondGradient = LinearGradient(
//   colors: [Colors.transparent, cFirstColor],
//   begin: Alignment.centerLeft,
//   end: Alignment.centerRight,
// );

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

// lock number style
//
// const numStyle =
//     TextStyle(fontSize: 30, fontWeight: FontWeight.w400, color: cWhiteColor);
