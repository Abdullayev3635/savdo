import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hive/hive.dart';
import 'package:pattern_formatter/numeric_formatter.dart';
import 'package:savdo_agnet_client/core/utils/app_constants.dart';
import 'package:savdo_agnet_client/core/widgets/costum_toast.dart';
import 'package:savdo_agnet_client/core/widgets/drop_down_widget.dart';
import 'package:savdo_agnet_client/di/dependency_injection.dart';
import 'package:savdo_agnet_client/features/select_client/presentation/pages/select_client.dart';
import 'package:savdo_agnet_client/features/tulov_qilish/presentation/bloc/qarizdorlik_bloc/tulov_qarizdorlik_bloc.dart';
import 'package:savdo_agnet_client/features/tulov_qilish/presentation/widgets/read_text_field.dart';
import 'package:savdo_agnet_client/features/tulov_qilish/presentation/widgets/text_field_widget.dart';
import 'package:savdo_agnet_client/features/tulov_turi_dialog/presentation/pages/select_tulov_turi.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/widgets/dialog_frame.dart';
import '../../../buyurtma/data/model/buyurtma_model.dart';
import '../../../buyurtma/data/model/currency_model.dart';

class TulovQilishDialog extends StatefulWidget {
  const TulovQilishDialog({Key? key}) : super(key: key);

  static Widget screen() => BlocProvider(
        create: (context) => di<TulovQarizdorlikBloc>(),
        child: const TulovQilishDialog(),
      );

  @override
  _TulovQilishDialogState createState() => _TulovQilishDialogState();
}

class _TulovQilishDialogState extends State<TulovQilishDialog> {
  int clientId = 0;
  String clientName = 'Mijozni tanlang';
  String tulovTuri = 'To’lov turi';
  int tulovTuriId = 0;
  TextEditingController addSumControl = TextEditingController();
  TextEditingController addSumController = TextEditingController();
  TextEditingController izohController = TextEditingController();
  TextEditingController tulovSum = TextEditingController();
  TextEditingController tulovVal = TextEditingController();
  late TulovQarizdorlikBloc qarzdorlikBloc;
  SharedPreferences sharedPreferences = di.get();
  late String kurs;
  List<CurrencyModel>? currencyList = [];

  List<BuyurtmaModel> buyurtmaList = [];

  String narxTuriGroup = "0";
  int currencyId = 0;
  String currencyName = "";

  @override
  void initState() {
    final box = Hive.box(buyurtmaBox);
    buyurtmaList = box.get(buyurtmaBox)?.cast<BuyurtmaModel>() ?? [];
    currencyList = buyurtmaList[0].currency;
    qarzdorlikBloc = BlocProvider.of<TulovQarizdorlikBloc>(context);
    kurs = currencyList![0].value!;
    super.initState();
  }

