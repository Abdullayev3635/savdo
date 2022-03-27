import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/utils/app_constants.dart';
import '../../../../core/widgets/costum_toast.dart';
import '../../../korzina_screen/data/database/database.dart';
import '../../../korzina_screen/domain/bloc/korzina_bloc.dart';

class ProductItemDialog extends StatefulWidget {
  const ProductItemDialog({
    Key? key,
    required this.title,
    required this.price,
    required this.image,
    required this.id,
    required this.brendNomi,
    required this.carType,
    required this.rating,
  }) : super(key: key);
  final String title;
  final String image;
  final String carType;
  final String brendNomi;

  final int price;
  final int rating;
  final int id;

  @override
  _ProductItemDialogState createState() => _ProductItemDialogState();
}

class _ProductItemDialogState extends State<ProductItemDialog> {
  String valyuta = '';
  String hajmi = '';
  int count = 1;
  bool isValyuta = true;
  bool isHajmi = true;
  late Timer timer;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => KorzinaBloc(Database()),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 37.0),
          child: Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(22.r)),
            insetPadding:
                const EdgeInsets.symmetric(vertical: 20, horizontal: 0),
            child: BlocBuilder<KorzinaBloc, KorzinaState>(
              builder: (context, state) {
                return Container(
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(22.r)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Stack(
                        alignment: Alignment.topRight,
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: 49.h),
                            decoration: BoxDecoration(
                              color: cWhiteColor,
                              borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(22.r)),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(22.r)),
                              child: Image.asset(
                                widget.image,
                                height: 214.h,
                                width: 340.w,
                                fit: BoxFit.fitHeight,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: InkWell(
                                borderRadius: BorderRadius.circular(22.r),
                                onTap: () => setState(
                                    () => Navigator.pop(context, state)),
                                child: SvgPicture.asset(
                                  'assets/icons/ic_close.svg',
                                  width: 22.w,
                                  height: 22.h,
                                )),
                          )
                        ],
                      ),
                      dialogContent(context)
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Padding dialogContent(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(left: 22.0.w, top: 38.h),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(widget.title,
                  style: TextStyle(
                    fontFamily: 'Medium',
                    fontSize: 16.sp,
                    color: cBlackColor,
                  )),
              Text(
                '${widget.price} so’m',
                style: TextStyle(
                    fontFamily: 'Medium',
                    fontSize: 14.sp,
                    color: primaryColor,
                    fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 24.h),
              Text('Valyuta:',
                  style: TextStyle(
                      fontFamily: 'Medium',
                      fontSize: 13.sp,
                      color: cBlackColor)),
              SizedBox(height: 12.h),
              Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                ElevatedButton(
                  key: const ValueKey('true'),
                  onPressed: () {
                    setState(() {
                      isValyuta = true;
                    });
                  },
                  child: Text(
                    'So’m',
                    style: isValyuta ? inActiveTextStyle : activeTextStyle,
                  ),
                  style: isValyuta ? activeButtonStyle : inActiveButtonStyle,
                ),
                SizedBox(width: 12.w),
                ElevatedButton(
                  key: const ValueKey('false'),
                  onPressed: () {
                    setState(() {
                      isValyuta = false;
                    });
                  },
                  child: Text(
                    'Valyuta',
                    style: isValyuta ? activeTextStyle : inActiveTextStyle,
                  ),
                  style: isValyuta ? inActiveButtonStyle : activeButtonStyle,
                ),
              ]),
              SizedBox(height: 24.h),
              Text('Hajmi:',
                  style: TextStyle(
                      fontFamily: 'Medium',
                      fontSize: 13.sp,
                      color: cBlackColor)),
              SizedBox(height: 12.h),
              Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                ElevatedButton(
                  onPressed: () {
                    setState(() {});
                    isHajmi = true;
                  },
                  child: Text(
                    'Blok',
                    style: isHajmi ? inActiveTextStyle : activeTextStyle,
                  ),
                  style: isHajmi ? activeButtonStyle : inActiveButtonStyle,
                ),
                SizedBox(width: 12.w),
                ElevatedButton(
                  onPressed: () {
                    setState(() {});
                    isHajmi = false;
                  },
                  child: Text(
                    'Dona',
                    style: isHajmi ? activeTextStyle : inActiveTextStyle,
                  ),
                  style: isHajmi ? inActiveButtonStyle : activeButtonStyle,
                ),
              ]),
              Container(
                  margin: EdgeInsets.symmetric(vertical: 24.h),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            if (count > 1) setState(() => count--);
                          },
                          onTapDown: (TapDownDetails details) {
                            timer = Timer.periodic(
                                const Duration(milliseconds: 300), (t) {
                              if (count > 1) {
                                setState(() => count--);
                              } else {
                                timer.cancel();
                              }
                            });
                          },
                          onTapUp: (TapUpDetails details) => timer.cancel(),
                          onTapCancel: () => timer.cancel(),
                          child: Container(
                            width: 74.w,
                            height: 50.h,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25.r),
                                border:
                                    Border.all(width: 1, color: primaryColor)),
                            child:
                                const Icon(Icons.remove, color: primaryColor),
                          ),
                        ),
                        Container(
                            width: 38,
                            margin: const EdgeInsets.symmetric(horizontal: 21),
                            child: Text('$count',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: cGrayColor,
                                    fontFamily: 'Regular',
                                    fontSize: 20.sp))),
                        GestureDetector(
                          onTap: () => setState(() => count++),
                          onTapDown: (TapDownDetails details) => timer =
                              Timer.periodic(const Duration(milliseconds: 300),
                                  (t) => setState(() => count++)),
                          onTapUp: (TapUpDetails details) => timer.cancel(),
                          onTapCancel: () => timer.cancel(),
                          child: Container(
                            width: 74.w,
                            height: 50.h,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25.r),
                                border:
                                    Border.all(width: 1, color: primaryColor)),
                            child: const Icon(Icons.add, color: primaryColor),
                          ),
                        ),
                        SizedBox(width: 25.w)
                      ])),
              Container(
                margin: const EdgeInsets.only(right: 22, bottom: 22),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          'Qaytish',
                          style: TextStyle(
                              color: primaryColor,
                              fontFamily: 'Medium',
                              fontSize: 16.sp),
                        ),
                        style: ButtonStyle(
                          fixedSize:
                              MaterialStateProperty.all(Size(140.w, 57.h)),
                          elevation: MaterialStateProperty.all(0),
                          backgroundColor: MaterialStateProperty.all(
                              primaryColor.withOpacity(0.1)),
                          // overlayColor: MaterialStateProperty.all(primaryColor.withOpacity(0.2)),
                          shape:
                              MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          )),
                        )),
                    ElevatedButton(
                      style: ButtonStyle(
                          fixedSize:
                              MaterialStateProperty.all(Size(140.w, 57.h)),
                          backgroundColor:
                              MaterialStateProperty.all(primaryColor),
                          elevation: MaterialStateProperty.all(0),
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)))),
                      onPressed: () {
                        // final box =  Hive.box<KorzinaCard>(korzinaBox);
                        // final korzinagaQushilyayotganMaxsulot = KorzinaCard(
                        //     title: widget.title,
                        //     image: widget.image,
                        //     number: count,
                        //     id: widget.id,
                        //     price: widget.price,
                        //     hajmi: hajmi,
                        //     rating: widget.rating,
                        //     carType: widget.carType,
                        //     valyuta: valyuta);
                        // ///korzinaga qo'shyapti
                        // box.put(widget.id, korzinagaQushilyayotganMaxsulot);
                        Navigator.pop(context);
                        CustomToast.showToast('Муваффакиятли сакланди');
                      },
                      child: Text('Qo’shish',
                          style: TextStyle(
                              color: cWhiteColor,
                              fontSize: 16.sp,
                              fontFamily: 'Medium')),
                    ),
                  ],
                ),
              )
            ]));
  }

