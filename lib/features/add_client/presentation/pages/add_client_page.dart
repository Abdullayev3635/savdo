import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:savdo_agnet_client/core/utils/app_constants.dart';
import 'package:savdo_agnet_client/core/widgets/costum_toast.dart';
import 'package:savdo_agnet_client/features/add_client/data/model/add_client_model.dart';
import 'package:savdo_agnet_client/features/add_client/presentation/bloc/add_client_bloc.dart';
import 'package:savdo_agnet_client/features/map_check/presentation/pages/map_check.dart';
import 'package:savdo_agnet_client/features/select_region/presentation/pages/select_region_dialog.dart';
import 'package:savdo_agnet_client/features/select_viloyat/presentation/pages/select_viloyat_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/widgets/appBarWidget.dart';
import '../../../../di/dependency_injection.dart';

class AddClientPage extends StatefulWidget {
  const AddClientPage({Key? key}) : super(key: key);

  static Widget screen() => BlocProvider(
        create: (context) => di<AddClientBloc>(),
        child: const AddClientPage(),
      );

  @override
  _AddClientPageState createState() => _AddClientPageState();
}

class _AddClientPageState extends State<AddClientPage> {
  var maskFormatter = MaskTextInputFormatter(mask: '(##) ###-##-##');
  var maskDateFormatter =
      MaskTextInputFormatter(mask: '##   /   ##   /   ####');
  final TextEditingController nameCon = TextEditingController();
  final TextEditingController birthdayCon = TextEditingController();
  final TextEditingController addressCon = TextEditingController();
  final TextEditingController locationCon = TextEditingController();
  final TextEditingController _telCon = TextEditingController();
  final TextEditingController _passwordCon = TextEditingController();
  final TextEditingController _passwordVerCon = TextEditingController();
  SharedPreferences sharedPreferences = di.get();
  int viloyatId = 0;
  String viloyatTitle = 'Viloyatni tanlang';
  int regionId = 0;
  double lat = 0;
  double lng = 0;
  String regionTitle = 'Regionni tanlang';
  late AddClientBloc bloc;
  bool isYuridik = false;

  @override
  void initState() {
    super.initState();
    bloc = BlocProvider.of<AddClientBloc>(context);
  }

