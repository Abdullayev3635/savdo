import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:savdo_agnet_client/features/archive/data/model/archive_model.dart';

import '../../../../core/utils/app_constants.dart';
import '../../../../core/widgets/divider_line.dart';

class ArxivItems extends StatelessWidget {
  final List<ArchiveModel> list;

  const ArxivItems({
    Key? key,
    required this.list,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 18.w),
        itemCount: list.length,
        itemBuilder: (context, index) {
          return Container(
            decoration: BoxDecoration(
                color: cWhiteColor,
                borderRadius: BorderRadius.all(Radius.circular(15.r))),
            margin: EdgeInsets.only(bottom: 16.h),
            height: 140.h,
            child: Row(
              children: [
                Container(
                  height: 140.h,
                  width: 42.w,
                  decoration: BoxDecoration(
                      color: list[index].status != 1
                          ? const Color(0xffDFE2E9)
                          : cPriceColor,
                      borderRadius:
                          BorderRadius.horizontal(left: Radius.circular(15.r))),
                  child: SvgPicture.asset('assets/icons/ic_check.svg',
                      fit: BoxFit.none),
                ),
                Container(
                  width: 335.w,
                  padding: EdgeInsets.only(bottom: 14.h, top: 13.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 21.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Buyurtma',
                              style: TextStyle(
                                  fontFamily: 'SemiBold',
                                  fontSize: 16.sp,
                                  color: const Color(0xff64697E)),
                            ),
                            Padding(
                              padding: EdgeInsets.only(right: 7.w),
                              child: Row(
                                children: [
                                  Text('$list', style: dateTextStyle),
                                  Text('     04/06/2021', style: dateTextStyle),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: 10.h),
                      Padding(
                        padding: EdgeInsets.only(left: 21.w),
                        child: Row(
                          children: [
                            Text(
                              'Mijoz nomi:',
                              style: TextStyle(
                                  fontSize: 12.sp,
                                  color: const Color(0xff84BDF2),
                                  fontFamily: 'Medium'),
                            ),
                            Text(
                              '${list[index].customerName}',
                              style: TextStyle(
                                  fontSize: 12.sp,
                                  color: const Color(0xff2F49D1),
                                  fontFamily: 'Medium'),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 21.w, bottom: 17.h),
                        child: Row(
                          children: [
                            Text(
                              'Buyurtma turi:',
                              style: TextStyle(
                                  fontSize: 12.sp,
                                  color: const Color(0xff84BDF2),
                                  fontFamily: 'Medium'),
                            ),
                            Text(
                              '${list[index].currencyName}',
                              style: TextStyle(
                                  fontSize: 12.sp,
                                  color: const Color(0xff2F49D1),
                                  fontFamily: 'Medium'),
                            ),
                          ],
                        ),
                      ),
                      MySeparator(
                        height: 0.8,
                        color: const Color(0xff939EB4).withOpacity(0.5),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 21.w, top: 10.h),
                        child: Text(
                          '${list[index].totalPrice} ${list[index].currencyName} ',
                          style: TextStyle(
                              fontSize: 20.sp,
                              color: const Color(0xff2F49D1),
                              fontFamily: 'GilroySemiBold'),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
        });
  }
}
