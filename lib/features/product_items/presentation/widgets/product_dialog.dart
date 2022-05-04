import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hive/hive.dart';
import 'package:savdo_agnet_client/core/widgets/dialog_frame.dart';
import 'package:savdo_agnet_client/di/dependency_injection.dart';
import 'package:savdo_agnet_client/features/buyurtma/data/model/currency_model.dart';
import 'package:savdo_agnet_client/features/buyurtma/data/model/price_type_model.dart';
import 'package:savdo_agnet_client/features/korzina_screen/data/korzina_hive/korzina_hive.dart';
import 'package:savdo_agnet_client/features/korzina_screen/prezentation/bloc/korzina_bloc.dart';

import '../../../../core/utils/app_constants.dart';
import '../../../../core/widgets/costum_toast.dart';
import 'dialog_text_field_widget.dart';

class ProductItemDialog extends StatefulWidget {
  const ProductItemDialog({
    Key? key,
    required this.id,
    required this.name,
    required this.size,
    required this.price,
    required this.image,
    required this.residue,
    required this.category,
    required this.bloklarSoni,
    required this.currencyId,
    required this.currencyName,
    required this.blok,
    this.dona,
  }) : super(key: key);
  final int id;
  final int? residue;
  final int? currencyId;
  final String? name;
  final String? size;
  final String? image;
  final String? price;
  final String? category;
  final String? bloklarSoni;
  final String? dona;

  final String blok;
  final String? currencyName;

  @override
  _ProductItemDialogState createState() => _ProductItemDialogState();
}

class _ProductItemDialogState extends State<ProductItemDialog> {
  String group1 = 'AFN';
  String group2 = 'Chakana';
  int bloklarSoni = 1;
  int dona = 1;
  late String initialBlok;
  late String initialPieces;
  TextEditingController blokController = TextEditingController();
  TextEditingController piecesController = TextEditingController();

  bool isValyuta = true;
  bool isHajmi = true;
  late Timer timer;

