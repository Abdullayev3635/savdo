import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:savdo_agnet_client/core/widgets/dialog_frame.dart';

import '../../../../core/utils/app_constants.dart';
import '../../../../core/widgets/costum_toast.dart';
import '../../../korzina_screen/data/database/database.dart';
import '../../../korzina_screen/domain/bloc/korzina_bloc.dart';
import 'dialog_text_field_widget.dart';

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
  int blok = 1;
  int dona = 1;
  String initialBlok = '0';
  String initialPieces = '0';
  TextEditingController blokController = TextEditingController();
  TextEditingController piecesController = TextEditingController();

  bool isValyuta = true;
  bool isHajmi = true;
  late Timer timer;

  @override
  void initState() {
    super.initState();
    blokController.text = initialBlok;
    piecesController.text = initialPieces;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => KorzinaBloc(Database()),
      child: SingleChildScrollView(
        reverse: true,
        clipBehavior: Clip.none,
        child: AllDialogSkeleton(
          title: '',
          icon: '',
          child: BlocBuilder<KorzinaBloc, KorzinaState>(
            builder: (context, state) {
              return Container(
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(22.r)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 9.h),
                      decoration: BoxDecoration(
                        color: cWhiteColor,
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(22.r)),
                      ),
                      child: ClipRRect(
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(22.r)),
                        child: Image.asset(
                          widget.image,
                          height: 214.h,
                          width: 340.w,
                          fit: BoxFit.fitHeight,
                        ),
                      ),
                    ),
                    dialogContent(context)
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Padding dialogContent(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 10.w, top: 38.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(widget.title,
              style: TextStyle(
                fontFamily: 'Medium',
                fontSize: 16.sp,
                color: const Color(0xff09051C),
              )),
          Text(
            '${widget.price} so’m',
            style: TextStyle(
              fontFamily: 'Medium',
              fontSize: 14.sp,
              color: primaryColor07,
            ),
          ),
          SizedBox(height: 24.h),
          Text('Valyuta:', style: titleTSM13),
          SizedBox(height: 12.h),
          Row(mainAxisAlignment: MainAxisAlignment.start, children: [
            valyutaButton(true, 'So’m'),
            SizedBox(width: 12.w),
            valyutaButton(false, 'Valyuta'),
          ]),
          SizedBox(height: 27.h),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Blok:', style: titleTSM13),
              Container(
                margin: EdgeInsets.symmetric(vertical: 12.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () => onTapInOrDecrement(
                          count: dona, isInc: false, blokOrPieces: true),
                      onTapDown: (TapDownDetails details) {
                        // onTapInOrDecrementPeriodic(count, isInc, newValue);
                        timer = Timer.periodic(
                            const Duration(milliseconds: 100), (t) {
                          if (blok > 1) {
                            if (blokController.text.isEmpty) {
                              blok = 0;
                            } else {
                              blok = int.parse(blokController.text);
                            }
                            if (dona > 1) {
                              blok--;
                            }
                            blokController.text = blok.toString();
                            initialBlok = blok.toString();
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
                            border: Border.all(width: 1, color: primaryColor)),
                        child: const Icon(Icons.remove, color: primaryColor),
                      ),
                    ),
                    TextFieldWidgetInProductDialog(controller: blokController),
                    GestureDetector(
                      onTap: () => onTapInOrDecrement(
                          count: blok, isInc: true, blokOrPieces: true),
                      onTapDown: (TapDownDetails details) =>
                          timer = Timer.periodic(
                        const Duration(milliseconds: 100),
                        (t) => setState(
                          () {
                            if (blokController.text.isEmpty) {
                              blok = 0;
                            } else {
                              blok = int.parse(blokController.text);
                            }
                            blok++;
                            blokController.text = blok.toString();
                            initialBlok = blok.toString();
                          },
                        ),
                      ),
                      onTapUp: (TapUpDetails details) => timer.cancel(),
                      onTapCancel: () => timer.cancel(),
                      child: Container(
                        width: 74.w,
                        height: 50.h,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25.r),
                            border: Border.all(width: 1, color: primaryColor)),
                        child: const Icon(Icons.add, color: primaryColor),
                      ),
                    ),
                    SizedBox(width: 25.w)
                  ],
                ),
              ),
            ],
          ),
          const Divider(),
          SizedBox(height: 16.h),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Dona:', style: titleTSM13),
              Container(
                margin: EdgeInsets.symmetric(vertical: 12.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () => onTapInOrDecrement(
                          count: dona, isInc: false, blokOrPieces: false),
                      onTapDown: (TapDownDetails details) {
                        timer = Timer.periodic(
                            const Duration(milliseconds: 100), (t) {
                          if (piecesController.text.isEmpty) {
                            dona = 0;
                          } else {
                            dona = int.parse(piecesController.text);
                          }
                          if (dona > 1) {
                            dona--;
                          }
                          piecesController.text = dona.toString();
                          initialPieces = dona.toString();
                        });
                      },
                      onTapUp: (TapUpDetails details) => timer.cancel(),
                      onTapCancel: () => timer.cancel(),
                      child: Container(
                        width: 74.w,
                        height: 50.h,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25.r),
                            border: Border.all(width: 1, color: primaryColor)),
                        child: const Icon(Icons.remove, color: primaryColor),
                      ),
                    ),
                    TextFieldWidgetInProductDialog(
                        controller: piecesController),
                    GestureDetector(
                      onTap: () => onTapInOrDecrement(
                          count: dona, isInc: true, blokOrPieces: false),
                      onTapDown: (TapDownDetails details) =>
                          timer = Timer.periodic(
                              const Duration(milliseconds: 100),
                              (t) => setState(
                                    () {
                                      if (piecesController.text.isEmpty) {
                                        dona = 0;
                                      } else {
                                        dona = int.parse(piecesController.text);
                                      }
                                      dona++;
                                      piecesController.text = dona.toString();
                                      initialPieces = dona.toString();
                                    },
                                  )),
                      onTapUp: (TapUpDetails details) => timer.cancel(),
                      onTapCancel: () => timer.cancel(),
                      child: Container(
                        width: 74.w,
                        height: 50.h,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25.r),
                            border: Border.all(width: 1, color: primaryColor)),
                        child: const Icon(Icons.add, color: primaryColor),
                      ),
                    ),
                    SizedBox(width: 25.w)
                  ],
                ),
              ),
            ],
          ),
          const Divider(),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text('Maxsulot qoldig’i:', style: titleTSM13),
            Padding(
              padding: EdgeInsets.only(right: 32.w),
              child: Text('275', style: textStyleR20),
            )
          ]),
          SizedBox(height: 34.h),
          Container(
            margin: EdgeInsets.only(right: 10.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      'Qaytish',
                      style: textStylePrimaryMed16,
                    ),
                    style: ButtonStyle(
                      fixedSize: MaterialStateProperty.all(Size(155.w, 57.h)),
                      elevation: MaterialStateProperty.all(0),
                      backgroundColor: MaterialStateProperty.all(
                          primaryColor.withOpacity(0.1)),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      )),
                    )),
                ElevatedButton(
                  style: ButtonStyle(
                      fixedSize: MaterialStateProperty.all(Size(155.w, 57.h)),
                      backgroundColor: MaterialStateProperty.all(primaryColor),
                      elevation: MaterialStateProperty.all(0),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)))),
                  onPressed: () {
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
        ],
      ),
    );
  }

  ElevatedButton valyutaButton(bool isValyuta, String title) {
    return ElevatedButton(
      key: ValueKey('$isValyuta'),
      onPressed: () => setState(() => this.isValyuta = isValyuta),
      child: Text(
        title,
        style: isValyuta
            ? this.isValyuta
                ? inActiveTextStyle
                : textStylePrimaryReg16
            : this.isValyuta
                ? textStylePrimaryReg16
                : inActiveTextStyle,
      ),
      style: isValyuta
          ? this.isValyuta
              ? activeButtonStyle
              : inActiveButtonStyle
          : this.isValyuta
              ? inActiveButtonStyle
              : activeButtonStyle,
    );
  }

  void onTapInOrDecrement(
      {required int count, required bool isInc, required bool blokOrPieces}) {
    if (isInc) {
      setState(() => blokOrPieces
          ? {
              if (blokController.text.isEmpty)
                {blok = 0}
              else
                {blok = int.parse(blokController.text)},
              blok++,
              blokController.text = blok.toString(),
              initialBlok = blok.toString(),
            }
          : {
              if (piecesController.text.isEmpty)
                {dona = 0}
              else
                {dona = int.parse(piecesController.text)},
              dona++,
              piecesController.text = dona.toString(),
              initialPieces = dona.toString()
            });
    } else {
      setState(() {
        blokOrPieces
            ? {
                if (blokController.text.isEmpty)
                  {blok = 0}
                else
                  {blok = int.parse(blokController.text)},
                if (blok > 1) blok--,
                blokController.text = blok.toString(),
                initialBlok = blok.toString(),
              }
            : {
                if (piecesController.text.isEmpty)
                  {dona = 0}
                else
                  {dona = int.parse(piecesController.text)},
                if (dona > 1) dona--,
                piecesController.text = dona.toString(),
                initialPieces = dona.toString()
              };
      });
    }
  }
}

TextStyle titleTSM13 = TextStyle(
    fontFamily: 'Medium', fontSize: 13.sp, color: const Color(0xff09051C));
TextStyle textStyleR20 =
    TextStyle(color: primaryColor, fontFamily: 'Regular', fontSize: 20.sp);
