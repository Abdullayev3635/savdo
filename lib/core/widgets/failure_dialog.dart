import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:savdo_agnet_client/core/utils/app_constants.dart';

class ShowFailureDialog extends StatefulWidget {
  const ShowFailureDialog({Key? key, required this.onTap}) : super(key: key);
  final VoidCallback onTap;

  @override
  State<ShowFailureDialog> createState() => _ShowFailureDialogState();
}

class _ShowFailureDialogState extends State<ShowFailureDialog> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) async {
      showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) {
            return FailureDialog(onTap: () => widget.onTap());
          });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class FailureDialog extends StatefulWidget {
  const FailureDialog({Key? key, required this.onTap}) : super(key: key);
  final VoidCallback onTap;

  @override
  _FailureDialogState createState() => _FailureDialogState();
}

class _FailureDialogState extends State<FailureDialog> {
  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 36.w),
        child: Dialog(
          clipBehavior: Clip.none,
          alignment: Alignment.center,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
          insetPadding: const EdgeInsets.symmetric(vertical: 20, horizontal: 0),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration:
                BoxDecoration(borderRadius: BorderRadius.circular(20.r)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: 8.h),
                SvgPicture.asset('assets/icons/404.svg'),
                SizedBox(height: 26.h),
                SvgPicture.asset('assets/icons/ic_404image.svg'),
                SizedBox(height: 40.h),
                Text(
                  'Ma’lumot yuklashda hatolik yuz berdi,iltimos qayta urinib ko’ring!',
                  textAlign: TextAlign.center,
                  style: textStylePrimaryMed14,
                ),
                SizedBox(height: 22.h),
                ElevatedButton(
                    onPressed: () {
                      widget.onTap();
                    },
                    style: buttonStyle,
                    child: const Text(
                      'Qayta urinish',
                      textAlign: TextAlign.center,
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
