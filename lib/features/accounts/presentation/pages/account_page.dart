import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:savdo_agnet_client/core/utils/app_constants.dart';
import 'package:savdo_agnet_client/core/widgets/appBarWidget.dart';
import 'package:savdo_agnet_client/features/accounts/presentation/widgets/account_items.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: cBackgroundColor,
      appBar: appBarWidget(context, 'Akkauntlar'),
      body: ListView.builder(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          itemCount: 2,
          itemBuilder: (context, index) {
            return const AccountItemWidget(title: 'Jakhongir Ruzaliev',
                brandName: 'Liqui Moly',
                image: 'assets/images/truck.png');
          }),
    );
  }
}
