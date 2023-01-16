import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:pattern_formatter/numeric_formatter.dart';
import 'package:savdo_agnet_client/core/widgets/dialog_frame.dart';
import 'package:savdo_agnet_client/di/dependency_injection.dart';
import 'package:savdo_agnet_client/features/buyurtma/data/model/buyurtma_model.dart';
import 'package:savdo_agnet_client/features/buyurtma/data/model/currency_model.dart';
import 'package:savdo_agnet_client/features/buyurtma/data/model/price_type_model.dart';
import 'package:savdo_agnet_client/features/korzina_screen/data/korzina_hive/korzina_hive.dart';
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
    required this.incomePrice,
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
  final num? incomePrice;
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
  late String initialPrice;
  TextEditingController blokController = TextEditingController();
  TextEditingController piecesController = TextEditingController();
  TextEditingController priceController = TextEditingController();

  bool isValyuta = true;
  bool isHajmi = true;
  String narxTuriGroup = "0";
  int priceTypeId = 0;
  int currencyId = 0;
  String currencyName = "";
  num kurs = 0;

  late Timer timer;
  SharedPreferences sharedPreferences = di.get();

  List<BuyurtmaModel> buyurtmaList = [];

  @override
  void initState() {
    super.initState();
    final box = Hive.box(buyurtmaBox);
    buyurtmaList = box.get(buyurtmaBox)?.cast<BuyurtmaModel>() ?? [];
    initialBlok = widget.bloklarSoni.toString();
    initialPieces = widget.dona.toString();
    initialPrice = widget.price.toString();
    blokController.text = initialBlok;
    piecesController.text = initialPieces;
    priceController.text = initialPrice;
    kurs = num.parse(sharedPreferences.getString(sharedCurrencyValue) ?? "1");
    narxTuriGroup = sharedPreferences.getString(sharedNarxGroupId) ?? "0";
    priceTypeId =
        int.parse(sharedPreferences.getString(sharedPriceTypeId) ?? "0");
    currencyId =
        int.parse(sharedPreferences.getString(sharedCurrencyId) ?? "0");
    currencyName = sharedPreferences.getString(sharedCurrencyName) ?? "";
    initFunction();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      reverse: true,
      padding: EdgeInsets.only(bottom: 35.h),
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
                decoration: BoxDecoration(
                  color: cWhiteColor,
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(22.r)),
                ),
                child: Center(
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
              ),
              dialogContent(
                  context, buyurtmaList[0].currency, buyurtmaList[0].priceType)
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
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.r),
              color: cHintTextColor,
              boxShadow: [textFieldShadow],
            ),
            height: 40.h,
            margin: EdgeInsets.only(top: 3.h, right: 75.w),
            padding: EdgeInsets.fromLTRB(10.w, 0.h, 0.w, 0.h),
            child: TextFormField(
              textAlignVertical: TextAlignVertical.top,
              controller: priceController,
              inputFormatters: [ThousandsFormatter(allowFraction: true)],
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(bottom: 12.h),
                hintStyle: textStyleHintColorReg14,
              ),
            ),
          ),
          SizedBox(height: 4.h),

          ///Block
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Blok:', style: titleTSM13),
              Container(
                margin: EdgeInsets.symmetric(vertical: 4.h),
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
                        width: 60.w,
                        height: 40.h,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.r),
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
                          blokOrPieces: true,
                        );
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
                        width: 60.w,
                        height: 40.h,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.r),
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

          ///Dona
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Dona:', style: titleTSM13),
              Container(
                margin: EdgeInsets.symmetric(vertical: 0.h),
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
                        width: 60.w,
                        height: 40.h,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.r),
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
                        width: 60.w,
                        height: 40.h,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.r),
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
            padding:
                EdgeInsets.only(right: 7.w, top: 4.h, left: 7.w, bottom: 7.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text('Narx turi:', style: textStylePrimaryMed16),
              ],
            ),
          ),
          Row(
            children: [
              Expanded(
                child: SizedBox(
                  height: 50.h,
                  child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemCount: currencyList!.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              currencyId = currencyList[index].id!;
                              currencyName = currencyList[index].name!;
                              narxTuriGroup = index.toString();
                              if (widget.currencyId == 1) {
                                if (currencyList[index].id == 1) {
                                  priceController.text =
                                      widget.price.toString();
                                } else {
                                  priceController.text =
                                      (widget.price! / kurs).toStringAsFixed(2);
                                }
                              } else {
                                if (currencyList[index].id == 2) {
                                  priceController.text =
                                      widget.price.toString();
                                } else {
                                  priceController.text =
                                      (widget.price! * kurs).toStringAsFixed(2);
                                }
                              }
                            });
                          },
                          child: Row(
                            children: [
                              Radio(
                                  value: '$index',
                                  groupValue: narxTuriGroup,
                                  fillColor:
                                      MaterialStateProperty.all(primaryColor),
                                  activeColor: primaryColor,
                                  onChanged: (value) {
                                    currencyId = currencyList[index].id!;
                                    currencyName = currencyList[index].name!;
                                    narxTuriGroup = value.toString();
                                    if (widget.currencyId == 1) {
                                      if (currencyList[index].id == 1) {
                                        priceController.text =
                                            widget.price.toString();
                                      } else {
                                        priceController.text =
                                            (widget.price! / kurs)
                                                .toStringAsFixed(2);
                                      }
                                    } else {
                                      if (currencyList[index].id == 2) {
                                        priceController.text =
                                            widget.price.toString();
                                      } else {
                                        priceController.text =
                                            (widget.price! * kurs)
                                                .toStringAsFixed(2);
                                      }
                                    }
                                    setState(() {});
                                  }),
                              Text(
                                (currencyList[index].name ?? "null") +
                                    " (" +
                                    (currencyList[index].value.toString()) +
                                    ")",
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
          ),
          SvgPicture.asset(
            'assets/icons/ic_divider.svg',
          ),
          SizedBox(height: 12.h),
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
                    if ((double.parse(piecesController.text) != 0) ||
                        (double.parse(blokController.text) != 0)) {
                      if (numParse(priceController.text) >=
                          numIncomePrice(widget.price!)) {
                        if (widget.residue! >=
                            (double.parse(blokController.text) *
                                    widget.blok.toDouble() +
                                double.parse(piecesController.text))) {
                          FocusManager.instance.primaryFocus?.unfocus();
                          final productAddKorzina = KorzinaCard(
                            blok: widget.blok,
                            quantity: double.parse(blokController.text) *
                                    widget.blok.toDouble() +
                                double.parse(piecesController.text),
                            bloklarSoni: double.parse(blokController.text),
                            residue: widget.residue!,
                            price: numParse(priceController.text),
                            name: widget.name!,
                            dona: double.parse(piecesController.text),
                            id: widget.id,
                            category: widget.category!,
                            size: widget.size!,
                            currencyId: currencyId,
                            currencyName: currencyName,
                            image: widget.image ?? '',
                            priceTypeId: priceTypeId,
                            incomePrice: widget.incomePrice,
                            incomePriceCurrencyId: widget.currencyId,
                            createdOn: DateTime.now(),
                          );
                          final box = Hive.box<KorzinaCard>(korzinaBox);

                          ///korzinaga qo'shyapti
                          box.put(widget.id, productAddKorzina);
                          Navigator.pop(context);
                          CustomToast.showToast('Муваффакиятли сакланди');
                        } else {
                          CustomToast.showToast(
                              'Maxsulot qoldig\'i yetarli emas!');
                        }
                      } else {
                        CustomToast.showToast(
                            'Maxsulot summasi sotuv summadan kam bo\'lmasligi kerak!');
                      }
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

  num numParse(String? price) {
    if (price == null) {
      return 0;
    } else if (price != "") {
      return num.parse(price.replaceAll(",", ""));
    } else {
      return 0;
    }
  }

  num numIncomePrice(num? price) {
    if (currencyId == 1) {
      if (widget.currencyId == 1) {
        return price!;
      } else {
        return price! * kurs;
      }
    } else {
      if (widget.currencyId == 2) {
        return price!;
      } else {
        return price! / kurs;
      }
    }
  }

  void initFunction() {
    if (widget.currencyId == 1) {
      if (int.parse(narxTuriGroup) == 0) {
        priceController.text = widget.price.toString();
      } else {
        priceController.text = (widget.price! / kurs).toStringAsFixed(2);
      }
    } else {
      if (int.parse(narxTuriGroup) == 1) {
        priceController.text = widget.price.toString();
      } else {
        priceController.text = (widget.price! * kurs).toStringAsFixed(2);
      }
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
