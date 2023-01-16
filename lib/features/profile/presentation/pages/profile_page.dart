import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:savdo_agnet_client/core/utils/app_constants.dart';
import 'package:savdo_agnet_client/features/lock/presentation/pages/lock_page.dart';
import 'package:savdo_agnet_client/features/password/presentation/pages/password_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/widgets/appBarWidget.dart';
import '../../../../di/dependency_injection.dart';
import '../../../login/presentation/pages/login_page.dart';
import '../widgets/profile_items.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}
enum ButtonAction {
  cancel,
  agree,
}
class _ProfilePageState extends State<ProfilePage> {
  SharedPreferences sharedPreferences = di.get();
  String name = "";
  String branchName = "";
  String baseUrl = "backend.fayz-savdo.com";
  TextEditingController baseU = TextEditingController();

  @override
  void initState() {
    name = sharedPreferences.getString("worker_name") ?? "";
    branchName = sharedPreferences.getString("branch_name") ?? "";
    baseU.text =
        sharedPreferences.getString("base_url") ?? "backend.fayz-savdo.com";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    void showMaterialDialog<T>(
        {required BuildContext context, required Widget child}) {
      showDialog<T>(
        context: context,
        builder: (BuildContext context) => child,
      );
    }
    return Scaffold(
      backgroundColor: cBackgroundColor,
      appBar: appBarWidget(context, 'Shaxsiy kabinet'),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 23.w),
        child: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            SizedBox(height: 20.h),
            Container(
              width: 128.w,
              height: 128.h,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: primaryColor,
              ),
              padding: EdgeInsets.only(top: 9.h),
              child: SvgPicture.asset('assets/icons/ic_intersect.svg',
                  height: 118.h, width: 80.w, fit: BoxFit.fitHeight),
            ),
            SizedBox(height: 19.h),
            ProfileItemsWidgets(
              onTap: () {},
              icon: 'assets/icons/ic_person.svg',
              title: name,
            ),
            ProfileItemsWidgets(
              onTap: () {},
              icon: 'assets/icons/ic_firma.svg',
              title: branchName,
            ),
            // ProfileItemsWidgets(
            //   leading: 'assets/icons/ic_arrow_right.svg',
            //   icon: 'assets/icons/ic_two_person.svg',
            //   title: 'Akkauntlar',
            //   onTap: () {
            //     Navigator.push(
            //         context,
            //         CupertinoPageRoute(
            //           builder: (context) => const AccountPage(),
            //         ));
            //   },
            // ),
            ProfileItemsWidgets(
              onTap: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return PasswordEditDialog.screen();
                    }).then((value) {
                  if (value != null) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PasswordScreen.screen(),
                        ));
                  }
                  setState(() {});
                });
              },
              icon: 'assets/icons/ic_shield-security.svg',
              title: 'Parolni o’rnatish(o’zgartirish)',
            ),
            ProfileItemsWidgets(
              onTap: () {},
              color: primaryColor,
              icon: 'assets/icons/ic_call.svg',
              title: '+998 (93) 213 36 35',
            ),
            ProfileItemsWidgets(
              onTap: () {
                showMaterialDialog<ButtonAction>(
                  context: context,
                  child: AlertDialog(
                    title: const Text('Дастурдан чиқмоқчимисиз?'),
                    content: const Text(
                      'Агар дастурдан чиқсангиз, телефонингиздаги маълумотлар ўчиб кетади.',
                    ),
                    actions: <Widget>[
                      // ignore: deprecated_member_use
                      InkWell(
                        child: const Text('Бекор қилиш'),
                        onTap: () {
                          Navigator.pop(context, ButtonAction.cancel);
                        },
                      ),
                      // ignore: deprecated_member_use
                      InkWell(
                        child: const Text('Давом этиш'),
                        onTap: () {
                          logOut(context);
                        },
                      ),
                    ],
                  ),
                );
              },
              color: primaryColor,
              icon: 'assets/icons/ic_close_red.svg',
              title: 'Дастурдан чиқиш',
            ),

            // ProfileItemsWidgets(
            //   onTap: () {},
            //   color: cHintTextColor,
            //   icon: 'assets/icons/ic_hudud.svg',
            //   title: 'Farg’ona viloyati',
            // ),
            // ProfileItemsWidgets(
            //   onTap: () {},
            //   color: cHintTextColor,
            //   icon: 'assets/icons/ic_gps.svg',
            //   title: 'Oltiariq tumani, Turon, 39-uy',
            // ),
          ],
        ),
      ),
    );
  }

  void logOut(BuildContext context) {
    SharedPreferences sharedPreferences = di.get();
    sharedPreferences.clear();
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => LoginPage.screen(),
      ),
      (Route<dynamic> route) => route is ProfilePage,
    );
  }
}
