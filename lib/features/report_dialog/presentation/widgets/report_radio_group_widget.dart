import 'package:flutter/material.dart';
import 'package:savdo_agnet_client/core/utils/app_constants.dart';

const values = [
  "Ulguirji Savdo reestri",
  "Mahsulot kirimi",
  "Mahsulot qoldigi",
  "Mahsulot aylanmasi",
  "Kassa qoldigi",
  "Mijoz DT-KT qoldiqlari",
  "Mijoz bilan akt sverka",
  "Mijoz to'lovlari",
  "Hodim aylanmasi",
];
String selectedValue = values.first;

class ReportRadioGroupWidget extends StatefulWidget {
  const ReportRadioGroupWidget({Key? key}) : super(key: key);

  @override
  _ReportRadioGroupWidgetState createState() => _ReportRadioGroupWidgetState();
}

class _ReportRadioGroupWidgetState extends State<ReportRadioGroupWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: values
          .map(
            (value) => RadioListTile<String>(
              activeColor: primaryColor,
              value: value,
              title: Text(value, style: textStylePrimaryMed16),
              groupValue: selectedValue,
              onChanged: (value) => setState(
                () {
                  selectedValue = value.toString();
                },
              ),
            ),
          )
          .toList(),
    );
  }
}
