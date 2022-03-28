import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:savdo_agnet_client/core/utils/app_constants.dart';
import 'package:savdo_agnet_client/features/product/presentation/pages/product_page.dart';

import '../../../../core/widgets/dialog_frame.dart';

class BuyurtmaDialog extends StatefulWidget {
  const BuyurtmaDialog({Key? key}) : super(key: key);

  @override
  _BuyurtmaDialogState createState() => _BuyurtmaDialogState();
}

class _BuyurtmaDialogState extends State<BuyurtmaDialog> {
  String group1 = 'So’m', group2 = 'Chakana';

  @override
  Widget build(BuildContext context) {
    return AllDialogSkeleton(
      title: 'Buyurtma',
      icon: 'assets/icons/ic_shopping_cart.svg',
      children: [
        SizedBox(
          height: 23.h,
        ),
        Container(
          height: 60.h,
          padding: EdgeInsets.only(left: 18.w, right: 10.w),
          decoration: BoxDecoration(
              color: cTextFieldColor,
              borderRadius: BorderRadius.circular(10.r)),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  'Mijozni tanlang',
                  style: TextStyle(
                    color: primaryColor,
                    fontFamily: 'Medium',
                    fontSize: 14.sp,
                  ),
                ),
              ),
              SvgPicture.asset('assets/icons/ic_dropdown.svg')
            ],
          ),
        ),
        Padding(
          padding:
              EdgeInsets.only(right: 7.w, top: 22.h, left: 7.w, bottom: 34.h),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  'Qarzdorligi:',
                  style: TextStyle(
                      color: primaryColor,
                      fontSize: 16.sp,
                      fontFamily: 'Medium'),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '-  1 000 000 so’m',
                    style: TextStyle(
                        color: cOrangeColor,
                        fontSize: 18.sp,
                        fontFamily: 'Regular'),
                  ),
                  SizedBox(
                    height: 14.h,
                  ),
                  Text(
                    '-  100 \$',
                    style: TextStyle(
                        color: cOrangeColor,
                        fontSize: 18.sp,
                        fontFamily: 'Regular'),
                  ),
                ],
              ),
            ],
          ),
        ),
        SvgPicture.asset('assets/icons/ic_divider.svg', fit: BoxFit.cover),
        // SizedBox(height: 25.h,),
        Padding(
          padding:
              EdgeInsets.only(right: 7.w, top: 24.h, left: 7.w, bottom: 28.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text.rich(TextSpan(children: [
                TextSpan(
                    text: 'Kurs: ',
                    style: TextStyle(
                        fontFamily: 'Medium',
                        fontSize: 16.sp,
                        color: primaryColor)),
                TextSpan(
                    text: '10650 so’m',
                    style: TextStyle(
                        fontFamily: 'Regular',
                        fontSize: 18.sp,
                        color: primaryColor)),
              ])),
            ],
          ),
        ),
        SvgPicture.asset('assets/icons/ic_divider.svg', fit: BoxFit.cover),
        Padding(
          padding:
              EdgeInsets.only(right: 7.w, top: 24.h, left: 7.w, bottom: 14.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text('Narx turi:',
                  style: TextStyle(
                      fontFamily: 'Medium',
                      fontSize: 16.sp,
                      color: primaryColor)),
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              children: [
                Radio(
                    value: 'So’m',
                    groupValue: group1,
                    fillColor: MaterialStateProperty.all(primaryColor),
                    activeColor: primaryColor,
                    onChanged: (value) {
                      setState(() {
                        group1 = value.toString();
                      });
                    }),
                Text('So’m', style: radioButtonTextStyle),
              ],
            ),
            SizedBox(width: 50.w),
            Row(
              children: [
                Radio(
                    value: 'Valyuta',
                    groupValue: group1,
                    fillColor: MaterialStateProperty.all(primaryColor),
                    activeColor: primaryColor,
                    onChanged: (value) {
                      setState(() {
                        group1 = value.toString();
                      });
                    }),
                Text('Valyuta', style: radioButtonTextStyle),
              ],
            ),
          ],
        ),
        SizedBox(height: 5.h),
        SvgPicture.asset('assets/icons/ic_divider.svg', fit: BoxFit.cover),
        Padding(
          padding:
              EdgeInsets.only(right: 7.w, top: 24.h, left: 7.w, bottom: 14.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text('Savdo turi:',
                  style: TextStyle(
                      fontFamily: 'Medium',
                      fontSize: 16.sp,
                      color: primaryColor)),
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Radio(
                    value: 'Chakana',
                    groupValue: group2,
                    fillColor: MaterialStateProperty.all(primaryColor),
                    activeColor: primaryColor,
                    onChanged: (value) {
                      setState(() {
                        group2 = value.toString();
                      });
                    }),
                Text('Chakana', style: radioButtonTextStyle),
              ],
            ),
            Row(
              children: [
                Radio(
                    value: 'Ulgurji',
                    groupValue: group2,
                    fillColor: MaterialStateProperty.all(primaryColor),
                    activeColor: primaryColor,
                    onChanged: (value) {
                      setState(() {
                        group2 = value.toString();
                      });
                    }),
                Text('Ulgurji', style: radioButtonTextStyle),
              ],
            ),
            Row(
              children: [
                Radio(
                    value: 'Plastik',
                    groupValue: group2,
                    fillColor: MaterialStateProperty.all(primaryColor),
                    activeColor: primaryColor,
                    onChanged: (value) {
                      setState(() {
                        group2 = value.toString();
                      });
                    }),
                Text('Plastik', style: radioButtonTextStyle),
              ],
            ),
            SizedBox(width: 10.w),
          ],
        ),
        SizedBox(height: 32.h),
        ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ProductPage(),
                  ));
            },
            style: buttonStyle,
            child: const Text(
              'Mahsulotga o’tish',
              textAlign: TextAlign.center,
            )),
      ],
    );
  }

  TextStyle radioButtonTextStyle =
      TextStyle(color: primaryColor, fontFamily: 'Medium', fontSize: 14.sp);
}
