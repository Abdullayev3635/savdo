import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:savdo_agnet_client/core/utils/app_constants.dart';

const values = [
  'Qarz qoldiq',
  'Solishtirma dal',
  'Mijoz kartasi orqali',
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
          .map((value) => RadioListTile<String>(

              activeColor: primaryColor,
              value: value,
              title: Text(
                value,
                style: TextStyle(
                    color: primaryColor, fontSize: 16.sp, fontFamily: 'Medium'),
              ),
              groupValue: selectedValue,
              onChanged: (value) => setState(() {
                    selectedValue = value.toString();
                  })))
          .toList(),
    );
  }
}
