import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:savdo_agnet_client/core/utils/app_constants.dart';
import 'package:savdo_agnet_client/features/product_items/presentation/widgets/product_dialog.dart';

class ProductItemsWidget extends StatefulWidget {
  final String? title,size, price, image, count, category, currencyName, brandNomi;
  final int? id, currencyId, residue;


  const ProductItemsWidget({
    required this.id,
    required this.size,
    required this.title,
    required this.price,
    required this.count,
    required this.image,
    required this.residue,
    required this.category,
    required this.brandNomi,
    required this.currencyId,
    required this.currencyName,
    Key? key,
  }) : super(key: key);

  @override
  State<ProductItemsWidget> createState() => _ProductItemsWidgetState();
}

class _ProductItemsWidgetState extends State<ProductItemsWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: 21.h,
        bottom: 12.h,
        left: 21.w,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.r),
        color: cWhiteColor,
      ),
      margin: EdgeInsets.only(bottom: 16.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 125.h,
            width: 120.w,
            margin: EdgeInsets.only(bottom: 9.h),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              image: const DecorationImage(
                opacity: 0.5,
                image: AssetImage('assets/images/gallery.png'),
              ),
              borderRadius: BorderRadius.circular(10.r),
              color: cBackgroundColor,
            ),
            child: SizedBox(
                child: widget.image != null
                    ? Image.network(widget.image ?? '')
                    : null),
          ),
          Padding(
            padding: EdgeInsets.only(left: 23.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width / 2.2,
                  child: Text(widget.title?.toUpperCase() ?? '',
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: primaryColor,
                        fontSize: 18.sp,
                        fontFamily: 'GilroyMedium',
                      )),
                ),
                Text(
                  widget.category ?? "",
                  style: TextStyle(
                      fontFamily: 'GilroyRegular',
                      fontSize: 12.sp,
                      color: primaryColor),
                ),
                SizedBox(height: 7.h),
                Text(
                  '${widget.price ?? 0} ${widget.currencyName}',
                  style: TextStyle(
                      color: const Color(0xffDC200E),
                      fontSize: 16.sp,
                      fontFamily: 'GilroyMedium'),
                ),
                SizedBox(height: 7.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(width: 65.w),
                    Container(
                      margin: EdgeInsets.only(right: 10.w),
                      child: ElevatedButton(
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return ProductItemDialog(
                                  brendNomi: widget.brandNomi ?? '',
                                  category: widget.category ?? '',
                                  name: widget.title ?? '',
                                  price: widget.price ?? '',
                                  image: widget.image,
                                  residue: widget.residue,
                                  id: widget.id!,
                                  size: widget.size,
                                  currencyName: widget.currencyName,
                                  currencyId: widget.currencyId,
                                );
                              });
                        },
                        child: Text(
                          'Savatchaga qo’shish',
                          style: TextStyle(
                              fontFamily: 'GilroyRegular',
                              fontSize: 11.sp,
                              fontWeight: FontWeight.w400,
                              color: cWhiteColor),
                        ),
                        style: ButtonStyle(
                            elevation: MaterialStateProperty.all(0),
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(7.r))),
                            backgroundColor:
                                MaterialStateProperty.all(primaryColor)),
                      ),
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
