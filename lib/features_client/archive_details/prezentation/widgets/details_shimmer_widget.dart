import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:savdo_agnet_client/features/product/presentation/widgets/shimmer_widget.dart';

class DetailsShimmerWidget extends StatelessWidget {
  const DetailsShimmerWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        padding: EdgeInsets.only(top: 21.h),
        itemCount: 15,
        itemBuilder: (context, index) {
          return Container(
            padding:
                EdgeInsets.only(bottom: 12.h, right: 6.w, left: 6.w),
            child: ShimmerWidget.rectangle(
              shapeBorder: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.r)),
              color: Colors.white38,
              height: 96.h,
              width: double.infinity,
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.only(top: 15.h,bottom: 15.h, left: 21.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ShimmerWidget.circular(
                          width: 200.w,
                          height: 18.h,
                          shapeBorder: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.r)),
                          color: Colors.grey[400]!,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 10.h),
                          child: ShimmerWidget.circular(
                            width: 120.w,
                            height: 13.h,
                            shapeBorder: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.r)),
                            color: Colors.grey[400]!,
                          ),
                        ),
                        ShimmerWidget.circular(
                          width: 120.w,
                          height: 13.h,
                          shapeBorder: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.r)),
                          color: Colors.grey[400]!,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
