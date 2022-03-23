import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/utils/app_constants.dart';
import '../bloc/firma_cubit.dart';

class GridViewItemsWidget extends StatelessWidget {
  final SearchFirmaItemsState state;
  final int index;

  const GridViewItemsWidget({
    Key? key,
    required this.state,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(13),
      alignment: Alignment.center,
      child: Column(
        children: [
          Container(
            child: SvgPicture.asset('${state.firma[index].image}',
                width: 26.w,
                height: 26.h,
                alignment: Alignment.center,
                fit: BoxFit.none),
            height: 115.h,
            width: 145.w,
            decoration: BoxDecoration(
                color: cImageBackgroundColor,
                borderRadius: BorderRadius.circular(13.r)),
          ),
          SizedBox(
            height: 11.h,
          ),
          Text(
            '${state.firma[index].title}',
            style: const TextStyle(
                color: cWhiteColor, fontFamily: 'Regular', fontSize: 16),
          ),
        ],
      ),
      decoration: BoxDecoration(
          color: primaryColor,
          borderRadius: BorderRadius.circular(20)),
    );
  }
}
