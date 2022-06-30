import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:savdo_agnet_client/features/product/presentation/widgets/shimmer_widget.dart';

class BrandItemsShimmerWidget extends StatelessWidget {
  const BrandItemsShimmerWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        padding: EdgeInsets.only(top: 15.h),
        shrinkWrap: true,
        itemCount: 15,
        itemBuilder: (context, index) {
          return Container(
            margin: EdgeInsets.only(bottom: 16.h),
            child: ShimmerWidget.rectangle(
              shapeBorder: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.r)),
              color: Colors.white38,
              height: 130.h,
              width: double.infinity,
              child: Row(
                children: [
                  Container(
                    margin: EdgeInsets.all(13.sp),
                    child: ShimmerWidget.circular(
                      width: 90.w,
                      height: 90.h,
                      shapeBorder: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.r)),
                      color: Colors.grey[400]!,
                    ),
                  ),
                  SizedBox(width: 4.w),
                  Expanded(
                    child: Padding(
                      padding:  EdgeInsets.only(top: 20.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ShimmerWidget.circular(
                            width: 200.w,
                            height: 20.h,
                            shapeBorder: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.r)),
                            color: Colors.grey[400]!,
                          ),
                          Padding(
                            padding:  EdgeInsets.symmetric(vertical: 10.h),
                            child: ShimmerWidget.circular(
                              width: 100.w,
                              height: 10.h,
                              shapeBorder: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.r)),
                              color: Colors.grey[400]!,
                            ),
                          ),
                          ShimmerWidget.circular(
                            width: 100.w,
                            height: 10.h,
                            shapeBorder: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.r)),
                            color: Colors.grey[400]!,
                          ),
                          // Row(
                          //    crossAxisAlignment: CrossAxisAlignment.end,
                          //   mainAxisSize: MainAxisSize.min,
                          //   mainAxisAlignment: MainAxisAlignment.end,
                          //   children: [
                          //     Container(
                          //       width: 105.w,
                          //       padding:
                          //       EdgeInsets.symmetric(horizontal: 31.w, vertical: 38.h),
                          //       child: ShimmerWidget.circular(
                          //         width: 100.w,
                          //         height: 30.h,
                          //         shapeBorder: RoundedRectangleBorder(
                          //             borderRadius: BorderRadius.circular(10.r)),
                          //         color: Colors.grey[400]!,
                          //       ),
                          //     ),
                          //   ],
                          // )
                        ],
                      ),
                    ),
                  ),

                ],
              ),
            ),
          );
        });
  }
}
