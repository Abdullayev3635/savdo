import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/app_constants.dart';

class ErrorListItems extends StatelessWidget {
  const ErrorListItems({
    Key? key,
    required this.productId,
    required this.residue,
    required this.quantity,
    required this.currencyName,
    required this.price,
    required this.currencyId,
    required this.productName,
  }) : super(key: key);
  final int? productId;
  final String? productName;
  final int? quantity;
  final int? currencyId;
  final String? currencyName;
  final double? price;
  final int? residue;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 13.h),
      height: 96.h,
      margin: EdgeInsets.only(bottom: 16.h),
      decoration: BoxDecoration(
        color: cTextFieldColor,
        borderRadius: BorderRadius.circular(15.r),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                productName ?? '',
                style: TextStyle(
                    fontFamily: 'SemiBold', fontSize: 16.sp, color: cGrayColor),
              ),
              Text(
                '$price $currencyName',
                style: textStylePrimaryMed16,
              ),
              Row(
                children: [
                  Text(
                    '$quantity х $price $currencyName',
                    style: TextStyle(
                        fontSize: 14.sp,
                        color: cOrange2Color,
                        fontFamily: "Regular"),
                  ),
                  Text(
                    ' -  $residue dona qoldiq',
                    style: TextStyle(
                        fontSize: 14.sp,
                        color: const Color(0xff969696),
                        fontFamily: "Regular"),
                  ),
                ],
              )
            ],
          ),
          // IconButton(
          //     onPressed: () {
          //       showDialog(
          //               context: context,
          //               builder: (context) {
          //                 return const ProductItemDialog(
          //                   bloklarSoni:
          //                   widget.transaction?[index].bloklarSoni,
          //                   dona: widget.transaction?[index].dona,
          //                   blok: widget.transaction?[index].blok ?? 0,
          //                   category: widget.transaction?[index].category,
          //                   name: widget.transaction?[index].name,
          //                   price: widget.transaction?[index].price,
          //                   image: null,
          //                   residue: widget.transaction?[index].residue,
          //                   id: widget.transaction![index].id!,
          //                   size: widget.transaction![index].size,
          //                   currencyName:
          //                   widget.transaction![index].currencyName,
          //                   currencyId: widget.transaction![index].currencyId,
          //                 );
          //               });
          //     },
          //     icon: const Icon(Icons.edit,color: primaryColor,))
        ],//SvgPicture.asset('assets/icons/ic_trash.svg')
      ),
    );
  }
}
