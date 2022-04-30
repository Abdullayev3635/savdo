import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:savdo_agnet_client/core/utils/app_constants.dart';

class KorzinaItemsWidget extends StatefulWidget {
  final String? name, category, currencyName, image;
  final String price, size, brandNomi, dona, blok;
  final int currencyId, id, residue;

  const KorzinaItemsWidget({
    Key? key,
    required this.name,
    required this.price,
    required this.image,
    required this.brandNomi,
    required this.id,
    required this.category,
    required this.currencyName,
    required this.size,
    required this.dona,
    required this.blok,
    required this.currencyId,
    required this.residue,
  }) : super(key: key);

  @override
  State<KorzinaItemsWidget> createState() => _KorzinaItemsWidgetState();
}

class _KorzinaItemsWidgetState extends State<KorzinaItemsWidget> {
  // var rating = 3.0;

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
            height: 124.h,
            width: 121.w,
            margin: EdgeInsets.only(bottom: 9.h),
            // padding: const EdgeInsets.all(45),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.r),
              color: cBackgroundColor,
            ),
            child: SizedBox(
                child:
                    // widget.image == null?
                    SvgPicture.asset(
              "assets/icons/ic_gallery.svg",
              fit: BoxFit.none,
              color: const Color(0xffBFC3FA),
            )
                // : Image.network(widget.image!),
                ///todo: imageni ko'rish kerak
                ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 23.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.name!.toUpperCase(),
                    style: TextStyle(
                      color: primaryColor,
                      fontSize: 18.sp,
                      fontFamily: 'GilroyMedium',
                    )),
                SizedBox(height: 4.h),
                Text(
                  widget.category ?? '',
                  style: TextStyle(
                      fontFamily: 'GilroyRegular',
                      fontSize: 12.sp,
                      color: primaryColor),
                ),
                SizedBox(height: 7.h),
                Text(
                  '${widget.price} ${widget.currencyName}',
                  style: TextStyle(
                      color: const Color(0xffDC200E),
                      fontSize: 16.sp,
                      fontFamily: 'GilroyMedium'),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
