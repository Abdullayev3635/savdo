import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:savdo_agnet_client/core/utils/app_constants.dart';
import 'package:savdo_agnet_client/di/dependency_injection.dart';
import 'package:savdo_agnet_client/features/product_items/presentation/pages/brand_products.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../bloc/brand/brand_bloc.dart';

class ClientProductWidget extends StatelessWidget {
  final ClientBrandSuccessState state;

  ClientProductWidget({
    required this.state,
    Key? key,
  }) : super(key: key);
  final SharedPreferences sharedPreferences = di.get();

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 16.h),
        primary: false,
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        itemCount: state.list.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Products.screen(
                      brandName: state.list[index].name ?? "",
                      brandId: state.list[index].id,
                      priceTypeId: int.parse(
                          sharedPreferences.getString(sharedPriceTypeId)??''),
                      salesAgentId: int.parse(
                        sharedPreferences.getString(sharedSalesAgentId) ?? '',
                      ),
                    ),
                  ));
            },
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.r),
                  color: cWhiteColor),
              margin: EdgeInsets.only(bottom: 16.h),
              child: Row(
                children: [
                  Container(
                    margin: EdgeInsets.all(13.w),
                    // padding:
                    //     EdgeInsets.symmetric(vertical: 18.h, horizontal: 8.w),
                    width: 71.w,
                    height: 71.h,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10.r),
                      child: CachedNetworkImage(
                        imageUrl:
                            "https://via.placeholder.com/640x480.png/00ee00?text=ut",

                        /// todo: manashu yerga image bo'lishi kerak
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
                      ),
                    ),
                    decoration: BoxDecoration(
                        color: cImageB2Color,
                        borderRadius: BorderRadius.circular(10.r)),
                  ),
                  SizedBox(width: 4.w),
                  Expanded(
                      child: Text(
                    state.list[index].name ?? "",
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontFamily: 'Medium',
                      color: cGrayColor,
                    ),
                  )),
                  Container(
                    width: 105.w,
                    padding:
                        EdgeInsets.symmetric(horizontal: 31.w, vertical: 38.h),
                    child: Text(
                      "${state.list[index].count ?? 0}",
                      maxLines: 1,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      style: textStylePrimaryReg16,
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }
}
