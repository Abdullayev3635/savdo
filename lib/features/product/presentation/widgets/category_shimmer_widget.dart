import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:savdo_agnet_client/features/product/presentation/widgets/shimmer_widget.dart';

class CategoryItemsShimmerWidget extends StatelessWidget {
  const CategoryItemsShimmerWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(right: 21.w,top: 18.h,left: 21.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ShimmerWidget.rectangle(
                  width: 64.w,
                  height: 12.w,
                  color: Colors.grey[400]!,
                  shapeBorder: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.r)),
                ),
                ShimmerWidget.rectangle(
                  width: 64.w,
                  height: 10.w,
                  color: Colors.grey[400]!,
                  shapeBorder: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.r)),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: 1.w,top: 12.h),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: SizedBox(
                    height: 90.h,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemCount: 6,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.only(left: 20.w),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                ShimmerWidget.circular(
                                  width: 66.w,
                                  height: 66.h,
                                  shapeBorder: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(10.r)),
                                  color: Colors.grey[400]!,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 16.h),
                                  child: ShimmerWidget.rectangle(
                                    height: 5.h,
                                    width: 30.w,
                                    shapeBorder: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.r)),
                                    color: Colors.grey[400]!,
                                  ),
                                )
                              ],
                            ),
                          );
                        }),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20.h),
          // const ProductItemsShimmerWidget()
        ],
      ),
    );
  }
}
