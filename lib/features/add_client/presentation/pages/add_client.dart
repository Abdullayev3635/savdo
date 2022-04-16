import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/utils/app_constants.dart';

class AddClient extends StatefulWidget {
  const AddClient({Key? key}) : super(key: key);

  @override
  State<AddClient> createState() => _AddClientState();
}

class _AddClientState extends State<AddClient> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 23.w),
        color: cBackgroundColor,
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.r),
                color: cWhiteColor,
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
                          hintText: "Ism Familya",
                          hintStyle: TextStyle(
                              fontSize: 14.sp,
                              color: cHintTextColor,
                              fontFamily: "Regular"),
                        ),
                        style: textStylePrimaryReg16,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.r),
                color: cWhiteColor,
              ),
              height: 60.h,
              margin: EdgeInsets.only(top: 16.h),
              padding: EdgeInsets.fromLTRB(15.w, 2.h, 5.w, 0.h),
              child: Center(
                child: Row(
                  children: [
                    SizedBox(width: 5.w),
                    SvgPicture.asset("assets/icons/ic_call.svg"),
                    SizedBox(width: 20.w),
                    Expanded(
                      child: TextFormField(
                        cursorColor: primaryColor,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Ism Familya",
                          hintStyle: TextStyle(
                              fontSize: 14.sp,
                              color: cHintTextColor,
                              fontFamily: "Regular"),
                        ),
                        style: textStylePrimaryMed16,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Row(
              children: [
                Text("Tug'ilgan sana", style: textStylePrimaryMed16),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.r),
                    color: cWhiteColor,
                  ),
                  height: 60.h,
                  margin: EdgeInsets.only(top: 16.h),
                  padding: EdgeInsets.fromLTRB(15.w, 2.h, 5.w, 0.h),
                  child: Center(
                    child: Row(
                      children: [
                        SizedBox(width: 5.w),
                        SizedBox(
                          width: 150,
                          child: TextFormField(
                            cursorColor: primaryColor,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Kun / Oy / Yil",
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
              ],
            )
          ],
        ),
      ),
    );
  }
}

AppBar buildAppBar(BuildContext context) {
  return AppBar(
    elevation: 0,
    backgroundColor: cBackgroundColor,
    leading: IconButton(
      onPressed: () {},
      icon: SvgPicture.asset("assets/icons/ic_arrow_back.svg"),
    ),
    title: Text(
      "Mijoz qo'shish",
      style: TextStyle(
        fontFamily: "Medium",
        fontSize: 20.sp,
        fontWeight: FontWeight.w500,
        color: primaryColor,
      ),
    ),
    centerTitle: true,
  );
}
