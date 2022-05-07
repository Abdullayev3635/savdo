import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:savdo_agnet_client/features/product/presentation/widgets/product_items_shimmer_widget.dart';
import 'package:savdo_agnet_client/features/product/presentation/widgets/shimmer_widget.dart';

class CategoryItemsShimmerWidget extends StatelessWidget {
  const CategoryItemsShimmerWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(right: 10.w, top: 30.h),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: SizedBox(
                    height: 90,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemCount: 6,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.only(left: 30.w),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                ShimmerWidget.circular(
                                  width: 65.w,
                                  height: 65.h,
                                  shapeBorder: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.r)), color: Colors.grey[400]!,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 15.h),
                                  child: ShimmerWidget.rectangle(
                                    height: 5.h,
                                    width: 30.w,
                                    shapeBorder: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10.r)), color: Colors.grey[400]!,
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
          // SizedBox(height: 20.h),
          // const ProductItemsShimmerWidget()
        ],
      ),
    );
  }
}
