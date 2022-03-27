import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:savdo_agnet_client/core/utils/app_constants.dart';
import 'package:savdo_agnet_client/features/product_items/presentation/widgets/product_dialog.dart';

class ProductItemsWidget extends StatefulWidget {
  final String title, image, count, carType, brandNomi;
  final int rating, price, id;

  const ProductItemsWidget({
    required this.title,
    required this.price,
    required this.rating,
    required this.carType,
    required this.count,
    required this.image,
    required this.brandNomi,
    required this.id,
    Key? key,
  }) : super(key: key);

  @override
  State<ProductItemsWidget> createState() => _ProductItemsWidgetState();
}

class _ProductItemsWidgetState extends State<ProductItemsWidget> {
  var rating = 3.0;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: 21.h,
        bottom: 12.h,
        left: 21.w,
      ),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.r), color: cWhiteColor),
      margin: EdgeInsets.only(bottom: 16.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 125.h,
            width: 120.w,
            margin: EdgeInsets.only(bottom: 9.h),
            padding: const EdgeInsets.all(45),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.r),
              color: cBackgroundColor,
            ),
            child: SizedBox(
              child: SvgPicture.asset("assets/icons/ic_gallery.svg",
                  width: 40.w, color: const Color(0xffBFC3FA), height: 40.h),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 23.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.title.toUpperCase(),
                    style: TextStyle(
                      color: primaryColor,
                      fontSize: 18.sp,
                      fontFamily: 'GilroyMedium',
                    )),
                Text(
                  widget.carType,
                  style: TextStyle(
                      fontFamily: 'GilroyRegular',
                      fontSize: 12.sp,
                      color: primaryColor),
                ),
                SizedBox(
                  height: 7.h,
                ),
                Text(
                  '${widget.price} cўм',
                  style: TextStyle(
                      color: const Color(0xffDC200E),
                      fontSize: 16.sp,
                      fontFamily: 'GilroyMedium'),
                ),
                SizedBox(height: 7.h),
                Row(
                  children: [
                    RatingBar.builder(
                        minRating: 1,
                        itemSize: 15,
                        ignoreGestures: true,
                        initialRating: widget.rating.toDouble(),
                        itemBuilder: (context, index) => const Icon(
                              Icons.star,
                              size: 12,
                              color: primaryColor,
                            ),
                        onRatingUpdate: (rating) {
                          rating = widget.rating.toDouble();
                        }),
                  ],
                ),
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
                                  rating: widget.rating,
                                  brendNomi: widget.brandNomi,
                                  carType: widget.carType,
                                  title: widget.title,
                                  price: widget.price,
                                  image: widget.image,
                                  id: widget.id,
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
