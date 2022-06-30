import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:savdo_agnet_client/core/utils/app_constants.dart';
import 'package:savdo_agnet_client/features/lock/presentation/pages/lock_page.dart';
import 'package:savdo_agnet_client/features/password/presentation/pages/password_dialog.dart';

import '../../../../core/widgets/appBarWidget.dart';
import '../../../accounts/presentation/pages/account_page.dart';
import '../widgets/profile_items.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
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
              title: 'Jakhongir Ruzaliev',
            ),
            ProfileItemsWidgets(
              onTap: () {},
              icon: 'assets/icons/ic_firma.svg',
              title: 'Firma nomi',
            ),
            ProfileItemsWidgets(
              leading: 'assets/icons/ic_arrow_right.svg',
              icon: 'assets/icons/ic_two_person.svg',
              title: 'Akkauntlar',
              onTap: () {
                Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (context) => const AccountPage(),
                    ));
              },
            ),
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
              color: cHintTextColor,
              icon: 'assets/icons/ic_call.svg',
              title: '+998 (33) 510-95-95',
            ),
            ProfileItemsWidgets(
              onTap: () {},
              color: cHintTextColor,
              icon: 'assets/icons/ic_hudud.svg',
              title: 'Farg’ona viloyati',
            ),
            ProfileItemsWidgets(
              onTap: () {},
              color: cHintTextColor,
              icon: 'assets/icons/ic_gps.svg',
              title: 'Oltiariq tumani, Turon, 39-uy',
            ),
          ],
        ),
      ),
    );
  }
}
