import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:savdo_agnet_client/features/archive/data/model/archive_model.dart';
import 'package:savdo_agnet_client/features/archive_details/prezentation/pages/archive_details_screen.dart';

import '../../../../core/utils/app_constants.dart';

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
          return GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        ArchiveDetailsScreen.screen(orderId: list[index].id),
                  ));
            },
            child: Container(
              decoration: BoxDecoration(
                  color: cWhiteColor,
                  borderRadius: BorderRadius.all(Radius.circular(15.r))),
              margin: EdgeInsets.only(bottom: 16.h),
              height: 110.h,
              child: Row(
                children: [
                  Container(
                    height: 140.h,
                    width: 42.w,
                    decoration: BoxDecoration(
                        color: list[index].status == '0'
                            ? const Color(0xffDFE2E9)
                            : list[index].status == '1'
                                ? primaryColor
                                : list[index].status == '2'
                                    ? cPriceColor
                                    : const Color(0xffDFE2E9),
                        borderRadius: BorderRadius.horizontal(
                            left: Radius.circular(15.r))),
                    child: list[index].status == "0"
                        ? const Icon(Icons.watch_later, color: Colors.white)
                        : list[index].status == "1"
                            ? SvgPicture.asset('assets/icons/ic_check.svg',
                                fit: BoxFit.none)
                            : list[index].status == "2"
                                ? Padding(
                                    padding: const EdgeInsets.all(11),
                                    child: SvgPicture.asset(
                                      'assets/icons/ic_info.svg',
                                      fit: BoxFit.fitWidth,
                                      color: Colors.white,
                                    ),
                                  )
                                : const Icon(Icons.watch_later,
                                    color: Colors.white),
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
                              const Spacer(),
                              Padding(
                                padding: EdgeInsets.only(right: 7.w),
                                child: Row(
                                  children: [
                                    Text('${list[index].date}',
                                        style: dateTextStyle),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(height: 10.h),
                        Padding(
                          padding: EdgeInsets.only(left: 21.w),
                          child: Text(
                            'Buyurtma № ${list[index].id}',
                            style: TextStyle(
                                fontFamily: 'SemiBold',
                                fontSize: 20.sp,
                                color: const Color(0xff64697E)),
                          ),
                        ),
                        SizedBox(height: 10.h),
                        Padding(
                          padding: EdgeInsets.only(left: 21.w),
                          child: Row(
                            children: [
                              Text(
                                'Mijoz nomi: ',
                                style: TextStyle(
                                    fontSize: 14.sp,
                                    color: const Color(0xff84BDF2),
                                    fontFamily: 'Medium'),
                              ),
                              Text(
                                '${list[index].customerName}',
                                style: TextStyle(
                                    fontSize: 14.sp,
                                    color: const Color(0xff2F49D1),
                                    fontFamily: 'Medium'),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }
}
