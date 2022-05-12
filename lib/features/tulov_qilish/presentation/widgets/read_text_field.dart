import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:savdo_agnet_client/core/utils/app_constants.dart';

class ReadSumOrValWidget extends StatelessWidget {
  const ReadSumOrValWidget({
    Key? key,
    required this.tulovVal,
    required this.hintText,
  }) : super(key: key);

  final TextEditingController tulovVal;

  final String hintText;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
        color: cTextFieldColor,
      ),
      height: 60.h,
      width: MediaQuery.of(context).size.width / 2.5,
      padding: EdgeInsets.fromLTRB(15.w, 2.h, 5.w, 0.h),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(width: 5.w),
          SizedBox(
            width: 130.w,
            child: TextFormField(
              controller: tulovVal,
              readOnly: true,
              keyboardType: TextInputType.number,
              cursorColor: primaryColor,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: hintText,
                hintStyle: textStyleHintColorReg14,
              ),
              style: textStylePrimaryReg16,
            ),
          ),
        ],
      ),
    );
  }
}
