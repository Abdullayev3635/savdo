import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/utils/app_constants.dart';
import '../../../korzina_screen/prezentation/pages/korzina_screen.dart';
import '../bloc/firma_cubit.dart';

class TextFieldWidget extends StatefulWidget {
  const TextFieldWidget({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final TextEditingController? controller;

  @override
  State<TextFieldWidget> createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
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
                onChanged: (value) {
                  BlocProvider.of<SearchFirmaItemsCubit>(context)
                      .searchMaxsulot(value);
                  setState(() {});
                },
                textAlignVertical: TextAlignVertical.top,
                cursorColor: primaryColor,
                controller: widget.controller,
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
                style: textStylePrimaryReg16,
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