  @override
  void dispose() {
    super.dispose();
    bloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddClientBloc, AddClientState>(
      builder: (context, state) {
        if (state is AddClientErrorState) {
          state.isSuccessAdded
              ? {
                  CustomToast.showToast('Mijoz muvvafaqiyatli saqlandi!'),
                  Navigator.pop(context),
                }
              : CustomToast.showToast('Qandaydur hatolik!');
        }
        return Scaffold(
            appBar: appBarWidget(context, 'Mijoz qo’shish'),
            backgroundColor: cBackgroundColor,
            body: Padding(
              padding: EdgeInsets.symmetric(horizontal: 23.w),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.r),
                          color: cWhiteColor,
                          boxShadow: [textFieldShadow]),
                      height: 60.h,
                      margin: EdgeInsets.only(top: 16.h),
                      padding: EdgeInsets.fromLTRB(15.w, 2.h, 15.w, 0.h),
                      child: Center(
                        child: Row(
                          children: [
                            SizedBox(width: 5.w),
                            Expanded(
                              child: FocusScope(
                                onFocusChange: (value) {
                                  if (!value) {
                                    if (nameCon.text.isNotEmpty) {
                                      bloc.add(ValidateNameClientEvent(
                                          validateNameModel: nameCon.text));
                                    }
                                  }
                                },
                                child: TextFormField(
                                  controller: nameCon,
                                  cursorColor: primaryColor,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "Ism Familiya",
                                    hintStyle: hintStyle,
                                  ),
                                  style: textStylePrimaryReg16,
                                  onEditingComplete: () {
                                    bloc.add(ValidateNameClientEvent(
                                        validateNameModel: nameCon.text));
                                  },
                                ),
                              ),
                            ),
                            state is ValidateNameLoadingState
                                ? const CupertinoActivityIndicator()
                                : Container(),
                            !state.isAvailableName
                                ? const Icon(Icons.error, color: Colors.red)
                                : Container()
                          ],
                        ),
                      ),
                    ),
                    Visibility(
                        visible: !state.isAvailableName,
                        child: Padding(
                          padding: EdgeInsets.only(top: 8.h),
                          child: Text(
                            'Bunday foydalanuvchi mavjud!',
                            style: TextStyle(
                                fontSize: 12.sp,
                                fontFamily: 'Regular',
                                color: Colors.red),
                          ),
                        )),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.r),
                        color: cWhiteColor,
                      ),
                      height: 60.h,
                      margin: EdgeInsets.only(top: 16.h),
                      padding: EdgeInsets.fromLTRB(20.w, 2.h, 15.w, 0.h),
                      child: Center(
                        child: Row(
                          children: [
                            SvgPicture.asset('assets/icons/ic_call.svg',
                                width: 24.w, height: 24.h, color: primaryColor),
                            SizedBox(width: 18.w),
                            Text('+998', style: hintStyle),
                            Expanded(
                              child: FocusScope(
                                onFocusChange: (value) {
                                  if (_telCon.text.isNotEmpty) {
                                    if (!value) {
                                      bloc.add(ValidatePhoneClientEvent(
                                        validatePhoneModel: '998' +
                                            maskFormatter.getUnmaskedText(),
                                      ));
                                    }
                                  }
                                },
                                child: TextFormField(
                                  inputFormatters: [maskFormatter],
                                  keyboardType: TextInputType.phone,
                                  cursorColor: primaryColor,
                                  controller: _telCon,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "(--)--- -- --",
                                    hintStyle: hintStyle,
                                    prefixIconConstraints:
                                        boxConstraintsTextField,
                                  ),
                                  style: textStylePrimaryReg16,
                                  onEditingComplete: () {
                                    bloc.add(ValidatePhoneClientEvent(
                                        validatePhoneModel: '998' +
                                            maskFormatter.getUnmaskedText()));
                                  },
                                ),
                              ),
                            ),
                            state is ValidatePhoneLoadingState
                                ? const CupertinoActivityIndicator()
                                : Container()
                          ],
                        ),
                      ),
                    ),
                    Visibility(
                        visible: !state.isAvailablePhone,
                        child: Padding(
                          padding: EdgeInsets.only(top: 8.h),
                          child: Text(
                              'Bu raqam oldin ham ro`yxatdan o`tkazilgan!',
                              style: TextStyle(
                                  fontSize: 12.sp,
                                  fontFamily: 'Regular',
                                  color: Colors.red)),
                        )),
                    Padding(
                      padding: EdgeInsets.only(top: 16.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Tug’ulgan sana', style: textStylePrimaryReg16),
                          Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.r),
                              color: cWhiteColor,
                            ),
                            height: 60.h,
                            width: MediaQuery.of(context).size.width / 1.8,
                            padding: EdgeInsets.fromLTRB(15.w, 2.h, 5.w, 0.h),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: MediaQuery.of(context).size.width / 3,
                                  child: TextFormField(
                                    controller: birthdayCon,
                                    inputFormatters: [maskDateFormatter],
                                    keyboardType: TextInputType.number,
                                    textAlign: TextAlign.left,
                                    cursorColor: primaryColor,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "Kun   /   Oy   /   Yil",
                                      hintStyle: hintStyle,
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
                    Container(
                      margin: EdgeInsets.only(top: 16.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        // mainAxisSize: MainAxisSize.min,
                        children: [
                          ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  isYuridik = false;
                                });
                              },
                              style: isYuridik
                                  ? inActiveButtonStyle
                                  : activeButtonStyle,
                              child: AutoSizeText(
                                'Jismoniy shaxs',
                                style: isYuridik
                                    ? textStylePrimaryReg16
                                    : inActiveTextStyle,
                              )),
                          ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  isYuridik = true;
                                });
                              },
                              style: isYuridik
                                  ? activeButtonStyle
                                  : inActiveButtonStyle,
                              child: AutoSizeText(
                                'Yuridik shaxs',
                                style: isYuridik
                                    ? inActiveTextStyle
                                    : textStylePrimaryReg16,
                              )),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        FocusManager.instance.primaryFocus?.unfocus();
                        showDialog(
                            context: context,
                            builder: (context) {
                              return SelectViloyat.screen();
                            }).then((value) => {
                              if (value != null)
                                {
                                  setState(() {
                                    viloyatId = value['id'];
                                    viloyatTitle = value['title'].toString();
                                  })
                                },
                            });
                      },
                      child: Container(
                        height: 60.h,
                        margin: EdgeInsets.only(top: 16.h),
                        padding: EdgeInsets.only(left: 20.w, right: 24.w),
                        decoration: BoxDecoration(
                            color: cWhiteColor,
                            borderRadius: BorderRadius.circular(10.r)),
                        child: Row(
                          children: [
                            SvgPicture.asset('assets/icons/ic_hudud.svg',
                                width: 24.w, height: 24.h),
                            SizedBox(width: 18.w),
                            Expanded(
                              child: Text(viloyatTitle,
                                  style: textStylePrimaryReg16),
                            ),
                            SvgPicture.asset('assets/icons/ic_dropdown.svg')
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        FocusManager.instance.primaryFocus?.unfocus();
                        showDialog(
                            context: context,
                            builder: (context) {
                              return SelectRegion.screen();
                            }).then((value) => {
                              if (value != null)
                                {
                                  setState(() {
                                    regionId = value['id'];
                                    regionTitle = value['title'].toString();
                                  })
                                },
                            });
                      },
                      child: Container(
                        height: 60.h,
                        margin: EdgeInsets.only(top: 16.h),
                        padding: EdgeInsets.only(left: 20.w, right: 24.w),
                        decoration: BoxDecoration(
                            color: cWhiteColor,
                            borderRadius: BorderRadius.circular(10.r)),
                        child: Row(
                          children: [
                            SvgPicture.asset('assets/icons/ic_hudud.svg',
                                width: 24.w, height: 24.h),
                            SizedBox(width: 18.w),
                            Expanded(
                              child: Text(regionTitle,
                                  style: textStylePrimaryReg16),
                            ),
                            SvgPicture.asset('assets/icons/ic_dropdown.svg')
                          ],
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.r),
                          color: cWhiteColor,
                          boxShadow: [textFieldShadow]),
                      height: 60.h,
                      margin: EdgeInsets.only(top: 16.h),
                      padding: EdgeInsets.fromLTRB(15.w, 2.h, 5.w, 0.h),
                      child: Center(
                        child: Row(
                          children: [
                            SizedBox(width: 5.w),
                            Expanded(
                              child: TextFormField(
                                controller: addressCon,
                                cursorColor: primaryColor,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Manzil",
                                  hintStyle: hintStyle,
                                ),
                                style: textStylePrimaryReg16,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.r),
                        color: cWhiteColor,
                      ),
                      height: 60.h,
                      margin: EdgeInsets.only(top: 16.h),
                      padding: EdgeInsets.fromLTRB(20.w, 2.h, 5.w, 0.h),
                      child: Center(
                        child: Row(
                          children: [
                            SvgPicture.asset('assets/icons/ic_lock.svg',
                                width: 24.w, height: 24.h, color: primaryColor),
                            SizedBox(width: 18.w),
                            Expanded(
                              child: TextFormField(
                                keyboardType: TextInputType.number,
                                obscuringCharacter: '•',
                                obscureText: true,
                                cursorColor: primaryColor,
                                controller: _passwordCon,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Parol",
                                  hintStyle: hintStyle,
                                  prefixIconConstraints:
                                      boxConstraintsTextField,
                                ),
                                style: textStylePrimaryReg16,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.r),
                        color: cWhiteColor,
                      ),
                      height: 60.h,
                      margin: EdgeInsets.only(top: 16.h),
                      padding: EdgeInsets.fromLTRB(20.w, 2.h, 5.w, 0.h),
                      child: Center(
                        child: Row(
                          children: [
                            SvgPicture.asset('assets/icons/ic_lock.svg',
                                width: 24.w, height: 24.h, color: primaryColor),
                            SizedBox(width: 18.w),
                            Expanded(
                              child: TextFormField(
                                cursorColor: primaryColor,
                                controller: _passwordVerCon,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Parolni tasdiqlang",
                                  hintStyle: hintStyle,
                                  prefixIconConstraints:
                                      boxConstraintsTextField,
                                ),
                                style: textStylePrimaryReg16,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      overlayColor:
                          MaterialStateProperty.all(Colors.transparent),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const MapCheck(),
                            )).then((value) {
                          if (value != null) {
                            setState(() {
                              locationCon.text = value['title'].toString();
                              lat = double.parse(value["lat"]);
                              lng = double.parse(value["lng"]);
                              FocusManager.instance.primaryFocus?.unfocus();
                            });
                          }
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.r),
                          color: cWhiteColor,
                        ),
                        height: 60.h,
                        margin: EdgeInsets.only(top: 16.h),
                        padding: EdgeInsets.fromLTRB(20.w, 2.h, 5.w, 0.h),
                        child: Center(
                          child: Row(
                            children: [
                              SvgPicture.asset('assets/icons/ic_gps.svg',
                                  width: 24.w,
                                  height: 24.h,
                                  color: primaryColor),
                              SizedBox(width: 18.w),
                              Expanded(
                                child: TextFormField(
                                  readOnly: true,
                                  cursorColor: primaryColor,
                                  controller: locationCon,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "Joylashuv qo’shish",
                                    hintStyle: hintStyle,
                                    prefixIconConstraints:
                                        boxConstraintsTextField,
                                  ),
                                  style: textStylePrimaryReg16,
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const MapCheck(),
                                        )).then((value) {
                                      if (value != null) {
                                        setState(() {
                                          locationCon.text =
                                              value['title'].toString();
                                          lat = double.parse(value["lat"]);
                                          lng = double.parse(value["lng"]);
                                          FocusManager.instance.primaryFocus
                                              ?.unfocus();
                                        });
                                      }
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 32.h),
                    ElevatedButton(
                      onPressed: () {
                        if (_passwordCon.text == _passwordVerCon.text &&
                            regionTitle != 'Regionni tanlang' &&
                            viloyatTitle != 'Viloyatni tanlang' &&
                            addressCon.text.isNotEmpty &&
                            locationCon.text.isNotEmpty &&
                            birthdayCon.text.isNotEmpty &&
                            nameCon.text.isNotEmpty) {
                          final m = AddClientModel(
                            salesAgentId: int.parse(sharedPreferences
                                    .getString(sharedSalesAgentId) ??
                                ''),
                            legalPhysical: isYuridik ? 2 : 1,
                            name: nameCon.text,
                            login: maskFormatter.getUnmaskedText(),
                            address: addressCon.text,
                            coordinates: '[$lat, $lng]',
                            password: _passwordVerCon.text,
                            regionId: regionId,
                            phone1: maskFormatter.getUnmaskedText(),
                            stateId: viloyatId,
                          );
                          bloc.add(AddClientSendDataEvent(clientDataList: m));
                        } else {
                          _passwordVerCon.clear();
                          _passwordCon.clear();
                          CustomToast.showToast('Parol noto`g`ri terilgan!');
                        }
                      },
                      style: buttonStyle,
                      child: const Text('Ro’yxatdan o’tkazish',
                          textAlign: TextAlign.center),
                    ),
                    SizedBox(height: 32.h),
                  ],
                ),
              ),
            ));
      },
    );
  }
}
