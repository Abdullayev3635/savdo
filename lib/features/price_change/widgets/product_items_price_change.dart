import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:savdo_agnet_client/core/utils/app_constants.dart';
import 'package:savdo_agnet_client/features/price_change/widgets/product_dialog_price_change.dart';

import '../../../core/utils/api_path.dart';
import '../../buyurtma/data/model/price_model.dart';
import '../../product/data/model/product_model_new.dart';
import '../../product_items/presentation/bloc/brand_products/brands_products_bloc.dart';
import '../../product_items_dialog/presentation/pages/product_dialog.dart';

// import 'package:savdo_agnet_client/features/product_items/presentation/widgets/product_dialog.dart';

class ProductItemsPriceWidget extends StatefulWidget {
  final String? title, size, image, count, incomePrice, category, currencyName, brandNomi;
  final int? id, currencyId, blok;
  final num? price,  residue;
  List<PriceList> priceList;
  ProductsNew productsNew;
  late BrandsProductsBloc brandBloc;
  ProductItemsPriceWidget({
    required this.id,
    required this.size,
    required this.title,
    required this.blok,
    required this.price,
    required this.count,
    required this.priceList,
    required this.image,
    required this.residue,
    required this.category,
    required this.brandNomi,
    required this.currencyId,
    required this.currencyName,
    required this.incomePrice,
    required this.productsNew,
    required this.brandBloc,
    Key? key,
  }) : super(key: key);

  @override
  State<ProductItemsPriceWidget> createState() =>
      _ProductItemsPriceWidgetState();
}

class _ProductItemsPriceWidgetState extends State<ProductItemsPriceWidget> {
  var formatter = NumberFormat('#,##0.' + "#" * 2);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: 21.h,
        bottom: 12.h,
        left: 21.w,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.r),
        color: cWhiteColor,
      ),
      margin: EdgeInsets.only(bottom: 16.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 110.w,
            height: 115.h,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10.r),
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
            decoration: BoxDecoration(
                color: cImageB2Color,
                borderRadius: BorderRadius.circular(10.r)),
          ),
          Padding(
            padding: EdgeInsets.only(left: 23.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width / 2.2,
                  child: Text(widget.title?.toUpperCase() ?? '',
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: primaryColor,
                        fontSize: 18.sp,
                        fontFamily: 'GilroyMedium',
                      )),
                ),
                SizedBox(height: 7.h),
                Text(
                  widget.category ?? "",
                  style: TextStyle(
                      fontFamily: 'GilroyRegular',
                      fontSize: 12.sp,
                      color: primaryColor),
                ),
                SizedBox(height: 7.h),
                Text(
                  '${formatter.format(double.parse(widget.incomePrice.toString().replaceAll(",", "")))} ${widget.currencyName}',
                  style: TextStyle(
                      fontFamily: 'GilroyRegular',
                      fontSize: 12.sp,
                      color: cOrangeColor),
                ),
                SizedBox(height: 17.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(width: 65.w),
                    Container(
                      margin: EdgeInsets.only(right: 10.w),
                      child: ElevatedButton(
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return ProductItemDialogPrice(
                                  bloklarSoni: 0,
                                  dona: 0,
                                  // brendNomi: widget.brandNomi ?? '',
                                  category: widget.category ?? '',
                                  name: widget.title ?? '',
                                  price: widget.price,
                                  image: widget.image,
                                  residue: widget.residue,
                                  id: widget.id ?? 0,
                                  size: widget.size,
                                  currencyName: widget.currencyName,
                                  currencyId: widget.currencyId,
                                  blok: widget.blok ?? 0,
                                  incomePrice: widget.incomePrice,
                                  priceList: widget.priceList,
                                  productsNew: widget.productsNew,
                                  brandBloc: widget.brandBloc,
                                );
                              });
                        },
                        child: Text(
                          "Narx o'zgartirish",
                          style: TextStyle(
                              fontFamily: 'GilroyRegular',
                              fontSize: 11.sp,
                              fontWeight: FontWeight.w400,
                              color: cWhiteColor),
                        ),
                        style: ButtonStyle(
                            elevation: MaterialStateProperty.all(0),
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(7.r))),
                            backgroundColor:
                                MaterialStateProperty.all(primaryColor)),
                      ),
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