  @override
  void initState() {
    super.initState();
    initialBlok = widget.bloklarSoni ?? '0';
    initialPieces = widget.dona ?? "0";
    blokController.text = initialBlok;
    piecesController.text = initialPieces;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => di<KorzinaBloc>()..add(KorzinaInitialEvent()),
      child: SingleChildScrollView(
        // reverse: true,
        clipBehavior: Clip.none,
        child: AllDialogSkeleton(
          title: '',
          icon: '',
          child: BlocBuilder<KorzinaBloc, KorzinaState>(
            builder: (context, state) {
              if (state is KorzinaSuccessState) {
                List<CurrencyModel>? currencyList =
                    state.buyurtmaList[0].currency;
                List<PriceTypeModel>? priceTypeList =
                    state.buyurtmaList[0].priceType;
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
                          child: widget.image == null
                              ? Container(
                                  decoration: BoxDecoration(
                                      color: cTextFieldColor,
                                      borderRadius:
                                          BorderRadius.circular(20.r)),
                                  height: 200.h,
                                  width: 340.w,
                                  child: SvgPicture.asset(
                                      'assets/icons/ic_gallery.svg',
                                      fit: BoxFit.none,
                                      height: 200),
                                )
                              : Image.network(
                                  widget.image ?? '',
                                  height: 214.h,
                                  width: 340.w,
                                  fit: BoxFit.fitHeight,
                                ),
                        ),
                      ),
                      dialogContent(context, currencyList, priceTypeList)
                    ],
                  ),
                );
              }
              return Container();
            },
          ),
        ),
      ),
    );
  }

  Padding dialogContent(
    BuildContext context,
    List<CurrencyModel>? currencyList,
    List<PriceTypeModel>? priceTypeList,
  ) {
    return Padding(
      padding: EdgeInsets.only(left: 10.w, top: 38.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(widget.name ?? '',
              style: TextStyle(
                fontFamily: 'Medium',
                fontSize: 16.sp,
                color: const Color(0xff09051C),
              )),
          Text(
            '${widget.price ?? 0} so’m',
            style: TextStyle(
              fontFamily: 'Medium',
              fontSize: 14.sp,
              color: primaryColor07,
            ),
          ),
          SizedBox(height: 24.h),
          Text('Narx turi:', style: titleTSM13),
          // SizedBox(height: 12.h),
          Row(
            children: [
              Expanded(
                child: SizedBox(
                  height: 50.h,
                  child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemCount: currencyList?.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              group1 = '$index';
                            });
                          },
                          child: Row(
                            children: [
                              Radio(
                                  value: '$index',
                                  groupValue: group1,
                                  fillColor:
                                      MaterialStateProperty.all(primaryColor),
                                  activeColor: primaryColor,
                                  onChanged: (value) {
                                    setState(() {
                                      group1 = value.toString();
                                      print(group1);
                                    });
                                  }),
                              Text(currencyList![index].name ?? "null",
                                  style: textStylePrimaryMed14),
                            ],
                          ),
                        );
                      }),
                ),
              ),
            ],
          ),
          // SizedBox(height: 12.h),
          Text('Savdo turi:', style: titleTSM13),
          // SizedBox(height: 12.h),
          Row(
            children: [
              Expanded(
                child: SizedBox(
                  height: 50.h,
                  child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemCount: priceTypeList?.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              group2 = '$index';
                            });
                          },
                          child: Row(
                            children: [
                              Radio(
                                  value: '$index',
                                  groupValue: group2,
                                  fillColor:
                                      MaterialStateProperty.all(primaryColor),
                                  activeColor: primaryColor,
                                  onChanged: (value) {
                                    setState(() {
                                      group2 = value.toString();
                                      print(group2);
                                    });
                                  }),
                              Text(priceTypeList![index].name ?? "null",
                                  style: textStylePrimaryMed14),
                            ],
                          ),
                        );
                      }),
                ),
              ),
            ],
          ),
          SizedBox(height: 10.h),
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
                          if (bloklarSoni > 1) {
                            if (blokController.text.isEmpty) {
                              bloklarSoni = 0;
                            } else {
                              bloklarSoni = int.parse(blokController.text);
                            }
                            if (dona > 1) {
                              bloklarSoni--;
                            }
                            blokController.text = bloklarSoni.toString();
                            initialBlok = bloklarSoni.toString();
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
                          count: bloklarSoni, isInc: true, blokOrPieces: true),
                      onTapDown: (TapDownDetails details) =>
                          timer = Timer.periodic(
                        const Duration(milliseconds: 100),
                        (t) => setState(
                          () {
                            if (blokController.text.isEmpty) {
                              bloklarSoni = 0;
                            } else {
                              bloklarSoni = int.parse(blokController.text);
                            }
                            bloklarSoni++;
                            blokController.text = bloklarSoni.toString();
                            initialBlok = bloklarSoni.toString();
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
              child: Text('${widget.residue ?? 0}', style: textStyleR20),
            )
          ]),
          SizedBox(height: 10.h),
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
                  style: buttonStyle,
                  onPressed: () async {
                    final productAddKorzina = KorzinaCard(
                      blok: widget.blok,
                      bloklarSoni: blokController.text,
                      residue: widget.residue!,
                      price: widget.price!,
                      name: widget.name!,
                      dona: piecesController.text,
                      id: widget.id,
                      category: widget.category!,
                      size: widget.size!,
                      currencyId: widget.currencyId ?? 0,
                      currencyName: widget.currencyName ?? '',
                      image: widget.image ?? '',
                    );
                    final box = Hive.box<KorzinaCard>(korzinaBox);

                    ///korzinaga qo'shyapti
                    box.put(widget.id, productAddKorzina);

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

  // ElevatedButton valyutaButton(bool isValyuta, String title) {
  //   return ElevatedButton(
  //     key: ValueKey('$isValyuta'),
  //     onPressed: () => setState(() => this.isValyuta = isValyuta),
  //     child: Text(
  //       title,
  //       style: isValyuta
  //           ? this.isValyuta
  //               ? inActiveTextStyle
  //               : textStylePrimaryReg16
  //           : this.isValyuta
  //               ? textStylePrimaryReg16
  //               : inActiveTextStyle,
  //     ),
  //     style: isValyuta
  //         ? this.isValyuta
  //             ? activeButtonStyle
  //             : inActiveButtonStyle
  //         : this.isValyuta
  //             ? inActiveButtonStyle
  //             : activeButtonStyle,
  //   );
  // }

  void onTapInOrDecrement(
      {required int count, required bool isInc, required bool blokOrPieces}) {
    if (isInc) {
      setState(() => blokOrPieces
          ? {
              if (blokController.text.isEmpty)
                {bloklarSoni = 0}
              else
                {bloklarSoni = int.parse(blokController.text)},
              bloklarSoni++,
              blokController.text = bloklarSoni.toString(),
              initialBlok = bloklarSoni.toString(),
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
                  {bloklarSoni = 0}
                else
                  {bloklarSoni = int.parse(blokController.text)},
                if (bloklarSoni > 1) bloklarSoni--,
                blokController.text = bloklarSoni.toString(),
                initialBlok = bloklarSoni.toString(),
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

ButtonStyle buttonStyle = ButtonStyle(
    fixedSize: MaterialStateProperty.all(Size(155.w, 57.h)),
    backgroundColor: MaterialStateProperty.all(primaryColor),
    elevation: MaterialStateProperty.all(0),
    shape: MaterialStateProperty.all(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))));
