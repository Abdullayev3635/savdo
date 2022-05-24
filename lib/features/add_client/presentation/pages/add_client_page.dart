import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:savdo_agnet_client/core/utils/app_constants.dart';
import 'package:savdo_agnet_client/core/widgets/costum_toast.dart';
import 'package:savdo_agnet_client/features/add_client/data/model/add_client_model.dart';
import 'package:savdo_agnet_client/features/add_client/presentation/bloc/add_client_bloc.dart';
import 'package:savdo_agnet_client/features/select_viloyat/presentation/pages/select_viloyat_dialog.dart';

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
  int viloyatId = 0;
  String viloyatTitle = 'Viloyatni tanlang';
  late AddClientBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = BlocProvider.of<AddClientBloc>(context)..add(GetAllDataEvent());
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
        if (state is ClientAvailableState) {
          state.isAvailable == true
              ? {
                  CustomToast.showToast(
                      'Bunday ismli foydalanuvchi uje mavjud!'),
                  nameCon.clear()
                }
              : print('ok');
        }
        return Scaffold(
          appBar: appBarWidget(context, 'Mijoz qo’shish'),
          backgroundColor: cBackgroundColor,
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 23.w),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
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
                              controller: nameCon,
                              cursorColor: primaryColor,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Ism Familiya",
                                hintStyle: hintStyle,
                              ),
                              style: textStylePrimaryReg16,
                              onFieldSubmitted: (_){
                                bloc.add(FilterEvent(filterName: nameCon.text));
                              },
                              onEditingComplete: () {
                                bloc.add(FilterEvent(filterName: nameCon.text));
                              },
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
                          SvgPicture.asset('assets/icons/ic_call.svg',
                              width: 24.w, height: 24.h, color: primaryColor),
                          SizedBox(width: 18.w),
                          Text(
                            '+998',
                            style: hintStyle,
                          ),
                          Expanded(
                            child: TextFormField(
                              inputFormatters: [maskFormatter],
                              keyboardType: TextInputType.phone,
                              cursorColor: primaryColor,
                              controller: _telCon,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "(--)--- -- --",
                                hintStyle: hintStyle,
                                prefixIconConstraints: boxConstraintsTextField,
                              ),
                              style: textStylePrimaryReg16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 16.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Tug’ulgan sana',
                          style: textStylePrimaryReg16,
                        ),
                        Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.r),
                            color: cWhiteColor,
                          ),
                          height: 60.h,
                          width: MediaQuery.of(context).size.width / 1.8,
                          // margin: EdgeInsets.only(top: 16.h),
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
                  GestureDetector(
                    onTap: () {
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
                          SizedBox(
                            width: 18.w,
                          ),
                          Expanded(
                            child: Text(viloyatTitle,
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
                              cursorColor: primaryColor,
                              controller: _passwordCon,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Parol",
                                hintStyle: hintStyle,
                                prefixIconConstraints: boxConstraintsTextField,
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
                                prefixIconConstraints: boxConstraintsTextField,
                              ),
                              style: textStylePrimaryReg16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    overlayColor: MaterialStateProperty.all(Colors.transparent),
                    onTap: () {},
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
                                width: 24.w, height: 24.h, color: primaryColor),
                            SizedBox(width: 18.w),
                            Expanded(
                              child: TextFormField(
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
                        final m = AddClientModel(
                          name: nameCon.text,
                          login: _telCon.text,
                          address: addressCon.text,
                          coordinates: locationCon.text,
                          password: _passwordVerCon.text,
                          regionId: viloyatId,
                          phone1: _telCon.text,
                        );
                        List<AddClientModel> model = [];
                        model[0].name = 'sasasaa';
                        bloc.add(AddClientSendDataEvent(clientDataList: m));
                      },
                      style: buttonStyle,
                      child: const Text(
                        'Ro’yxatdan o’tkazish',
                        textAlign: TextAlign.center,
                      )),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  TextStyle hintStyle =
      TextStyle(fontSize: 16.sp, color: cHintTextColor, fontFamily: "Regular");
}
