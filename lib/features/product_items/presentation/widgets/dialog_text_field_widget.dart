import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// import 'package:savdo_agnet_client/features/product_items/presentation/widgets/product_dialog.dart';

import '../../../../core/utils/app_constants.dart';
import '../../../product_items_dialog/presentation/pages/product_dialog.dart';

class TextFieldWidgetInProductDialog extends StatelessWidget {
  const TextFieldWidgetInProductDialog({Key? key, required this.controller})
      : super(key: key);

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40.h,
      width: 70.w,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: cTextFieldColor,
        borderRadius: BorderRadius.circular(20.r),
      ),
      padding: const EdgeInsets.all(3),
      margin: EdgeInsets.symmetric(horizontal: 21.w),
      child: TextFormField(
        cursorColor: primaryColor,
        textAlign: TextAlign.center,
        controller: controller,
        style: textStyleR20,
        maxLines: 1,
        keyboardType: TextInputType.number,
        decoration: const InputDecoration(border: InputBorder.none),
      ),
    );
  }
}
