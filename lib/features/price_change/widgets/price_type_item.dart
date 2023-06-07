import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:pattern_formatter/numeric_formatter.dart';
import 'package:savdo_agnet_client/features/buyurtma/data/model/price_model.dart';

import '../../../core/utils/app_constants.dart';
import '../../product/data/model/product_model_new.dart';

class PriceTypeItem extends StatefulWidget {
  PriceTypeItem(this.priceList, this.index, {Key? key}) : super(key: key);
  List<PriceList> priceList = [];
  int index = 0;

  @override
  State<PriceTypeItem> createState() => _PriceTypeItemState();
}

class _PriceTypeItemState extends State<PriceTypeItem> {
  TextEditingController priceController = TextEditingController();
  var formatter = NumberFormat('#,##0.' + "#" * 2);

  @override
  void initState() {
    priceController.text = formatter.format(double.parse(
        widget.priceList[widget.index].price.toString().replaceAll(',', '')));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 75,
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        color: cTextFieldColor,
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.only(top: 7.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Center(
                    child: Text(
                        widget.priceList[widget.index].currencyName.toString(),
                        style: titleTSM17),
                  ),
                ),
                Expanded(
                  child: Center(
                    child: Text(
                        widget.priceList[widget.index].priceTypeName.toString(),
                        style: titleTSM17),
                  ),
                ),
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.r),
              color: cHintTextColor,
              boxShadow: [textFieldShadow],
            ),
            height: 40.h,
            width: double.infinity,
            // margin: EdgeInsets.only(top: 3.h, right: 75.w),
            padding: EdgeInsets.fromLTRB(15.w, 0.h, 0.w, 0.h),
            child: TextFormField(
              textAlignVertical: TextAlignVertical.top,
              controller: priceController,
              keyboardType: TextInputType.number,
              inputFormatters: [ThousandsFormatter(allowFraction: true)],
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(bottom: 12.h),
                hintStyle: textStyleHintColorReg14,
              ),
              onChanged: (value) {
                widget.priceList[widget.index].price =
                    value.replaceAll(",", "").toString();
              },
            ),
          ),
        ],
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
