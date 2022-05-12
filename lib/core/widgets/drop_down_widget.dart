import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:savdo_agnet_client/core/utils/app_constants.dart';

// ignore: must_be_immutable
class DropDownWidget extends StatefulWidget {
  DropDownWidget({
    Key? key,
    required this.onTap,
    required this.initialName,
  }) : super(key: key);
  String initialName;
  final VoidCallback onTap;

  @override
  State<DropDownWidget> createState() => _DropDownWidgetState();
}

class _DropDownWidgetState extends State<DropDownWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        height: 60.h,
        padding: EdgeInsets.only(left: 18.w, right: 10.w),
        decoration: BoxDecoration(
            color: cTextFieldColor, borderRadius: BorderRadius.circular(10.r)),
        child: Row(
          children: [
            Expanded(
              child: Text(
                widget.initialName,
                style: textStylePrimaryMed14
              ),
            ),
            SvgPicture.asset('assets/icons/ic_dropdown.svg')
          ],
        ),
      ),
    );
  }
}