// Widget _buildChip(String label, int index) {
//   return Container(
//     margin: EdgeInsets.only(right: 12.w),
//     child: ElevatedButton(
//       child: Text(label,
//           style: selected.contains(index) ? textStyleWhite16 : textStyle16),
//       onPressed: () {
//         if (selected.contains(index)) {
//           setState(() => selected.remove(index));
//         } else {
//           setState(() => selected.add(index));
//         }
//       },
//       style: ButtonStyle(
//           padding: MaterialStateProperty.all(
//             EdgeInsets.symmetric(vertical: 15.h, horizontal: 17.w),
//           ),
//           elevation: MaterialStateProperty.all(0),
//           shape: MaterialStateProperty.all(RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(25.r))),
//           backgroundColor: MaterialStateProperty.all(
//               valyuta.contains(index) ? cFirstColor : cSecondColor)),
//     ),
//   );
// }

// Widget _buildChipOne(String label) {
//   return Container(
//     margin: EdgeInsets.only(right: 12.w),
//     child: ElevatedButton(
//       child: Text(label,
//           style: hajmi.contains(index)
//               ? TextStyle(
//                   fontSize: 16.sp, fontFamily: 'Medium', color: cWhiteColor)
//               : textStylePrimary16),
//       onPressed: () {
//         if (hajmi.contains(index)) {
//           setState(() => hajmi.clear());
//         } else {
//           setState(() {});
//           hajmi.clear();
//           hajmi.add(index);
//         }
//       },
//       style: ButtonStyle(
//           padding: MaterialStateProperty.all(
//             EdgeInsets.symmetric(vertical: 15.h, horizontal: 31.w),
//           ),
//           elevation: MaterialStateProperty.all(0),
//           shape: MaterialStateProperty.all(RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(25.r))),
//           backgroundColor: MaterialStateProperty.all(
//               hajmi.contains(index) ? primaryColor : cHintTextColor)),
//     ),
//   );
// }
}
//
// onPressed: () {
// print('putAt0');
// final korzinagaQushilyayotganMaxsulot = KorzinaCard(
// description: widget.description,
// title: widget.title,
// image: widget.image,
// number: count,
// id: widget.id,
// price: widget.price,
// izoh: selected,
// hajmi: selectedOne,
// tarkibi: widget.tarkibi,
// oshxonaNomi: widget.oshxonaNomi,
// jamiSumma: widget.jamiSumma);
// // if(box.)
// // box.pu
// final box = Hive.box<KorzinaCard>('korzina_box');
// dynamic desiredKey;
// final Map<dynamic, KorzinaCard> korzinaMap = box.toMap();
// korzinaMap.forEach((key, value) {
// if (value.id == widget.id) {
// box.putAt(key, value);
// print('putAt');
// box.delete(desiredKey);
// } else {
// box.add(korzinagaQushilyayotganMaxsulot);
// Navigator.of(context).pushAndRemoveUntil(
// FadeRoute2(ShopScreen(
// oshxonaNomi: widget.oshxonaNomi,
// )),
// (route) => false);
// Fluttertoast.showToast(msg: 'Муваффакиятли сакланди');
// print('putAt1');
// }
// });
//
// // }
// print('putAt2');
// // print(box.keys);
// // Navigator.pushAndRemoveUntil(context);
// },
