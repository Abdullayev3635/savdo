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

// All table names for local databases
const String categoryBox = 'category_box';
const String brandBox = 'brand_box';
const String brandProductsBox = 'brand_products_box';
const String korzinaBox = 'korzina_box';
const String buyurtmaBox = 'buyurtma_box';
// const String clientDebitCreditBox = 'client_debit_credit_box';
const String currencyBox = 'currency_box';
const String priceTypeBox = 'price_type_box';
const String clientBox = 'client_box';
const String viloyatBox = 'viloyat_box';
const String regionBox = 'region_box';
const String tulovTuriBox = 'tulov_turi_box';

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
TextStyle textStylePrimaryMed16 =
    TextStyle(fontSize: 16.sp, color: primaryColor, fontFamily: 'Medium');

TextStyle textStylePrimaryReg16 =
    TextStyle(fontSize: 16.sp, color: primaryColor, fontFamily: "Regular");

TextStyle textStylePrimaryReg14 =
    TextStyle(fontSize: 14.sp, color: primaryColor, fontFamily: "Regular");

TextStyle inActiveTextStyle =
    TextStyle(fontSize: 16.sp, color: cWhiteColor, fontFamily: 'Regular');

TextStyle textStyleHintColorReg14 =
    TextStyle(fontSize: 14.sp, color: cHintTextColor, fontFamily: "Regular");

TextStyle textStylePrimaryMed14 =
    TextStyle(fontSize: 14.sp, color: primaryColor, fontFamily: "Medium");

TextStyle dateTextStyle = TextStyle(
    fontSize: 10.sp, color: const Color(0xff939EB4), fontFamily: 'Medium');

TextStyle hintStyle =
    TextStyle(fontSize: 16.sp, color: cHintTextColor, fontFamily: "Regular");

TextStyle textStyleOrangeReg18 =
    TextStyle(fontSize: 18.sp, color: cOrangeColor, fontFamily: 'Regular');

// buttons Style
ButtonStyle inActiveButtonStyle = ButtonStyle(
  elevation: MaterialStateProperty.all(0),
  fixedSize: MaterialStateProperty.all(Size(175.w, 60.h)),
  backgroundColor: MaterialStateProperty.all(cWhiteColor),
  shape: MaterialStateProperty.all(RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(10),
  )),
);

ButtonStyle activeButtonStyle = ButtonStyle(
  elevation: MaterialStateProperty.all(0),
  fixedSize: MaterialStateProperty.all(Size(175.w, 60.h)),
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

//shared keys
const String sharedCustomerId = 'customer_id';
const String sharedCurrencyValue = 'currency_value';
const String sharedCurrencyId = 'currency_id';
const String sharedPriceTypeId = 'price_type_id';
const String sharedSalesAgentId = 'sales_agent_id';
