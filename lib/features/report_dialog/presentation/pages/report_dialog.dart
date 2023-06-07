// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:savdo_agnet_client/core/utils/app_constants.dart';
import 'package:savdo_agnet_client/di/dependency_injection.dart';
import 'package:savdo_agnet_client/features/select_client/presentation/pages/select_client.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/widgets/costum_toast.dart';
import '../../../../core/widgets/dialog_frame.dart';
import '../../../buyurtma/data/model/buyurtma_model.dart';
import '../../../buyurtma/data/model/store_model.dart';
import '../../../select_yuk_beruvchi/presentation/pages/select_yuk_beruvchi_dialog.dart';
import '../widgets/web_view.dart';

class ReportDialog extends StatefulWidget {
  const ReportDialog(
      {Key? key,
      required this.yukYeruvchi,
      required this.maxsulot,
      required this.ombor,
      required this.mijoz,
      required this.sana,
      required this.url})
      : super(key: key);

  final int yukYeruvchi;
  final int maxsulot;
  final int ombor;
  final int mijoz;
  final int sana;
  final String url;

  @override
  _ReportDialogState createState() => _ReportDialogState();
}

class _ReportDialogState extends State<ReportDialog> {
  var start;
  var end;
  int clientId = 0;
  String clientName = 'Mijozni tanlang';
  int yukBeruvchiId = 0;
  String yukBeruvchiName = 'Yuk beruvchini tanlang';
  int omborId = 0;
  String omborName = 'Omborni tanlang';
  int maxsulotId = 0;
  String maxsulotName = 'Maxsulotni tanlang';
  String storeGroup = '-1';

  DateTime? selected1;
  DateTime? selected2;
  var customFormat = DateFormat('dd.MM.yyyy');
  SharedPreferences sharedPreferences = di.get();

  List<BuyurtmaModel> buyurtmaList = [];
  List<StoreModel> storeList = [];

  @override
  void initState() {
    super.initState();
    final box = Hive.box(buyurtmaBox);
    buyurtmaList = box.get(buyurtmaBox)?.cast<BuyurtmaModel>() ?? [];
    storeList = buyurtmaList[0].stores!;
  }

