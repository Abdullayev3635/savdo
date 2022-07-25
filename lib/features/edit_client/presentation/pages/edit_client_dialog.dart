import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geocoding/geocoding.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:savdo_agnet_client/core/utils/app_constants.dart';
import 'package:savdo_agnet_client/core/widgets/costum_toast.dart';
import 'package:savdo_agnet_client/core/widgets/drop_down_widget.dart';
import 'package:savdo_agnet_client/features/map_check/presentation/pages/map_check.dart';

import '../../../../core/widgets/dialog_frame.dart';
import '../../../../di/dependency_injection.dart';
import '../../../select_client/presentation/pages/select_client.dart';
import '../bloc/edit_client_bloc.dart';

class EditClientDialog extends StatefulWidget {
  const EditClientDialog({Key? key}) : super(key: key);

  static Widget screen() => BlocProvider(
        create: (context) => di<EditClientBloc>(),
        child: const EditClientDialog(),
      );

  @override
  _EditClientDialogState createState() => _EditClientDialogState();
}

class _EditClientDialogState extends State<EditClientDialog> {
  var maskFormatter = MaskTextInputFormatter(mask: '(##) ###-##-##');
  int clientId = 0;
  String coordinate = '';
  String phone1 = '';
  String clientName = 'Mijozni tanlang';
  String coordinateName = 'Mijozni tanlang';
  final TextEditingController tel = TextEditingController();
  final TextEditingController locationCon = TextEditingController();

  // List<Placemark> placemarks = [];
  // List<dynamic> json = [];
  double lat = 0;
  double lng = 0;
  late EditClientBloc bloc;

  @override
  void initState() {
    bloc = BlocProvider.of<EditClientBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditClientBloc, EditClientState>(
      builder: (context, state) {
        if (state is EditClientSuccess) {
          CustomToast.showToast('Yorvordik!');
        }
        return SingleChildScrollView(
          // controller: ScrollController(),
          padding: EdgeInsets.only(top: MediaQuery.of(context).size.height / 5),
          child: AllDialogSkeleton(
            title: 'Mijoz o’zgartirish',
            icon: 'assets/icons/ic_two_person.svg',
            child: Column(
              children: [
                SizedBox(height: 39.h),
                DropDownWidget(
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return SelectPart.screen();
                          }).then((value) => {
                            if (value != null)
                              {
                                clientId = value['id'],
                                clientName = value['name'].toString(),
                                coordinate = value['coordinate'],
                                phone1 = value['phone1'],
                                tel.text =
                                    maskFormatter.maskText(phone1).toString(),
                                _latLng(coordinate),
                              }
                          });
                    },
                    initialName: clientName),
                InkWell(
                  overlayColor: MaterialStateProperty.all(Colors.transparent),
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
                        color: cTextFieldColor),
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
                                prefixIconConstraints: boxConstraintsTextField,
                              ),
                              style: textStylePrimaryReg16,
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const MapCheck(),
                                    )).then((value) {
                                  if (value != null) {
                                    setState(() {
                                      locationCon.text =
                                          value['title'].toString();
                                      lat = double.parse(value["lat"]);
                                      lng = double.parse(value["lng"]);
                                      FocusManager.instance.primaryFocus
                                          ?.unfocus();
                                      // print(json);
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
                SizedBox(height: 16.h),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.r),
                    color: cTextFieldColor,
                  ),
                  height: 60.h,
                  padding: EdgeInsets.fromLTRB(15.w, 2.h, 5.w, 0.h),
                  child: Center(
                    child: Row(
                      children: [
                        SvgPicture.asset('assets/icons/ic_call.svg',
                            width: 24.w, height: 24.h, color: primaryColor),
                        SizedBox(width: 16.w),
                        Text(
                          '+998',
                          style: TextStyle(
                              fontSize: 16.sp,
                              color: cHintTextColor,
                              // color: cGrayColor,
                              fontFamily: "Regular"),
                        ),
                        Expanded(
                          child: TextFormField(
                            inputFormatters: [maskFormatter],
                            controller: tel,
                            keyboardType: TextInputType.phone,
                            cursorColor: primaryColor,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "(--)--- -- --",
                              hintStyle: TextStyle(
                                  fontSize: 16.sp,
                                  color: cHintTextColor,
                                  fontFamily: "Regular"),
                              prefixIconConstraints: BoxConstraints(
                                maxWidth: 30.w,
                                maxHeight: 30.h,
                                minHeight: 25.h,
                                minWidth: 25.w,
                              ),
                            ),
                            style: textStylePrimaryReg16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 16.h),
                ElevatedButton(
                  onPressed: () {
                    bloc.add(GetEditClientEvent(
                        phone1: '998' + maskFormatter.getUnmaskedText(),
                        coordinate: '[$lat,$lng]',
                        id: clientId));
                  },
                  style: buttonStyle,
                  child: const Text('Saqlash', textAlign: TextAlign.center),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  _latLng(String cor) async {
    print(cor);
    lat = double.parse(cor.split(',').removeAt(0).replaceAll('[', ''));
    lng = double.parse(cor.split(',').removeAt(1).replaceAll(']', ''));
    print(lat);
    print(lng);
    List<Placemark> placemarks =
        await placemarkFromCoordinates(71.654654132, 15.5642132);

    locationCon.text = placemarks[0].locality.toString() +
        ", " +
        (placemarks[0].thoroughfare ?? placemarks[0].street).toString();

    // setState(() {});
  }
}
