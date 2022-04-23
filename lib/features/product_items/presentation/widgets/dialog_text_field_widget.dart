import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:savdo_agnet_client/features/product_items/presentation/widgets/product_dialog.dart';

import '../../../../core/utils/app_constants.dart';

class TextFieldWidgetInProductDialog extends StatelessWidget {
  const TextFieldWidgetInProductDialog({Key? key, required this.controller})
      : super(key: key);

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 50.h,
        width: 90.w,
        decoration: BoxDecoration(
          color: cTextFieldColor,
          borderRadius: BorderRadius.circular(25.r),
        ),
        margin: const EdgeInsets.symmetric(horizontal: 21),
        child: TextFormField(
          cursorColor: primaryColor,
          textAlign: TextAlign.center,
          controller: controller,
          style: textStyleR20,
          maxLines: 1,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(border: InputBorder.none),
        ));
  }
}