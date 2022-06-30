import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:savdo_agnet_client/features/product/presentation/widgets/shimmer_widget.dart';

class ProductItemsShimmerWidget extends StatelessWidget {
  const ProductItemsShimmerWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        padding: EdgeInsets.only(right: 20.w, top: 15.h, left: 20.w),
        shrinkWrap: true,
        itemCount: 15,
        itemBuilder: (context, index) {
          return Container(
            margin: EdgeInsets.only(bottom: 16.h),
            child: ShimmerWidget.rectangle(
              shapeBorder: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.r)),
              color: Colors.white38,
              height: 90.h,
              width: double.infinity,
              child: Row(
                children: [
                  Container(
                    margin: EdgeInsets.all(13.sp),
                    child: ShimmerWidget.circular(
                      width: 65.w,
                      height: 65.h,
                      shapeBorder: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.r)),
                      color: Colors.grey[400]!,
                    ),
                  ),
                  SizedBox(width: 4.w),
                  Expanded(
                    child: ShimmerWidget.circular(
                      width: 200.w,
                      height: 20.h,
                      shapeBorder: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.r)),
                      color: Colors.grey[400]!,
                    ),
                  ),
                  Container(
                    width: 105.w,
                    padding:
                        EdgeInsets.symmetric(horizontal: 31.w, vertical: 38.h),
                    child: ShimmerWidget.circular(
                      width: 20.w,
                      height: 20.h,
                      shapeBorder: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.r)),
                      color: Colors.grey[400]!,
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }
}
