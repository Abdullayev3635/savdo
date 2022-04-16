import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:savdo_agnet_client/core/utils/app_constants.dart';
import 'package:savdo_agnet_client/core/widgets/drop_down_widget.dart';
import 'package:savdo_agnet_client/features/select_client/presentation/pages/select_client.dart';
import 'package:savdo_agnet_client/features/tulov_qilish/presentation/widgets/text_field_widget.dart';

import '../../../../core/widgets/dialog_frame.dart';

class TulovQilishDialog extends StatefulWidget {
  const TulovQilishDialog({Key? key}) : super(key: key);

  @override
  _TulovQilishDialogState createState() => _TulovQilishDialogState();
}

class _TulovQilishDialogState extends State<TulovQilishDialog> {
  int clientId = 0;
  String clientName = 'Mijozni tanlang';
  String tulovTuri = 'To’lov turi';
  TextEditingController summaniKiritungController = TextEditingController();
  TextEditingController izohController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height / 9),
      reverse: true,
      physics: const BouncingScrollPhysics(),
      controller: ScrollController(keepScrollOffset: false),
      child: AllDialogSkeleton(
          title: 'To’lov qilish',
          icon: 'assets/icons/ic_dollar_circle.svg',
          child: Column(
            children: [
              SizedBox(height: 23.h),
              DropDownWidget(
                initialName: clientName,
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return SelectPart.screen();
                      }).then(
                    (value) => {
                      if (value != null)
                        {
                          setState(() {
                            clientId = value['id'];
                            clientName = value['name'].toString();
                          })
                        }
                    },
                  );
                },
              ),
              Padding(
                padding: EdgeInsets.only(
                    right: 7.w, top: 22.h, left: 7.w, bottom: 34.h),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text('Qarzdorligi:', style: textStylePrimaryMed16),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text('-  1 000 000 so’m', style: textStyleOrangeReg18),
                        SizedBox(height: 14.h),
                        Text('-  100 \$', style: textStyleOrangeReg18),
                      ],
                    ),
                  ],
                ),
              ),
              DropDownWidget(
                initialName: tulovTuri,
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return SelectPart.screen();
                      }).then(
                    (value) => {
                      if (value != null)
                        {
                          setState(() {
                            tulovTuri = value['name'].toString();
                          })
                        }
                    },
                  );
                },
              ),
              TextFieldHintWidget(
                  keyboardType: TextInputType.number,
                  controller: summaniKiritungController,
                  hintText: 'Summani kiriting'),
              Container(
                margin: EdgeInsets.only(top: 16.h),
                padding: EdgeInsets.fromLTRB(0.w, 2.h, 5.w, 0.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.r),
                        color: cTextFieldColor,
                      ),
                      height: 60.h,
                      width: MediaQuery.of(context).size.width / 2.5,
                      // margin: EdgeInsets.only(top: 16.h),
                      padding: EdgeInsets.fromLTRB(15.w, 2.h, 5.w, 0.h),
                      child: Center(
                        child: Row(
                          children: [
                            SizedBox(width: 5.w),
                            SizedBox(
                              width: 130.w,
                              child: TextFormField(
                                  keyboardType: TextInputType.number,
                                  cursorColor: primaryColor,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "Summa so’m",
                                    hintStyle: textStyleHintColorReg14,
                                  ),
                                  style: textStylePrimaryReg16),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.r),
                        color: cTextFieldColor,
                      ),
                      height: 60.h,
                      width: MediaQuery.of(context).size.width / 2.5,
                      padding: EdgeInsets.fromLTRB(15.w, 2.h, 5.w, 0.h),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(width: 5.w),
                          SizedBox(
                            width: 130.w,
                            child: TextFormField(
                              keyboardType: TextInputType.number,
                              cursorColor: primaryColor,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Summa valyuta",
                                hintStyle: textStyleHintColorReg14,
                              ),
                              style: textStylePrimaryReg16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              TextFieldHintWidget(
                  keyboardType: TextInputType.text,
                  controller: izohController,
                  hintText: 'Izoh'),
              SizedBox(height: 24.h),
              ElevatedButton(
                  onPressed: () {},
                  style: buttonStyle,
                  child: const Text(
                    'Davom etish',
                    textAlign: TextAlign.center,
                  )),
            ],
          )),
    );
  }
}

TextStyle textStyleOrangeReg18 =
    TextStyle(color: cOrangeColor, fontSize: 18.sp, fontFamily: 'Regular');
