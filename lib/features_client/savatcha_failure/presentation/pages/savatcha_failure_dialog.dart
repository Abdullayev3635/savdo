import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:savdo_agnet_client/core/utils/app_constants.dart';
import 'package:savdo_agnet_client/core/widgets/dialog_frame.dart';
import 'package:savdo_agnet_client/features/korzina_screen/data/korzina_hive/error_model.dart';

import '../widgets/error_list_items.dart';

class SavatchaFailureDialog extends StatefulWidget {
  const SavatchaFailureDialog({Key? key, required this.list}) : super(key: key);
  final List<ErrorModel> list;

  @override
  _SavatchaFailureDialogState createState() => _SavatchaFailureDialogState();
}

class _SavatchaFailureDialogState extends State<SavatchaFailureDialog> {
  @override
  Widget build(BuildContext context) {
    return AllDialogSkeleton(
        title: 'Savatcha',
        icon: 'assets/icons/ic_shopping_cart.svg',
        child: Column(
          children: [
            SizedBox(height: 31.h),
            SvgPicture.asset('assets/icons/ic_info.svg'),
            Padding(
              padding: EdgeInsets.only(
                  top: 18.h, bottom: 31.h, left: 29.w, right: 29.w),
              child: Text(
                description,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 14.sp, fontFamily: 'Regular', color: cGrayColor),
              ),
            ),
            SizedBox(
              height: 350.h,
              child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  padding: EdgeInsets.symmetric(horizontal: 3.w),
                  itemCount: widget.list.length,
                  itemBuilder: (context, index) {
                    return ErrorListItems(
                      currencyId: widget.list[index].currencyId,
                      currencyName: widget.list[index].currencyName,
                      price: widget.list[index].price,
                      productId: widget.list[index].productId,
                      productName: widget.list[index].productName,
                      quantity: widget.list[index].quantity,
                      residue: widget.list[index].residue,
                    );
                  }),
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: buttonStyle,
                child: const Text(
                  'O’zgartirish',
                  textAlign: TextAlign.center,
                )),
          ],
        ));
  }
}

String description =
    'Ushbu mahsulotlar omborda yetmaganligi sababli sotuv amalga oshirilmadi. Iltimos mavjud bo‘lmagan mahsulotlarni o‘chirib qayta buyurtma bering!';
