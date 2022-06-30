import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:savdo_agnet_client/features/product/presentation/widgets/shimmer_widget.dart';

class ArchiveShimmerWidget extends StatelessWidget {
  const ArchiveShimmerWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: 15,
        itemBuilder: (context, index) {
          return Container(
            padding: EdgeInsets.only(bottom: 16.h, right: 6.w, left: 6.w),
            child: ShimmerWidget.rectangle(
              shapeBorder: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.r)),
              color: Colors.white38,
              height: 140.h,
              width: double.infinity,
              child: Row(
                children: [
                  ShimmerWidget.circular(
                    shapeBorder: RoundedRectangleBorder(
                        borderRadius: BorderRadius.horizontal(
                            left: Radius.circular(15.r))),
                    color: Colors.grey[400]!,
                    height: 140.h,
                    width: 42.w,
                  ),
                  SizedBox(width: 21.w),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(top: 15.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ShimmerWidget.circular(
                                width: 84.w,
                                height: 20.h,
                                shapeBorder: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.r)),
                                color: Colors.grey[400]!,
                              ),
                              Padding(
                                padding: EdgeInsets.only(right: 7.w),
                                child: ShimmerWidget.circular(
                                  width: 100.w,
                                  height: 12.h,
                                  shapeBorder: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(10.r)),
                                  color: Colors.grey[400]!,
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 10.h),
                            child: ShimmerWidget.circular(
                              width: 138.w,
                              height: 10.h,
                              shapeBorder: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.r)),
                              color: Colors.grey[400]!,
                            ),
                          ),
                          ShimmerWidget.circular(
                            width: 138.w,
                            height: 10.h,
                            shapeBorder: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.r)),
                            color: Colors.grey[400]!,
                          ),
                          SizedBox(
                            height: 24.h,
                          ),
                          ShimmerWidget.circular(
                            width: 139.w,
                            height: 24.h,
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
