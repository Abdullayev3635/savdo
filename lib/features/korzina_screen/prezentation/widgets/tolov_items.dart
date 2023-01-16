import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:intl/intl.dart';
import 'package:savdo_agnet_client/core/utils/app_constants.dart';
import 'package:savdo_agnet_client/features/korzina_screen/data/korzina_hive/tolov_hive.dart';

import 'dialog_send.dart';

class TolovItemsWidget extends StatefulWidget {
  const TolovItemsWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<TolovItemsWidget> createState() => _TolovItemsWidgetState();
}

class _TolovItemsWidgetState extends State<TolovItemsWidget> {
  @override
  void initState() {
    super.initState();
  }
  var formatter = NumberFormat('#,##0.' + "#" * 2);
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Box<TolovHive>>(
      valueListenable: Hive.box<TolovHive>(tolovBox).listenable(),
      builder: (context, box, _) {
        var transaction = box.values.toList().cast<TolovHive>();
        return Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                primary: false,
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.symmetric(horizontal: 21.w),
                itemCount: transaction.isEmpty ? 0 : transaction.length,
                itemBuilder: (context, index) {
                  TolovHive? card = box.getAt(index);
                  return Container(
                    margin: EdgeInsets.only(bottom: 16.h),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.r),
                        color: cWhiteColor),
                    child: SlidableAutoCloseBehavior(
                      closeWhenTapped: false,
                      child: Slidable(
                        key: Key('${card?.id}'),
                        direction: Axis.horizontal,
                        endActionPane: ActionPane(
                          extentRatio: 0.24,
                          motion: const BehindMotion(),
                          dragDismissible: true,
                          children: [
                            InkWell(
                              onTap: () {
                                setState(() {});
                                card?.delete();
                              },
                              borderRadius: BorderRadius.horizontal(
                                  right: Radius.circular(15.r)),
                              child: Container(
                                width: 88.w,
                                height: 167.h,
                                decoration: BoxDecoration(
                                    color: Colors.red,
                                    borderRadius: BorderRadius.horizontal(
                                        right: Radius.circular(15.r))),
                                child: const Icon(Icons.delete,
                                    color: cWhiteColor),
                              ),
                            ),
                          ],
                        ),
                        child: Container(
                          padding: EdgeInsets.only(
                              top: 21.h, bottom: 12.h, left: 21.w),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15.r),
                              color: cWhiteColor),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                height: 70.h,
                                width: 70.w,
                                margin: EdgeInsets.only(bottom: 9.h),
                                // padding: const EdgeInsets.all(45),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.r),
                                  color: cBackgroundColor,
                                ),
                                child: SizedBox(
                                    child: SvgPicture.asset(
                                  "assets/icons/ic_dollar_circle.svg",
                                  fit: BoxFit.none,
                                  color: const Color(0xffBFC3FA),
                                )),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 23.w),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                        formatter.format(double.parse(transaction[index].cash??''.toString().replaceAll(",", ""))),
                                        style: TextStyle(
                                            color: primaryColor,
                                            fontSize: 18.sp,
                                            fontFamily: 'GilroyMedium')),
                                    SizedBox(height: 4.h),
                                    SizedBox(height: 7.h),
                                    SizedBox(
                                      width: 180.w,
                                      child: Text(
                                        '${transaction[index].paymentTypeName}',
                                        maxLines: 2,
                                        style: TextStyle(
                                            color: const Color(0xffDC200E),
                                            fontSize: 16.sp,
                                            fontFamily: 'GilroyMedium'),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const Spacer(),
                              Padding(
                                padding: EdgeInsets.only(right: 12.w),
                                child: Text(
                                  '${transaction[index].currencyName}',
                                  style: TextStyle(
                                      color: primaryColor,
                                      fontSize: 16.sp,
                                      fontFamily: 'GilroyMedium'),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
              flex: 6,
            ),
            InkResponse(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return SendDialog();
                  },
                );
              },
              child: Padding(
                padding: EdgeInsets.only(right: 15.w,bottom: 15.h, top: 15.h, left: 15.w),
                child: const Icon(
                  Icons.add_circle,
                  color: primaryColor,
                  size: 50,
                ),
              ),
            ),
            SizedBox(height: 91.h,),
          ],
        );
      },
    );
  }
}