  @override
  void dispose() {
    qarzdorlikBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.only(
        bottom: clientName == 'Mijozni tanlang'
            ? MediaQuery.of(context).size.height / 6
            : MediaQuery.of(context).size.height / 10,
      ),
      reverse: true,
      physics: const BouncingScrollPhysics(),
      controller: ScrollController(keepScrollOffset: false),
      child: AllDialogSkeleton(
          title: 'To’lov qilish',
          icon: 'assets/icons/ic_dollar_circle.svg',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BlocBuilder<TulovQarizdorlikBloc, TulovQarizdorlikState>(
                builder: (context, state) {
                  if (state is TulovQarizdorlikInitial) {
                    return Column(
                      children: [
                        SizedBox(height: 23.h),
                        GestureDetector(
                          onTap: () => showDialog(
                              context: context,
                              builder: (context) {
                                return SelectPart.screen();
                              }).then((value) => {
                                if (value != null)
                                  {
                                    setState(() {
                                      clientId = value['id'];
                                      clientName = value['name'].toString();
                                      qarzdorlikBloc.add(
                                        TulovClientSelectedEvent(
                                          customerId: clientId,
                                          salesAgentId: int.parse(
                                              sharedPreferences.getString(
                                                      sharedSalesAgentId) ??
                                                  ''),
                                        ),
                                      );
                                    }),
                                  },
                              }),
                          child: Container(
                            height: 60.h,
                            padding: EdgeInsets.only(left: 18.w, right: 10.w),
                            decoration: BoxDecoration(
                                color: cTextFieldColor,
                                borderRadius: BorderRadius.circular(10.r)),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(clientName,
                                      style: textStylePrimaryMed14),
                                ),
                                SvgPicture.asset('assets/icons/ic_dropdown.svg')
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 16.h),
                      ],
                    );
                  } else if (state is TulovCreatedState) {
                    CustomToast.showToast(state.message);
                    Navigator.pop(context);
                    return Container();
                  } else if (state is TulovQarizdorlikLoading) {
                    return SizedBox(
                        child:
                            const Center(child: CupertinoActivityIndicator()),
                        height: 200.h);
                  } else if (state is TulovQarizdorlikLoadedState) {
                    return Column(
                      children: [
                        SizedBox(height: 23.h),
                        GestureDetector(
                          onTap: () => showDialog(
                              context: context,
                              builder: (context) {
                                return SelectPart.screen();
                              }).then((value) => {
                                if (value != null)
                                  {
                                    setState(() {
                                      clientId = value['id'];
                                      clientName = value['name'].toString();
                                      qarzdorlikBloc.add(
                                        TulovClientSelectedEvent(
                                          customerId: clientId,
                                          salesAgentId: int.parse(
                                              sharedPreferences.getString(
                                                      sharedSalesAgentId) ??
                                                  ''),
                                        ),
                                      );
                                    }),
                                  },
                              }),
                          child: Container(
                            height: 60.h,
                            padding: EdgeInsets.only(left: 18.w, right: 10.w),
                            decoration: BoxDecoration(
                                color: cTextFieldColor,
                                borderRadius: BorderRadius.circular(10.r)),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(clientName,
                                      style: textStylePrimaryMed14),
                                ),
                                SvgPicture.asset('assets/icons/ic_dropdown.svg')
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              right: 7.w, top: 22.h, left: 7.w, bottom: 24.h),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                flex: 3,
                                child: Text('Qarzdorligi: ',
                                    style: textStylePrimaryMed16),
                              ),
                              Expanded(
                                child: SizedBox(
                                  height: 60,
                                  child: ListView.builder(
                                    physics: const BouncingScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: state.debitList.length,
                                    itemBuilder: (context, index) {
                                      return state.debitList[index].value! < 0
                                          ? Text(
                                              "${state.debitList[index].value} ${state.debitList[index].name}",
                                              style: TextStyle(
                                                  color: cOrangeColor,
                                                  fontSize: 18.sp,
                                                  fontFamily: 'Regular'),
                                            )
                                          : Text(
                                              "${state.debitList[index].value} ${state.debitList[index].name}",
                                              style: TextStyle(
                                                  color: primaryColor,
                                                  fontSize: 18.sp,
                                                  fontFamily: 'Regular'));
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  } else {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 23.h),
                        GestureDetector(
                          onTap: () => showDialog(
                              context: context,
                              builder: (context) {
                                return SelectPart.screen();
                              }).then((value) => {
                                if (value != null)
                                  {
                                    setState(() {
                                      clientId = value['id'];
                                      clientName = value['name'].toString();
                                    }),
                                  },
                              }),
                          child: Container(
                            height: 60.h,
                            padding: EdgeInsets.only(left: 18.w, right: 10.w),
                            decoration: BoxDecoration(
                                color: cTextFieldColor,
                                borderRadius: BorderRadius.circular(10.r)),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(clientName,
                                      style: textStylePrimaryMed14),
                                ),
                                SvgPicture.asset('assets/icons/ic_dropdown.svg')
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              right: 7.w, top: 22.h, left: 7.w, bottom: 24.h),
                          child: Text('Qarzdorligi: 0',
                              style: textStylePrimaryMed16),
                        ),
                      ],
                    );
                  }
                },
              ),
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
                          addSumController.clear();
                          tulovSum.clear();
                          tulovVal.clear();
                        }),
                    },
                  );
                },
              ),
              SizedBox(height: 16.h),
              Text('Kurs: $kurs so’m', style: textStylePrimaryReg16),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r),
                  color: cTextFieldColor,
                ),
                height: 60.h,
                margin: EdgeInsets.only(top: 16.h),
                padding: EdgeInsets.fromLTRB(15.w, 2.h, 5.w, 0.h),
                child: Center(
                  child: Row(
                    children: [
                      SizedBox(width: 5.w),
                      Expanded(
                        child: TextFormField(
                          onChanged: (text) {
                            if (tulovTuriId >= 1 && tulovTuriId <= 3) {
                              tulovSum.text = addSumController.text;
                            } else if (tulovTuriId == 4) {
                              tulovVal.text = addSumController.text;
                            } else if (tulovTuriId == 5 ||
                                tulovTuriId >= 9 && tulovTuriId <= 11) {
                              tulovVal.text = sumToVal(addSumController.text)
                                  .toStringAsFixed(3);
                            } else if (tulovTuriId >= 6 && tulovTuriId <= 8) {
                              tulovSum.text =
                                  valToSum(addSumController.text).toString();
                            }
                            addSumController.text =
                                spaceForNumber(addSumController.text)
                                    .toString();
                            addSumController.selection =
                                TextSelection.fromPosition(TextPosition(
                                    offset: addSumController.text.length));
                          },
                          readOnly: tulovTuri == 'To’lov turi',
                          inputFormatters: [
                            ThousandsFormatter(allowFraction: true)
                          ],
                          controller: addSumController,
                          keyboardType: TextInputType.number,
                          cursorColor: primaryColor,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Summani kiriting',
                            hintStyle: textStyleHintColorReg14,
                          ),
                          style: textStylePrimaryReg16,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 16.h),
                padding: EdgeInsets.fromLTRB(0.w, 2.h, 5.w, 0.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ReadSumOrValWidget(
                        tulovVal: tulovSum, hintText: 'Summa so’m'),
                    ReadSumOrValWidget(
                        tulovVal: tulovVal, hintText: 'Summa valyuta'),
                  ],
                ),
              ),
              TextFieldHintWidget(
                  keyboardType: TextInputType.text,
                  controller: izohController,
                  hintText: 'Izoh'),
              SizedBox(height: 24.h),
              const Divider(),
              Padding(
                padding: EdgeInsets.only(
                    right: 7.w, top: 4.h, left: 7.w, bottom: 7.h),
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
                          itemCount: currencyList!.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  narxTuriGroup = index.toString();
                                  currencyId = currencyList![index].id!;
                                  currencyName = currencyList![index].name!;
                                });
                              },
                              child: Row(
                                children: [
                                  Radio(
                                      value: '$index',
                                      groupValue: narxTuriGroup,
                                      fillColor: MaterialStateProperty.all(
                                          primaryColor),
                                      activeColor: primaryColor,
                                      onChanged: (value) {
                                        setState(() {
                                          narxTuriGroup = value.toString();
                                          kurs =
                                              currencyList![index].value ?? "0";
                                        });
                                      }),
                                  Text(
                                    (currencyList![index].name ?? "null") +
                                        " (" +
                                        (currencyList![index]
                                            .value
                                            .toString()) +
                                        ")",
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
              ElevatedButton(
                style: buttonStyle,
                child: const Text('Davom etish', textAlign: TextAlign.center),
                onPressed: () {
                  if (clientName != 'Mijozni tanlang') {
                    if (tulovTuri != 'To’lov turi') {
                      if (addSumController.text.isNotEmpty) {
                        qarzdorlikBloc.add(TulovQilishEvent(
                          salesAgentId: int.parse(
                              sharedPreferences.getString(sharedSalesAgentId) ??
                                  ''),
                          customerId: clientId,
                          currencyId:
                              currencyList![int.parse(narxTuriGroup)].id ?? 1,
                          branchId: int.parse(
                              sharedPreferences.getString(sharedBranchId) ??
                                  ''),
                          currencyValue: int.parse(kurs == "" ? "0" : kurs),
                          paymentTypeId: tulovTuriId,
                          summa: (tulovSum.text.isNotEmpty
                              ? notSpaceForNumber(tulovSum.text)
                              : notSpaceForNumber(tulovVal.text)),
                          paymentAmount: notSpace(addSumController.text),
                          description: izohController.text,
                        ));
                      } else {
                        CustomToast.showToast('Summani kiriting');
                      }
                    } else {
                      CustomToast.showToast('To’lov turini tanlang');
                    }
                  } else {
                    CustomToast.showToast('Mijozni tanlang');
                  }
                  FocusManager.instance.primaryFocus?.unfocus();
                },
              ),
            ],
          )),
    );
  }

  double sumToVal(String sum) {
    if (sum.isNotEmpty) {
      double som = double.parse(sum.replaceAll(',', ''));
      return (som / double.parse(kurs));
    } else {
      return 0;
    }
  }

  String spaceForNumber(String number) {
    if (number.isNotEmpty) {
      var value = number.replaceAll(',', ' ');
      return value;
    } else {
      return '0';
    }
  }

  double notSpaceForNumber(String number) {
    if (number.isNotEmpty) {
      var value = double.parse(number.replaceAll(',', ''));
      return value;
    } else {
      return 0.0;
    }
  }

  double notSpace(String number) {
    if (number.isNotEmpty) {
      var value = double.parse(number.replaceAll(' ', ''));
      return value;
    } else {
      return 0.0;
    }
  }

  int valToSum(String val) {
    if (val.isNotEmpty) {
      int value = int.parse(val.replaceAll(',', ''));
      return int.parse(kurs) * value;
    } else {
      return 0;
    }
  }
}
