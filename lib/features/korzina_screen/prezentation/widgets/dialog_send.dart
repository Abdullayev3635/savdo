import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hive/hive.dart';
import 'package:pattern_formatter/numeric_formatter.dart';
import 'package:savdo_agnet_client/core/utils/app_constants.dart';
import 'package:savdo_agnet_client/features/korzina_screen/data/korzina_hive/tolov_hive.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/widgets/costum_toast.dart';
import '../../../../core/widgets/dialog_frame.dart';
import '../../../../core/widgets/drop_down_widget.dart';
import '../../../../di/dependency_injection.dart';
import '../../../buyurtma/data/model/buyurtma_model.dart';
import '../../../buyurtma/data/model/currency_model.dart';
import '../../../tulov_qilish/presentation/widgets/text_field_widget.dart';
import '../../../tulov_turi_dialog/presentation/pages/select_tulov_turi.dart';


// ignore: must_be_immutable
class SendDialog extends StatefulWidget {


  SendDialog({Key? key}) : super(key: key);

  @override
  State<SendDialog> createState() => _SendDialogState();
}

class _SendDialogState extends State<SendDialog> {
  SharedPreferences sharedPreferences = di.get();
  String tulovTuri = 'To’lov turi';
  int tulovTuriId = 0;

  String narxTuriGroup = '0';
  String currencyName = "So'm";
  int currencyId = 0;
  String kurs = "1";
  TextEditingController commentController = TextEditingController();
  TextEditingController summa = TextEditingController();
  List<BuyurtmaModel> buyurtmaList = [];
  List<CurrencyModel> currencyList = [];
  @override
  void initState() {
    super.initState();
    final box = Hive.box(buyurtmaBox);
    kurs = sharedPreferences.getString(sharedCurrencyValue) ?? '1';
    buyurtmaList = box.get(buyurtmaBox)?.cast<BuyurtmaModel>() ?? [];
    currencyList = buyurtmaList[0].currency!;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height / 10),
      reverse: true,
      physics: const BouncingScrollPhysics(),
      controller: ScrollController(keepScrollOffset: false),
      child: AllDialogSkeleton(
        title: 'Jo`natish!',
        icon: 'assets/icons/ic_shopping_cart.svg',
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 26.h),
            DropDownWidget(
              initialName: tulovTuri,
              onTap: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return SelectTulovTuri.screen();
                    }).then(
                  (value) => {
                    if (value != null)
                      setState(() {
                        tulovTuri = value['name'].toString();
                        tulovTuriId = value['id'];
                      }),
                  },
                );
              },
            ),
            Padding(
              padding: EdgeInsets.only(
                  right: 7.w, top: 24.h, left: 7.w, bottom: 28.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(text: 'Kurs: ', style: textStylePrimaryMed16),
                        TextSpan(
                          text: '$kurs so’m',
                          style: TextStyle(
                            fontFamily: 'Regular',
                            fontSize: 18.sp,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SvgPicture.asset('assets/icons/ic_divider.svg', fit: BoxFit.cover),
            TextFormField(
              controller: summa,
              keyboardType: TextInputType.number,
              cursorColor: primaryColor,
              inputFormatters: [
                ThousandsFormatter(allowFraction: true)
              ],
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Tolov Summa',
                hintStyle: textStyleHintColorReg14,
              ),
              style: textStylePrimaryReg16,
            ),
            TextFieldHintWidget(
                keyboardType: TextInputType.text,
                controller: commentController,
                hintText: 'Izoh'),
            SizedBox(height: 13.h),
            Padding(
              padding:
              EdgeInsets.only(right: 7.w, top: 4.h, left: 7.w, bottom: 7.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text('Narx turi:', style: textStylePrimaryMed16),
                ],
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 50.h,
                    child: ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemCount: currencyList.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                narxTuriGroup = index.toString();
                                currencyId = currencyList[index].id!;
                                currencyName = currencyList[index].name!;
                              });
                            },
                            child: Row(
                              children: [
                                Radio(
                                    value: '$index',
                                    groupValue: narxTuriGroup,
                                    fillColor:
                                    MaterialStateProperty.all(primaryColor),
                                    activeColor: primaryColor,
                                    onChanged: (value) {
                                      setState(() {
                                        narxTuriGroup = value.toString();
                                        kurs = currencyList[index].value!;
                                        currencyId = currencyList[index].id!;
                                        currencyName = currencyList[index].name!;
                                      });
                                    }),
                                Text(
                                  currencyList[index].name ?? "null",
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
            // SvgPicture.asset(
            //   'assets/icons/ic_divider.svg',
            // ),
            // Padding(
            //   padding: EdgeInsets.only(left: 10.w, bottom: 10.h, right: 10.w),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //     children: [
            //       Text('Jami summa:', style: textStylePrimaryMed16),
            //       Column(
            //         children: [
            //           Text('${jamiSumma.toStringAsFixed(2)} so\'m',
            //               style: textStylePrimaryMed16),
            //           Text('${jamiSummaVal.toStringAsFixed(2)} \$',
            //               style: textStylePrimaryMed16),
            //         ],
            //       ),
            //     ],
            //   ),
            // ),
            Container(
              margin: EdgeInsets.only(right: 10.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: ElevatedButton(
                        onPressed: () {
                          FocusManager.instance.primaryFocus?.unfocus();
                          Navigator.pop(context);
                        },
                        child: Text(
                          'Qaytish',
                          style: textStylePrimaryMed16,
                        ),
                        style: ButtonStyle(
                          fixedSize:
                              MaterialStateProperty.all(Size(155.w, 57.h)),
                          elevation: MaterialStateProperty.all(0),
                          backgroundColor: MaterialStateProperty.all(
                              primaryColor.withOpacity(0.1)),
                          shape:
                              MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          )),
                        )),
                    flex: 1,
                  ),
                  Flexible(
                    child: ElevatedButton(
                      style: buttonStyle,
                      onPressed: () {
                        if (summa.text != "") {
                          if(tulovTuriId!=0){
                            FocusManager.instance.primaryFocus?.unfocus();
                            final productAddKorzina = TolovHive(
                                id: 1,
                                cash: summa.text.replaceAll(",", ""),
                                currencyId: currencyId,
                                currencyName: currencyName,
                                currencyValue: kurs,
                                paymentTypeId: tulovTuriId,
                                paymentTypeName: tulovTuri,
                                description: commentController.text
                            );
                            final box = Hive.box<TolovHive>(tolovBox);
                            ///korzinaga qo'shyapti
                            box.add(productAddKorzina);
                            Navigator.pop(context);
                            CustomToast.showToast('Муваффакиятли сакланди');
                          }else {
                            CustomToast.showToast('To\'lo\'v turini tanlang!');
                          }
                        } else {
                          CustomToast.showToast('Summani kiriting!');
                        }
                      },
                      child: Text('Qo’shish',
                          style: TextStyle(
                              color: cWhiteColor,
                              fontSize: 16.sp,
                              fontFamily: 'Medium')),
                    ),
                    flex: 1,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}


///Chegirma
// Container(
//   margin: EdgeInsets.only(right: 0.w),
//   child: Row(
//     children: [
//       Flexible(
//         child: Container(
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(10.r),
//             color: cTextFieldColor,
//           ),
//           height: 60.h,
//           margin: EdgeInsets.only(top: 16.h),
//           padding: EdgeInsets.fromLTRB(15.w, 2.h, 0.w, 0.h),
//           child: TextFormField(
//             onChanged: (text) {
//               chegirmaSumma.text = "";
//               jamiSumma = widget.jamiSumma -
//                   (widget.jamiSumma * num.parse(text!=""?text:"0") / 100);
//               print(jamiSumma);
//               setState(() {});
//             },
//             controller: chegirmaFoiz,
//             keyboardType: TextInputType.number,
//             cursorColor: primaryColor,
//             decoration: InputDecoration(
//               border: InputBorder.none,
//               hintText: 'Chegirma %',
//               hintStyle: textStyleHintColorReg14,
//             ),
//             style: textStylePrimaryReg16,
//           ),
//         ),
//         flex: 1,
//       ),
//       const SizedBox(
//         width: 20,
//       ),
//       Flexible(
//         child: Container(
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(10.r),
//             color: cTextFieldColor,
//           ),
//           height: 60.h,
//           margin: EdgeInsets.only(top: 16.h),
//           padding: EdgeInsets.fromLTRB(15.w, 2.h, 0.w, 0.h),
//           child: TextFormField(
//             onChanged: (text) {
//               chegirmaFoiz.text = "";
//               jamiSumma = widget.jamiSumma - num.parse(text!=""?text:"0");
//               print(jamiSumma);
//               setState(() {});
//             },
//             controller: chegirmaSumma,
//             keyboardType: TextInputType.number,
//             cursorColor: primaryColor,
//             decoration: InputDecoration(
//               border: InputBorder.none,
//               hintText: 'Chegirma Summa',
//               hintStyle: textStyleHintColorReg14,
//             ),
//             style: textStylePrimaryReg16,
//           ),
//         ),
//         flex: 1,
//       ),
//     ],
//   ),
// ),