import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:savdo_agnet_client/core/utils/app_constants.dart';
import 'package:savdo_agnet_client/features/add_client/presentation/pages/add_client_page.dart';
import 'package:savdo_agnet_client/features/edit_client/presentation/pages/edit_client_dialog.dart';

import '../../../../core/widgets/dialog_frame.dart';


class MijozlarDialog extends StatefulWidget {
  const MijozlarDialog({Key? key}) : super(key: key);

  @override
  _MijozlarDialogState createState() => _MijozlarDialogState();
}

class _MijozlarDialogState extends State<MijozlarDialog> {
  @override
  Widget build(BuildContext context) {
    return AllDialogSkeleton(
      title: 'Mijozlar',
      icon: 'assets/icons/ic_two_person.svg',
      child: Column(
        children: [  SizedBox(height: 34.h,),
          ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (context) => AddClientPage.screen(),));
              },
              style: buttonStyle,
              child: const Text(
                'Yangi mijoz qo’shish',
                textAlign: TextAlign.center,
              )),
          SizedBox(height: 16.h),
          ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                showDialog(context: context, builder: (context) {
                  return const EditClientDialog();
                });
              },
              style: buttonStyle,
              child: const Text(
                'Mijoz ma’lumotlarini o’zgartirish',
                textAlign: TextAlign.center,
              )),],
      ),
    );
  }
}
