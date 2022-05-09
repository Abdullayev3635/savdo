import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:savdo_agnet_client/features/product/presentation/widgets/shimmer_widget.dart';

class KorzinaShimmerWidget extends StatelessWidget {
  const KorzinaShimmerWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        // padding: EdgeInsets.only(top: 15.h),
        shrinkWrap: true,
        itemCount: 15,
        itemBuilder: (context, index) {
          return Container(
            padding:
                EdgeInsets.only(top: 21.h, bottom: 12.h, right: 6.w, left: 6.w),
            // margin: EdgeInsets.only(bottom: 16.h),
            child: ShimmerWidget.rectangle(
              shapeBorder: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.r)),
              color: Colors.white38,
              height: 110.h,
              width: double.infinity,
              child: Row(
                children: [
                  Container(
                    // padding: EdgeInsets.only(top: 21.h, bottom: 12.h, left: 21.w),
                    margin: const EdgeInsets.all(15),
                    child: ShimmerWidget.circular(
                      height: 70.h,
                      width: 70.w,
                      shapeBorder: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.r)),
                      color: Colors.grey[400]!,
                    ),
                  ),
                  SizedBox(width: 4.w),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(top: 20.h),
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
                            padding: EdgeInsets.symmetric(vertical: 10.h),
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
