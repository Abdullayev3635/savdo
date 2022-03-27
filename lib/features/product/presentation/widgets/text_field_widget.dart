import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:savdo_agnet_client/features/korzina_screen/prezentation/pages/korzina_screen.dart';
import 'package:savdo_agnet_client/features/product_items/presentation/pages/products.dart';

import '../../../../core/utils/app_constants.dart';

class ProductTextFieldWidget extends StatefulWidget {
  const ProductTextFieldWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<ProductTextFieldWidget> createState() => _ProductTextFieldWidgetState();
}

class _ProductTextFieldWidgetState extends State<ProductTextFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.r),
        color: cWhiteColor,
        boxShadow: [textFieldShadow],
      ),
      height: 65.h,
      margin: EdgeInsets.only(top: 27.h),
      padding: EdgeInsets.fromLTRB(13.w, 2.h, 0.w, 0.h),
      child: Center(
        child: Row(
          children: [
            SvgPicture.asset(
              'assets/icons/ic_search.svg',
              width: 24.w,
              height: 24.h,
              color: primaryColor,
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: TextFormField(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>  Products.screen('Brend nomi'),
                      ));
                },
                readOnly: true,
                textAlignVertical: TextAlignVertical.top,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.only(bottom: 0),
                  hintText: "Qidirish",
                  hintStyle: TextStyle(
                      fontSize: 14.sp,
                      color: cHintTextColor,
                      fontFamily: "Regular"),
                  prefixIconConstraints: BoxConstraints(
                    maxWidth: 30.w,
                    maxHeight: 30.h,
                    minHeight: 25.h,
                    minWidth: 25.w,
                  ),
                ),
              ),
            ),
            IconButton(
              highlightColor: Colors.transparent,
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) =>  const KorzinaScreen(),));
              },
              icon: SvgPicture.asset(
                'assets/icons/ic_shopping_cart.svg',
                width: 28.w,
                height: 28.h,
                color: primaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
