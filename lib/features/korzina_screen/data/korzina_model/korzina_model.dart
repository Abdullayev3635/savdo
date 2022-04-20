// ignore_for_file: non_constant_identifier_names

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:savdo_agnet_client/core/utils/app_constants.dart';
import '../korzina_hive/korzina_hive.dart';

class KorzinaCardModel extends StatefulWidget {
  const KorzinaCardModel({
    Key? key,
    required this.number,
    required this.image,
    required this.title,
    required this.price,
    required this.id,
  }) : super(key: key);
  final String? title;
  final String? image;
  final int? price;
  final int? id;
  final int? number;

  @override
  _KorzinaCardModelState createState() => _KorzinaCardModelState();
}

class _KorzinaCardModelState extends State<KorzinaCardModel> {
  @override
  Widget build(BuildContext context) {
    var box = Hive.box<KorzinaCard>('korzina_box');
    KorzinaCard? cad = box.getAt(widget.id!);
    return Container(
        width: 314.w,
        height: 87.h,
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.r),
          color: Colors.red,
        ),
        child: Row(
          children: [
            Container(
              width: 67.w,
              height: 67.h,
              margin: const EdgeInsets.all(11),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: cWhiteColor),
              child: Image.asset(widget.image!),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 12.h),
                  child: SizedBox(
                    width: 150,
                    child: AutoSizeText(
                      widget.title!,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: textStylePrimaryReg16,
                    ),
                  ),
                ),
                Text(
                  '${widget.price!} so’m',
                  style: TextStyle(
                      color: Colors.red,
                      fontSize: 13.sp,
                      fontFamily: 'Medium'),
                ),
              ],
            ),
            const Spacer(),
            Padding(
              padding: EdgeInsets.only(right: 19.0.w),
              child: Text(
                'x${widget.number!}',
                style: TextStyle(
                    color: Colors.red,
                    fontSize: 16.sp,
                    fontFamily: 'Medium'),
              ),
            ),
          ],
        ));
  }
}
