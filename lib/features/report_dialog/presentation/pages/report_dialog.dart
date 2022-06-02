// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:savdo_agnet_client/core/utils/app_constants.dart';
import 'package:savdo_agnet_client/features/select_client/presentation/pages/select_client.dart';

import '../../../../core/widgets/dialog_frame.dart';

class ReportDialog extends StatefulWidget {
  const ReportDialog({Key? key}) : super(key: key);

  @override
  _ReportDialogState createState() => _ReportDialogState();
}

class _ReportDialogState extends State<ReportDialog> {
  String group1 = 'Qarz qoldiq';
  var start;
  var end;
  int clientId = 0;
  String clientName = 'Mijozni tanlang';

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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  overlayColor: MaterialStateProperty.all(Colors.transparent),
                  onTap: () {
                    pickDateRange(context).then((value) => {setState(() {})});
                  },
                  child: Container(
                    height: 60.h,
                    width: MediaQuery.of(context).size.width / 2.5,
                    padding: EdgeInsets.only(left: 18.w, right: 10.w),
                    decoration: BoxDecoration(
                        color: cTextFieldColor,
                        borderRadius: BorderRadius.circular(10.r)),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                              '${start.day}/${start.month}/${start.year}',
                              style: textStylePrimaryMed14),
                        ),
                        SvgPicture.asset('assets/icons/ic_dropdown.svg')
                      ],
                    ),
                  ),
                ),
                InkWell(
                  overlayColor: MaterialStateProperty.all(Colors.transparent),
                  onTap: () {
                    pickDateRange(context).then((value) => {setState(() {})});
                  },
                  child: Container(
                    height: 60.h,
                    width: MediaQuery.of(context).size.width / 2.5,
                    padding: EdgeInsets.only(left: 18.w, right: 10.w),
                    decoration: BoxDecoration(
                        color: cTextFieldColor,
                        borderRadius: BorderRadius.circular(10.r)),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            '${end.day}/${end.month}/${end.year}',
                            style: textStylePrimaryReg14,
                          ),
                        ),
                        SvgPicture.asset('assets/icons/ic_dropdown.svg')
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.h),
            GestureDetector(
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
            SizedBox(
              height: 22.h,
            ),
            Row(
              children: [
                Radio(
                    value: 'Qarz qoldiq',
                    groupValue: group1,
                    fillColor: MaterialStateProperty.all(primaryColor),
                    activeColor: primaryColor,
                    onChanged: (value) {
                      setState(() {
                        group1 = value.toString();
                      });
                    }),
                Text('Qarz qoldiq', style: textStylePrimaryMed14),
              ],
            ),
            Row(
              children: [
                Radio(
                    value: 'Solishtirma dal',
                    groupValue: group1,
                    fillColor: MaterialStateProperty.all(primaryColor),
                    activeColor: primaryColor,
                    onChanged: (value) {
                      setState(() {
                        group1 = value.toString();
                      });
                    }),
                Text('Solishtirma dal', style: textStylePrimaryMed16),
              ],
            ),
            Row(
              children: [
                Radio(
                    value: 'Mijoz kartasi orqali',
                    groupValue: group1,
                    fillColor: MaterialStateProperty.all(primaryColor),
                    activeColor: primaryColor,
                    onChanged: (value) {
                      setState(() {
                        group1 = value.toString();
                      });
                    }),
                Text('Mijoz kartasi orqali', style: textStylePrimaryMed16),
              ],
            ),
            SizedBox(height: 24.h),
            ElevatedButton(
                onPressed: () {},
                style: buttonStyle,
                child: const Text(
                  'Davom etish',
                  textAlign: TextAlign.center,
                )),
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
}
