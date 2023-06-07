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
import 'package:savdo_agnet_client/features/buyurtma/data/model/price_model.dart';
import 'package:savdo_agnet_client/features/buyurtma/data/model/price_type_model.dart';
import 'package:savdo_agnet_client/features/korzina_screen/data/korzina_hive/korzina_hive.dart';
import 'package:savdo_agnet_client/features/price_change/widgets/price_type_item.dart';
import 'package:savdo_agnet_client/features/product_items/presentation/widgets/dialog_text_field_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/utils/app_constants.dart';
import '../../../../core/widgets/costum_toast.dart';
import '../../../core/utils/api_path.dart';
import '../../product/data/model/product_model_new.dart';
import '../../product_items/presentation/bloc/brand_products/brands_products_bloc.dart';

class ProductItemDialogPrice extends StatefulWidget {
  ProductItemDialogPrice({
    Key? key,
    required this.id,
    required this.name,
    required this.size,
    required this.price,
    required this.image,
    required this.residue,
    required this.category,
    required this.bloklarSoni,
    required this.priceList,
    required this.currencyId,
    required this.currencyName,
    required this.blok,
    required this.incomePrice,
    required this.productsNew,
    required this.brandBloc,
    this.dona,
  }) : super(key: key);
  late BrandsProductsBloc brandBloc;
  List<PriceList> priceList;
  ProductsNew productsNew;
  final String? image;

  final int id;
  final num? residue;
  final int? currencyId;
  final String? name;
  final String? size;

  // final String? image;
  final num? price;
  final String? incomePrice;
  final String? category;
  final double? bloklarSoni;
  final double? dona;

  final int blok;
  final String? currencyName;

  @override
  _ProductItemDialogPriceState createState() => _ProductItemDialogPriceState();
}

class _ProductItemDialogPriceState extends State<ProductItemDialogPrice> {
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
                      imageUrl: baseUrlImage + widget.image!,
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
      child: SingleChildScrollView(
        physics: const ScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Text('Maxsulot Nomi:', style: titleTSM17),
              Padding(
                padding: EdgeInsets.only(right: 32.w),
                child: SizedBox(
                    width: 150.w,
                    child: Text(widget.name ?? "", style: textStyleR20)),
              )
            ]),
            SizedBox(height: 20.h),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Text('Kirim Narxi:', style: titleTSM17),
              Padding(
                padding: EdgeInsets.only(right: 32.w),
                child: SizedBox(
                  width: 150.w,
                  child: Text(widget.incomePrice.toString() ?? "",
                      style: textStyleR20),
                ),
              )
            ]),
            SizedBox(height: 20.h),
            Container(
              height: widget.priceList.length == 3
                  ? 225
                  : widget.priceList.length == 2
                      ? 150
                      : 80,
              child: ListView.builder(
                  itemCount: widget.priceList.length,
                  itemBuilder: (context, i) {
                    return PriceTypeItem(widget.priceList, i);
                  }),
            ),
            SizedBox(height: 20.h),
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
                        'Ortga',
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
                      FocusManager.instance.primaryFocus?.unfocus();
                      final changedProduct = ProductsNew(
                        id: widget.productsNew.id,
                        name: widget.productsNew.name,
                        type: widget.productsNew.type,
                        productGroupId: widget.productsNew.productGroupId,
                        productGroupName: widget.productsNew.productGroupName,
                        mxikCode: widget.productsNew.mxikCode,
                        size: widget.productsNew.size,
                        brandId: widget.productsNew.brandId,
                        brandName: widget.productsNew.brandName,
                        residualLimit: widget.productsNew.residualLimit,
                        employeeShare: widget.productsNew.employeeShare,
                        sizeId: widget.productsNew.sizeId,
                        sizeName: widget.productsNew.sizeName,
                        seasonId: widget.productsNew.seasonId,
                        seasonName: widget.productsNew.seasonName,
                        currencyId: widget.productsNew.currencyId,
                        currencyName: widget.productsNew.currencyName,
                        incomePrice: widget.productsNew.incomePrice,
                        image: widget.productsNew.image,
                        barcodeType: widget.productsNew.barcodeType,
                        productTypeId: widget.productsNew.productTypeId,
                        productTypeName: widget.productsNew.productTypeName,
                        plu: widget.productsNew.plu,
                        keyboardCode: widget.productsNew.keyboardCode,
                        scaleId: widget.productsNew.scaleId,
                        scaleName: widget.productsNew.scaleName,
                        productFolderId: widget.productsNew.productFolderId,
                        priceList: widget.priceList,
                      );
                      print(changedProduct.toJson().toString());
                      widget.brandBloc.add(
                        SendNewProducts(
                            json: changedProduct,
                            onSuccess: () {
                              Navigator.of(context).pop();
                            }),
                      );
                    },
                    child: Text(
                      'Saqlash',
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
      ),
    );
  }
}

TextStyle titleTSM13 = TextStyle(
    fontFamily: 'Medium', fontSize: 13.sp, color: const Color(0xff09051C));
TextStyle titleTSM17 = TextStyle(
    fontFamily: 'Medium', fontSize: 17.sp, color: const Color(0xff09051C));
TextStyle textStyleR20 =
    TextStyle(color: primaryColor, fontFamily: 'Regular', fontSize: 20.sp);

ButtonStyle buttonStyle = ButtonStyle(
    fixedSize: MaterialStateProperty.all(Size(155.w, 57.h)),
    backgroundColor: MaterialStateProperty.all(primaryColor),
    elevation: MaterialStateProperty.all(0),
    shape: MaterialStateProperty.all(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))));
