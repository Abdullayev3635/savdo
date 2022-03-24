
// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../utils/app_constants.dart';

AppBar appBarWidget(BuildContext context, String title) {
  return AppBar(
    backgroundColor: Colors.transparent,
    elevation: 0,
    toolbarHeight: 100,
    automaticallyImplyLeading: false,
    centerTitle: true,
    leading: IconButton(
      padding: const EdgeInsets.only(left: 20),
      onPressed: () {
        Navigator.pop(context);
      },
      icon: SvgPicture.asset('assets/icons/ic_arrow_back.svg'),
    ),
    title: Text(
      title,
      style:
          TextStyle(color: primaryColor, fontSize: 20.sp, fontFamily: 'Medium'),
    ),
  );
}
