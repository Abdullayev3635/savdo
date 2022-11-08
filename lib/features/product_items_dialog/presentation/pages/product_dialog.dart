import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:savdo_agnet_client/core/widgets/dialog_frame.dart';
import 'package:savdo_agnet_client/di/dependency_injection.dart';
import 'package:savdo_agnet_client/features/buyurtma/data/model/buyurtma_model.dart';
import 'package:savdo_agnet_client/features/buyurtma/data/model/currency_model.dart';
import 'package:savdo_agnet_client/features/buyurtma/data/model/price_type_model.dart';
import 'package:savdo_agnet_client/features/korzina_screen/data/korzina_hive/korzina_hive.dart';
import 'package:savdo_agnet_client/features/korzina_screen/prezentation/bloc/korzina_bloc.dart';
import 'package:savdo_agnet_client/features/product_items/presentation/widgets/dialog_text_field_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/utils/app_constants.dart';
import '../../../../core/widgets/costum_toast.dart';

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

  // List<KorzinaCard> list;
  final String? image;

  final int id;
  final int? residue;
  final int? currencyId;
  final String? name;
  final String? size;

  // final String? image;
  final num? price;
  final String? category;
  final double? bloklarSoni;
  final double? dona;

  final int blok;
  final String? currencyName;

  @override
  _ProductItemDialogState createState() => _ProductItemDialogState();
}

class _ProductItemDialogState extends State<ProductItemDialog> {
  String group1 = '0';
  String group2 = '0';
  double bloklarSoni = 1;
  double dona = 1;
  late String initialBlok;
  late String initialPieces;
  TextEditingController blokController = TextEditingController();
  TextEditingController piecesController = TextEditingController();

  bool isValyuta = true;
  bool isHajmi = true;
  String narxTuriGroup = "0";
  String kurs = "0";
  late Timer timer;
  SharedPreferences sharedPreferences = di.get();

