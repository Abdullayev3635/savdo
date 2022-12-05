import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hive/hive.dart';
import 'package:savdo_agnet_client/core/utils/app_constants.dart';
import 'package:savdo_agnet_client/di/dependency_injection.dart';
import 'package:savdo_agnet_client/features/archive/presentation/pages/archive_page.dart';
import 'package:savdo_agnet_client/features/buyurtma/presentation/pages/buyurtma_dialog.dart';
import 'package:savdo_agnet_client/features/foto_xisobot/presentation/pages/photo_report_dialog.dart';
import 'package:savdo_agnet_client/features/korzina_screen/data/korzina_hive/tolov_hive.dart';
import 'package:savdo_agnet_client/features/mijozlar/presentation/pages/mijozlar_dialog.dart';
import 'package:savdo_agnet_client/features/profile/presentation/pages/profile_page.dart';
import 'package:savdo_agnet_client/features/report_dialog/presentation/pages/report_dialog.dart';
import 'package:savdo_agnet_client/features/tulov_qilish/presentation/pages/tulov_qilish_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/widgets/costum_toast.dart';
import '../../../korzina_screen/data/korzina_hive/korzina_hive.dart';
import '../../../product/presentation/pages/product_page.dart';
import '../../../report_dialog/presentation/pages/report_select.dart';
import '../widgets/menu_items.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  DateTime? currentBackPressTime;
  SharedPreferences sharedPreferences = di.get();
  String name = "";

  @override
  void initState() {
    name = sharedPreferences.getString("worker_name") ?? "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        DateTime now = DateTime.now();
        if (currentBackPressTime == null ||
            now.difference(currentBackPressTime!) >
                const Duration(seconds: 2)) {
          currentBackPressTime = now;
          CustomToast.showToast("Dasturdan chiqish uchun ikki marta bosing!");
          return Future.value(false);
        }
        // exit(0);
        return Future.value(true);
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: cBackgroundColor,
        body: Container(
          padding: EdgeInsets.only(top: 10.h, bottom: 30.h),
          child: Column(
            children: [
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 2,
                        child: AutoSizeText(name,
                            maxLines: 2,
                            style: TextStyle(
                                fontFamily: 'ExtraBold',
                                fontSize: 32.sp,
                                color: primaryColor)),
                      ),
                      SizedBox(height: 8.h),
                      Row(
                        children: [
                          Text('Hayrli kun! ', style: textStylePrimaryMed16),
                          Image.asset(
                            'assets/icons/ic_hand.png',
                            width: 14.w,
                            height: 14.h,
                          ),
                        ],
                      )
                    ],
                  ),
                  IconButton(
                      highlightColor: Colors.transparent,
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ProfilePage(),
                            ));
                      },
                      icon: SvgPicture.asset('assets/icons/ic_person.svg'))
                ],
              ),
              const Spacer(),
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
                              var box = Hive.box<KorzinaCard>(korzinaBox);
                              var box2 = Hive.box<TolovHive>(tolovBox);
                              if (box.isNotEmpty && box2.isNotEmpty) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ProductPage.screen(),
                                  ),
                                );
                              } else {
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return BuyurtmaDialog.screen();
                                    });
                              }
                            },
                            title: 'Yangi buyurtma',
                            image: 'assets/icons/ic_shopping_cart.svg'),
                        MenuItems(
                            onTap: () {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return TulovQilishDialog.screen();
                                  });
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
                                    return const ReportSelect();
                                  });
                            },
                            title: 'Hisobot',
                            image: 'assets/icons/ic_hisobot.svg'),
                        MenuItems(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ArchivePage.screen(),
                                ),
                              );
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
                            onTap: () {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return PhotoReportDialog.screen();
                                  });
                            },
                            title: 'Foto hisobot',
                            image: 'assets/icons/ic_camera.svg'),
                        MenuItems(
                            onTap: () {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return const MijozlarDialog();
                                  });
                            },
                            title: 'Mijozlar',
                            image: 'assets/icons/ic_two_person.svg'),
                      ],
                    ),
                  ],
                ),
              ),
              const Spacer(),
            ],
          ),
        ),
        // ),
      ),
    );
  }
}
