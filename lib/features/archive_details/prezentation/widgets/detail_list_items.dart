import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:savdo_agnet_client/features/archive_details/data/model/archive_details_model.dart';

import '../../../../core/utils/app_constants.dart';

class DetailListItems extends StatelessWidget {
  const DetailListItems({Key? key, required this.detailsList})
      : super(key: key);
  final List<ArchiveDetailsModel> detailsList;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: detailsList.length,
        shrinkWrap: true,
        primary: false,
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 21.w),
        itemBuilder: (context, index) {
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 13.h),
            height: 96.h,
            margin: EdgeInsets.only(bottom: 16.h),
            decoration: BoxDecoration(
              color: cWhiteColor,
              borderRadius: BorderRadius.circular(15.r),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      detailsList[index].name ?? '',
                      style: TextStyle(
                          fontFamily: 'SemiBold',
                          fontSize: 18.sp,
                          color: cGrayColor),
                    ),
                    Text(
                      '${detailsList[index].price} ${detailsList[index].currencyName}',
                      style: textStylePrimaryMed16,
                    ),
                    Row(
                      children: [
                        Text(
                          '${detailsList[index].quantity} х ${detailsList[index].price} ${detailsList[index].currencyName}',
                          style: TextStyle(
                              fontSize: 14.sp,
                              color: cOrange2Color,
                              fontFamily: "Regular"),
                        ),
                        // Text(
                        //   ' -  ${detailsList[index].residue} dona qoldiq',
                        //   style: TextStyle(
                        //       fontSize: 14.sp,
                        //       color: const Color(0xff969696),
                        //       fontFamily: "Regular"),
                        // ),
                      ],
                    )
                  ],
                ),
                // IconButton(
                //     onPressed: () {
                //       showDialog(
                //               context: context,
                //               builder: (context) {
                //                 return const ProductItemDialog(
                //                   bloklarSoni:
                //                   widget.transaction?[index].bloklarSoni,
                //                   dona: widget.transaction?[index].dona,
                //                   blok: widget.transaction?[index].blok ?? 0,
                //                   category: widget.transaction?[index].category,
                //                   name: widget.transaction?[index].name,
                //                   price: widget.transaction?[index].price,
                //                   image: null,
                //                   residue: widget.transaction?[index].residue,
                //                   id: widget.transaction![index].id!,
                //                   size: widget.transaction![index].size,
                //                   currencyName:
                //                   widget.transaction![index].currencyName,
                //                   currencyId: widget.transaction![index].currencyId,
                //                 );
                //               });
                //     },
                //     icon: const Icon(Icons.edit,color: primaryColor,))
              ], //SvgPicture.asset('assets/icons/ic_trash.svg')
            ),
          );
        });
  }
}