  @override
  void initState() {
    super.initState();
    initialBlok = widget.bloklarSoni.toString();
    initialPieces = widget.dona.toString();
    blokController.text = initialBlok;
    piecesController.text = initialPieces;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      reverse: true,
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height / 30),
      child: AllDialogSkeleton(
        title: '',
        icon: '',
        child: Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(22.r)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                margin: EdgeInsets.only(top: 9.h),
                height: 200.h,
                width: 340.w,
                decoration: BoxDecoration(
                  color: cWhiteColor,
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(22.r)),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(22.r)),
                  child: CachedNetworkImage(
                    imageUrl: widget.image!,
                    fit: BoxFit.cover,
                    placeholder: (context, url) {
                      return Container(
                        margin: const EdgeInsets.all(20),
                        child: SvgPicture.asset(
                          'assets/icons/ic_fon_gallery.svg',
                          fit: BoxFit.cover,
                        ),
                      );
                    },
                    errorWidget: (contex, url, e) {
                      return Container(
                        margin: const EdgeInsets.all(20),
                        child: SvgPicture.asset(
                          'assets/icons/ic_fon_gallery.svg',
                          fit: BoxFit.cover,
                        ),
                      );
                    },
                  ),
                ),
              ),
              dialogContent(context, [], [])
            ],
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
                      onTap: () {
                        FocusManager.instance.primaryFocus?.unfocus();
                        onTapInOrDecrement(
                            count: dona, isInc: false, blokOrPieces: true);
                      },
                      onTapDown: (TapDownDetails details) {
                        FocusManager.instance.primaryFocus?.unfocus();
                        // onTapInOrDecrementPeriodic(count, isInc, newValue);
                        timer = Timer.periodic(
                            const Duration(milliseconds: 100), (t) {
                          if (bloklarSoni > 1) {
                            if (blokController.text.isEmpty) {
                              bloklarSoni = 0;
                            } else {
                              bloklarSoni = double.parse(blokController.text);
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
                      onTap: () {
                        FocusManager.instance.primaryFocus?.unfocus();
                        onTapInOrDecrement(
                            count: bloklarSoni,
                            isInc: true,
                            blokOrPieces: true);
                      },
                      onTapDown: (TapDownDetails details) {
                        FocusManager.instance.primaryFocus?.unfocus();
                        timer = Timer.periodic(
                          const Duration(milliseconds: 100),
                          (t) => setState(
                            () {
                              if (blokController.text.isEmpty) {
                                bloklarSoni = 0;
                              } else {
                                bloklarSoni = double.parse(blokController.text);
                              }
                              bloklarSoni++;
                              blokController.text = bloklarSoni.toString();
                              initialBlok = bloklarSoni.toString();
                            },
                          ),
                        );
                      },
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
                      onTap: () {
                        FocusManager.instance.primaryFocus?.unfocus();
                        onTapInOrDecrement(
                            count: dona, isInc: false, blokOrPieces: false);
                      },
                      onTapDown: (TapDownDetails details) {
                        FocusManager.instance.primaryFocus?.unfocus();
                        timer = Timer.periodic(
                            const Duration(milliseconds: 100), (t) {
                          if (piecesController.text.isEmpty) {
                            dona = 0;
                          } else {
                            dona = double.parse(piecesController.text);
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
                      onTap: () {
                        FocusManager.instance.primaryFocus?.unfocus();
                        onTapInOrDecrement(
                            count: dona, isInc: true, blokOrPieces: false);
                      },
                      onTapDown: (TapDownDetails details) {
                        FocusManager.instance.primaryFocus?.unfocus();
                        timer = Timer.periodic(
                            const Duration(milliseconds: 100),
                            (t) => setState(
                                  () {
                                    if (piecesController.text.isEmpty) {
                                      dona = 0;
                                    } else {
                                      dona =
                                          double.parse(piecesController.text);
                                    }
                                    dona++;
                                    piecesController.text = dona.toString();
                                    initialPieces = dona.toString();
                                  },
                                ));
                      },
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
          Padding(
        padding: EdgeInsets.only(
            right: 7.w, top: 24.h, left: 7.w, bottom: 14.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text('Narx turi:', style: textStylePrimaryMed16),
          ],
        ),
      ),
          ValueListenableBuilder<Box<BuyurtmaModel>>(
            valueListenable: Hive.box<BuyurtmaModel>(buyurtmaBox).listenable(),
            builder:(contex, box, _) {
              List<BuyurtmaModel> buyurtmaList = box.values.toList().cast<BuyurtmaModel>();
              print(buyurtmaList.toString());
              List<CurrencyModel> currencyL = buyurtmaList[0].currency!;
              return Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 50.h,
                      child: ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemCount: currencyL.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  narxTuriGroup = index.toString();
                                  kurs =
                                      currencyL[index].value ?? "0";
                                });
                              },
                              child: Row(
                                children: [
                                  Radio(
                                      value: '$index',
                                      groupValue: narxTuriGroup,
                                      fillColor:
                                      MaterialStateProperty.all(
                                          primaryColor),
                                      activeColor: primaryColor,
                                      onChanged: (value) {
                                        setState(() {
                                          narxTuriGroup =
                                              value.toString();
                                          kurs = currencyL[index]
                                              .value ??
                                              "0";
                                        });
                                      }),
                                  Text(
                                    currencyL[index].name ?? "null",
                                    maxLines: 1,
                                    style: textStylePrimaryMed14,
                                  ),
                                ],
                              ),
                            );
                          }),
                    ),
                  ),
                ],
              );
            },
      ),

      SizedBox(height: 5.h),
      SvgPicture.asset('assets/icons/ic_divider.svg',),

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
                      FocusManager.instance.primaryFocus?.unfocus();
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
                    if (double.parse(piecesController.text) != 0) {
                      FocusManager.instance.primaryFocus?.unfocus();
                      final productAddKorzina = KorzinaCard(
                        blok: widget.blok,
                        quantity: double.parse(blokController.text) *
                                widget.blok.toDouble() +
                            double.parse(piecesController.text),
                        bloklarSoni: double.parse(blokController.text),
                        residue: widget.residue!,
                        price: widget.price!,
                        name: widget.name!,
                        dona: double.parse(piecesController.text),
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
                    } else {
                      CustomToast.showToast('Maxsulot sonini kiriting!');
                    }
                  },
                  child: Text(
                    'Qo’shish',
                    style: TextStyle(
                        color: cWhiteColor,
                        fontSize: 16.sp,
                        fontFamily: 'Medium'),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  void onTapInOrDecrement(
      {required double count,
      required bool isInc,
      required bool blokOrPieces}) {
    if (isInc) {
      setState(() => blokOrPieces
          ? {
              if (blokController.text.isEmpty)
                {bloklarSoni = 0}
              else
                {bloklarSoni = double.parse(blokController.text)},
              bloklarSoni++,
              blokController.text = bloklarSoni.toString(),
              initialBlok = bloklarSoni.toString(),
            }
          : {
              if (piecesController.text.isEmpty)
                {dona = 0}
              else
                {dona = double.parse(piecesController.text)},
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
                  {bloklarSoni = double.parse(blokController.text)},
                if (bloklarSoni > 0) bloklarSoni--,
                blokController.text = bloklarSoni.toString(),
                initialBlok = bloklarSoni.toString(),
              }
            : {
                if (piecesController.text.isEmpty)
                  {dona = 0}
                else
                  {dona = double.parse(piecesController.text)},
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
