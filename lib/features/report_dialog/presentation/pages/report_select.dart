// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:savdo_agnet_client/core/utils/app_constants.dart';
import 'package:savdo_agnet_client/features/report_dialog/presentation/pages/report_dialog.dart';
import 'package:savdo_agnet_client/features/select_client/presentation/pages/select_client.dart';

import '../../../../core/widgets/dialog_frame.dart';
import '../widgets/report_radio_group_widget.dart';
import '../widgets/web_view.dart';

class ReportSelect extends StatefulWidget {
  const ReportSelect({Key? key}) : super(key: key);

  @override
  _ReportSelectState createState() => _ReportSelectState();
}

class _ReportSelectState extends State<ReportSelect> {
  String selectedValue = "1", url = "/mobile-wholesale-report";
  int mijoz = 2, yukYeruvchi = 1, ombor = 1, maxsulot = 1, sana = 2;

  @override
  Widget build(BuildContext context) {
    return AllDialogSkeleton(
        title: 'Hisobot',
        icon: 'assets/icons/ic_hisobot.svg',
        child: Column(
          children: [
            RadioListTile<String>(
              activeColor: primaryColor,
              value: "1",
              title:
                  Text("Ulguirji Savdo reestri", style: textStylePrimaryMed16),
              groupValue: selectedValue,
              onChanged: (value) => setState(
                () {
                  selectedValue = value.toString();
                  mijoz = 2;
                  yukYeruvchi = 1;
                  ombor = 1;
                  maxsulot = 1;
                  sana = 2;
                  url = "/mobile-wholesale-report";
                },
              ),
            ),
            RadioListTile<String>(
              activeColor: primaryColor,
              value: "2",
              title: Text("Mahsulot kirimi", style: textStylePrimaryMed16),
              groupValue: selectedValue,
              onChanged: (value) => setState(
                () {
                  selectedValue = value.toString();
                  mijoz = 1;
                  yukYeruvchi = 2;
                  ombor = 1;
                  maxsulot = 1;
                  sana = 2;
                  url = "/mobile-product-income";
                },
              ),
            ),
            RadioListTile<String>(
              activeColor: primaryColor,
              value: "3",
              title: Text("Mahsulot qoldigi", style: textStylePrimaryMed16),
              groupValue: selectedValue,
              onChanged: (value) => setState(
                () {
                  selectedValue = value.toString();
                  mijoz = 1;
                  yukYeruvchi = 1;
                  ombor = 2;
                  maxsulot = 1;
                  sana = 1;
                  url = "/mobile-product-residue-reports";
                },
              ),
            ),
            RadioListTile<String>(
              activeColor: primaryColor,
              value: "4",
              title: Text("Mahsulot aylanmasi", style: textStylePrimaryMed16),
              groupValue: selectedValue,
              onChanged: (value) => setState(
                () {
                  selectedValue = value.toString();
                  mijoz = 1;
                  yukYeruvchi = 1;
                  ombor = 1;
                  maxsulot = 2;
                  sana = 2;
                  url = "/mobile-product-circular-reports";
                },
              ),
            ),
            RadioListTile<String>(
              activeColor: primaryColor,
              value: "5",
              title: Text("Kassa qoldigi", style: textStylePrimaryMed16),
              groupValue: selectedValue,
              onChanged: (value) => setState(
                () {
                  selectedValue = value.toString();
                  mijoz = 1;
                  yukYeruvchi = 1;
                  ombor = 1;
                  maxsulot = 1;
                  sana = 2;
                  url = "/mobile-cash-report";
                },
              ),
            ),
            RadioListTile<String>(
              activeColor: primaryColor,
              value: "6",
              title:
                  Text("Mijoz DT-KT qoldiqlari", style: textStylePrimaryMed16),
              groupValue: selectedValue,
              onChanged: (value) => setState(
                () {
                  selectedValue = value.toString();
                  mijoz = 2;
                  yukYeruvchi = 1;
                  ombor = 1;
                  maxsulot = 1;
                  sana = 1;
                  url = "/mobile-customer-residue-reports";
                },
              ),
            ),
            RadioListTile<String>(
              activeColor: primaryColor,
              value: "7",
              title:
                  Text("Mijoz bilan akt sverka", style: textStylePrimaryMed16),
              groupValue: selectedValue,
              onChanged: (value) => setState(
                () {
                  selectedValue = value.toString();
                  mijoz = 2;
                  yukYeruvchi = 1;
                  ombor = 1;
                  maxsulot = 1;
                  sana = 2;
                  url = "/mobile-customer-sverka";
                },
              ),
            ),
            RadioListTile<String>(
              activeColor: primaryColor,
              value: "8",
              title: Text("Mijoz to'lovlari", style: textStylePrimaryMed16),
              groupValue: selectedValue,
              onChanged: (value) => setState(
                () {
                  selectedValue = value.toString();
                  mijoz = 2;
                  yukYeruvchi = 1;
                  ombor = 1;
                  maxsulot = 1;
                  sana = 2;
                  url = "/mobile-customer-payment-reports";
                },
              ),
            ),
            RadioListTile<String>(
              activeColor: primaryColor,
              value: "9",
              title: Text("Hodim aylanmasi", style: textStylePrimaryMed16),
              groupValue: selectedValue,
              onChanged: (value) => setState(
                () {
                  selectedValue = value.toString();
                  mijoz = 1;
                  yukYeruvchi = 1;
                  ombor = 1;
                  maxsulot = 1;
                  sana = 2;
                  url = "/mobile-worker-circular-reports";
                },
              ),
            ),
            SizedBox(height: 24.h),
            ElevatedButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return  ReportDialog(
                        mijoz: mijoz,
                        yukYeruvchi: yukYeruvchi,
                        ombor: ombor,
                        maxsulot: maxsulot,
                        sana: sana,
                        url: url,
                      );
                    });
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
}
