import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:savdo_agnet_client/core/utils/app_constants.dart';
import 'package:savdo_agnet_client/core/widgets/failure_dialog.dart';
import 'package:savdo_agnet_client/features/buyurtma/presentation/pages/buyurtma_dialog.dart';
import 'package:savdo_agnet_client/features/mijozlar/presentation/pages/mijozlar_dialog.dart';
import 'package:savdo_agnet_client/features/report_dialog/presentation/pages/report_dialog.dart';
import 'package:savdo_agnet_client/features/tulov_qilish/presentation/pages/tulov_qilish_dialog.dart';

import '../widgets/menu_items.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: cBackgroundColor,
      body: Container(
        padding: EdgeInsets.only(top: 88.h),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    AutoSizeText('Jakhongir Sagatov',
                        maxLines: 2,
                        style: TextStyle(
                            fontFamily: 'ExtraBold',
                            fontSize: 32.sp,
                            color: primaryColor)),
                    SizedBox(height: 8.h),
                    Row(
                      children: [
                         Text(
                          'Hayrli kun! ',
                          style:
                              TextStyle(color: primaryColor,fontSize: 16.sp, fontFamily: 'Medium'),
                        ),
                        Image.asset('assets/icons/ic_hand.png',width: 14.w,height: 14.h,),
                      ],
                    )
                  ],
                ),
                SvgPicture.asset('assets/icons/ic_person.svg')
              ],
            ),
            SizedBox(height: 40.h),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.r),
                color: cWhiteColor,
              ),
              margin: EdgeInsets.only(right: 22.w, left: 22.w),
              padding: EdgeInsets.symmetric(horizontal: 21.w, vertical: 23.h),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      MenuItems(
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return const BuyurtmaDialog();
                                });
                            debugPrint('1');
                          },
                          title: 'Yangi buyurtma',
                          image: 'assets/icons/ic_shopping_cart.svg'),
                      MenuItems(
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return const TulovQilishDialog();
                                });
                            debugPrint('2');
                          },
                          title: 'To’lov',
                          image: 'assets/icons/ic_dollar_circle.svg'),
                    ],
                  ),
                  SizedBox(height: 16.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      MenuItems(
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return const ReportDialog();
                                });
                            debugPrint('1');
                          },
                          title: 'Hisobot',
                          image: 'assets/icons/ic_hisobot.svg'),
                      MenuItems(
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return const FailureDialog();
                                });

                            debugPrint('2');
                          },
                          title: 'Arhiv',
                          image: 'assets/icons/ic_archive.svg'),
                    ],
                  ),
                  SizedBox(height: 16.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      MenuItems(
                          onTap: () => debugPrint('1'),
                          title: 'Foto hisobot',
                          image: 'assets/icons/ic_camera.svg'),
                      MenuItems(
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return const MijozlarDialog();
                                });
                            debugPrint('2');
                          },
                          title: 'Mijozlar',
                          image: 'assets/icons/ic_two_person.svg'),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
