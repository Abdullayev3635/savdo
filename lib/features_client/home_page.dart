import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:savdo_agnet_client/features_client/archive/presentation/pages/client_archive_page.dart';
import 'package:savdo_agnet_client/features_client/product/presentation/pages/product_page.dart';
import 'package:savdo_agnet_client/features_client/profile/presentation/pages/profile_page.dart';

import '../../../../core/widgets/costum_toast.dart';
import '../core/utils/app_constants.dart';
import 'korzina_screen/prezentation/pages/client_korzina_screen.dart';

// Key keys = const Key('value');

// class ClientHomePage extends StatefulWidget {
//   const ClientHomePage({Key? key}) : super(key: key);
//
//   @override
//   State<ClientHomePage> createState() => _ClientHomePageState();
// }
//
// class _ClientHomePageState extends State<ClientHomePage> {
//   @override
//   Widget build(BuildContext context) {
//     return const ClientHomePagePage(
//       currentIndex: 0,
//     );
//   }
// }

// ignore: must_be_immutable
class ClientHomePage extends StatefulWidget {
  const ClientHomePage({Key? key}) : super(key: key);

  // final int? currentIndex;

  @override
  _ClientHomePageState createState() => _ClientHomePageState();
}

class _ClientHomePageState extends State<ClientHomePage> {
  int indexPage = 0;
  DateTime? currentBackPressTime;

  @override
  void initState() {
    // indexPage = widget.currentIndex ?? 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
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
        return Future.value(true);
      },
      child: Scaffold(
        backgroundColor: cBackgroundColor,
        body: screens[indexPage],
        floatingActionButton: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            bottomNavBar(screenWidth),
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      ),
    );
  }

  Container bottomNavBar(double screenWidth) {
    return Container(
      margin: const EdgeInsets.all(10),
      height: 74.h,
      decoration: BoxDecoration(
        color: primaryColor,
        borderRadius: BorderRadius.circular(22.r),
      ),
      child: ListView.builder(
        itemCount: 4,
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: screenWidth * .05),
        itemBuilder: (context, index) => InkWell(
          onTap: () {
            setState(() => indexPage = index);
            // keys = const Key('home');
          },
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          child: Container(
            width: screenWidth * .2125,
            alignment: Alignment.center,
            child: SvgPicture.asset(
                index == indexPage
                    ? listOfActiveIcons[index]
                    : listOfInactiveIcons[index],
                width: 28.w,
                height: 28.h),
          ),
        ),
      ),
    );
  }
}

List<String> listOfInactiveIcons = [
  'assets/icons/home_inactive.svg',
  'assets/icons/shopping-cart_inactive.svg',
  'assets/icons/archive_inactive.svg',
  'assets/icons/hisobot_inactive.svg',
  'assets/icons/person_inactive.svg',
];
List<String> listOfActiveIcons = [
  'assets/icons/home_active.svg',
  'assets/icons/shopping_cart_active.svg',
  'assets/icons/archive_active.svg',
  'assets/icons/hisobot_active.svg',
  'assets/icons/person_active.svg',
];
List<Widget> screens = [
  ClientProductPage.screen(),
  const ClientKorzinaScreen(),
  const ClientArchivePage(),
  const ClientProfilePage(),
  const ClientProfilePage(),
];