  @override
  Widget build(BuildContext context) {
    start = dateTimeRange.start;
    end = dateTimeRange.end;
    return AllDialogSkeleton(
        title: 'Hisobot',
        icon: 'assets/icons/ic_hisobot.svg',
        child: Column(
          children: [
            SizedBox(height: 23.h),
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () => showPicker(context, '1'),
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 15.w),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: cTextFieldColor),
                      height: 55,
                      alignment: Alignment.centerLeft,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            selected1 == null
                                ? "Сана 1"
                                : customFormat.format(selected1!),
                            style:
                                TextStyle(color: primaryColor, fontSize: 14.sp),
                          ),
                          const Icon(
                            Icons.arrow_drop_down_sharp,
                            color: primaryColor,
                          )
                        ],
                      ),
                    ),
                  ),
                  flex: 1,
                ),
                SizedBox(
                  width: 10.w,
                ),
                Visibility(
                  child: Expanded(
                    child: InkWell(
                      onTap: () => showPicker(context, '2'),
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 15.w),
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: cTextFieldColor),
                        height: 55,
                        alignment: Alignment.centerLeft,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              selected2 == null
                                  ? "Сана 2"
                                  : customFormat.format(selected2!),
                              style: TextStyle(
                                  color: primaryColor, fontSize: 14.sp),
                            ),
                            const Icon(
                              Icons.arrow_drop_down_sharp,
                              color: primaryColor,
                            )
                          ],
                        ),
                      ),
                    ),
                    flex: 1,
                  ),
                  visible: widget.sana != 1,
                ),
              ],
            ),

            ///mijoz
            Visibility(
              child: GestureDetector(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return SelectPart.screen();
                      }).then((value) => {
                        if (value != null)
                          {
                            setState(() {
                              clientId = value['id'];
                              clientName = value['name'].toString();
                            })
                          }
                      });
                },
                child: Container(
                  height: 60.h,
                  margin: EdgeInsets.only(top: 14.h),
                  padding: EdgeInsets.only(left: 18.w, right: 10.w),
                  decoration: BoxDecoration(
                      color: cTextFieldColor,
                      borderRadius: BorderRadius.circular(10.r)),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          clientName,
                          style: textStylePrimaryMed14,
                        ),
                      ),
                      SvgPicture.asset('assets/icons/ic_dropdown.svg')
                    ],
                  ),
                ),
              ),
              visible: widget.mijoz != 1,
            ),

            ///yuk beruvchi
            Visibility(
              child: GestureDetector(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return SelectYukBeruvchi.screen();
                      }).then((value) => {
                        if (value != null)
                          {
                            setState(() {
                              yukBeruvchiId = value['id'];
                              yukBeruvchiName = value['title'].toString();
                            })
                          }
                      });
                },
                child: Container(
                  height: 60.h,
                  margin: EdgeInsets.only(top: 14.h),
                  padding: EdgeInsets.only(left: 18.w, right: 10.w),
                  decoration: BoxDecoration(
                      color: cTextFieldColor,
                      borderRadius: BorderRadius.circular(10.r)),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          yukBeruvchiName,
                          style: textStylePrimaryMed14,
                        ),
                      ),
                      SvgPicture.asset('assets/icons/ic_dropdown.svg')
                    ],
                  ),
                ),
              ),
              visible: widget.yukYeruvchi != 1,
            ),

            ///ombor
            Visibility(
              child: Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 50.h,
                      child: ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemCount: storeList.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  storeGroup = index.toString();
                                  omborId = storeList[index].id!;
                                });
                              },
                              child: Row(
                                children: [
                                  Radio(
                                      value: '$index',
                                      groupValue: storeGroup,
                                      fillColor: MaterialStateProperty.all(
                                          primaryColor),
                                      activeColor: primaryColor,
                                      onChanged: (value) {
                                        setState(() {
                                          storeGroup = value.toString();
                                          omborId = storeList[index].id!;
                                        });
                                      }),
                                  Text(
                                    storeList[index].name ?? "",
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
              visible: widget.ombor != 1,
            ),

            /// maxsulot
            Visibility(
              child: GestureDetector(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return SelectPart.screen();
                      }).then((value) => {
                        if (value != null)
                          {
                            setState(() {
                              maxsulotId = value['id'];
                              maxsulotName = value['name'].toString();
                            })
                          }
                      });
                },
                child: Container(
                  margin: EdgeInsets.only(top: 14.h),
                  height: 60.h,
                  padding: EdgeInsets.only(left: 18.w, right: 10.w),
                  decoration: BoxDecoration(
                      color: cTextFieldColor,
                      borderRadius: BorderRadius.circular(10.r)),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          maxsulotName,
                          style: textStylePrimaryMed14,
                        ),
                      ),
                      SvgPicture.asset('assets/icons/ic_dropdown.svg')
                    ],
                  ),
                ),
              ),
              visible: widget.maxsulot != 1,
            ),

            SizedBox(height: 24.h),
            ElevatedButton(
              onPressed: () {
                if (widget.mijoz == 3 && clientId == 0) {
                  CustomToast.showToast('Mijozni tanlang!');
                } else if (widget.ombor == 3) {
                  CustomToast.showToast('Omborni tanlang!');
                } else if (widget.maxsulot == 3) {
                  CustomToast.showToast('Maxsulotni tanlang!');
                } else if (widget.yukYeruvchi == 3) {
                  CustomToast.showToast('Yuk beruvchini tanlang!');
                } else {
                  var params = {
                    'branch_id': int.parse(
                        sharedPreferences.getString(sharedBuyurtmaBranchId) ?? "0"),
                    "worker_id": int.parse(
                        sharedPreferences.getString(sharedSalesAgentId) ?? "0"),
                    "sana1": customFormat
                        .format(selected1 ?? DateTime.now())
                        .toString(),
                    "sana2": customFormat
                        .format(selected2 ?? DateTime.now())
                        .toString(),
                    "customer_id": clientId,
                    "store_id": omborId,
                    "product_id": maxsulotId,
                    "yuk_beruvchi": yukBeruvchiId,
                  };
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => WebViewExample(
                        url: widget.url,
                        params: params,
                      ),
                    ),
                  );
                }
              },
              style: buttonStyle,
              child: const Text(
                'Davom etish',
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ));
  }

  Future pickDateRange(BuildContext context) async {
    DateTimeRange? newDataRange = await showDateRangePicker(
        context: context,
        firstDate: DateTime(1900),
        initialDateRange: dateTimeRange,
        lastDate: DateTime(2200),
        builder: (context, child) {
          return Theme(
            data: ThemeData.light().copyWith(
              colorScheme: ColorScheme.fromSwatch(
                primarySwatch: Colors.indigo,
                primaryColorDark: Colors.indigo,
                accentColor: Colors.indigo,
              ),
              dialogBackgroundColor: Colors.white,
            ),
            child: child!,
          );
        });
    if (newDataRange == null) return;

    setState(() {
      dateTimeRange = newDataRange;
    });
  }

  DateTimeRange dateTimeRange =
      DateTimeRange(start: DateTime.now(), end: DateTime.now());

  Future<void> showPicker(BuildContext context, String a) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(
          DateTime.now().year, DateTime.now().month, DateTime.now().day),
      firstDate: DateTime(
          DateTime.now().year - 1, DateTime.now().month, DateTime.now().day),
      lastDate: DateTime(
          DateTime.now().year + 1, DateTime.now().month, DateTime.now().day),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: primaryColor,
            colorScheme: const ColorScheme.light(primary: primaryColor),
            buttonTheme:
                const ButtonThemeData(textTheme: ButtonTextTheme.primary),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && a == '1') {
      setState(() {
        selected1 = picked;
      });
    } else if (picked != null && a == '2') {
      setState(() {
        selected2 = picked;
      });
    }
  }
}
