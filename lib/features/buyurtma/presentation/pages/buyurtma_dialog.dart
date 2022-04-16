import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:savdo_agnet_client/core/utils/app_constants.dart';
import 'package:savdo_agnet_client/features/buyurtma/presentation/bloc/buyurtma_dialog_bloc.dart';
import 'package:savdo_agnet_client/features/product/presentation/pages/product_page.dart';
import 'package:savdo_agnet_client/features/select_client/presentation/pages/select_client.dart';

import '../../../../core/widgets/dialog_frame.dart';

class BuyurtmaDialog extends StatefulWidget {
  const BuyurtmaDialog({Key? key}) : super(key: key);

  static Widget screen() => BlocProvider(
        create: (context) => BuyurtmaDialogBloc(),
        child: const BuyurtmaDialog(),
      );

  @override
  _BuyurtmaDialogState createState() => _BuyurtmaDialogState();
}

class _BuyurtmaDialogState extends State<BuyurtmaDialog> {
  String group1 = 'So’m', group2 = 'Chakana';
  int clientId = 0;
  int clientQarzi = 0;
  int kurs = 11360;

  String clientName = 'Mijozni tanlang';
  late BuyurtmaDialogBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = BlocProvider.of<BuyurtmaDialogBloc>(context);
  }

  @override
  void dispose() {
    bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AllDialogSkeleton(
      title: 'Buyurtma',
      icon: 'assets/icons/ic_shopping_cart.svg',
      child: BlocBuilder<BuyurtmaDialogBloc, BuyurtmaDialogState>(
        builder: (context, state) {
          if (state is BuyurtmaDialogLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is BuyurtmaDialogFailureState) {
            return Center(
              child: Text(
                state.message,
                style: TextStyle(
                    fontFamily: 'Medium', fontSize: 16.sp, color: cGrayColor),
              ),
            );
          }
          if (state is BuyurtmaDialogSelectedSuccessState) {
            return SingleChildScrollView(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).size.height / 9),
                reverse: true,
                physics: const BouncingScrollPhysics(),
                controller: ScrollController(keepScrollOffset: false),
                child: Column(
                  children: [
                    SizedBox(height: 23.h),
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
                                    clientQarzi = value['qarz'];
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
                          right: 7.w, top: 22.h, left: 7.w, bottom: 34.h),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              'Qarzdorligi:',
                              style: textStylePrimaryMed16,
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                '-  ${state.qarzdorlik} so’m',
                                style: TextStyle(
                                    color: cOrangeColor,
                                    fontSize: 18.sp,
                                    fontFamily: 'Regular'),
                              ),
                              SizedBox(
                                height: 14.h,
                              ),
                              Text(
                                '-  ${state.qarzdorlik / state.kurs} \$',
                                style: TextStyle(
                                    color: cOrangeColor,
                                    fontSize: 18.sp,
                                    fontFamily: 'Regular'),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SvgPicture.asset('assets/icons/ic_divider.svg',
                        fit: BoxFit.cover),
                    // SizedBox(height: 25.h,),
                    Padding(
                      padding: EdgeInsets.only(
                          right: 7.w, top: 24.h, left: 7.w, bottom: 28.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text.rich(TextSpan(children: [
                            TextSpan(
                                text: 'Kurs: ', style: textStylePrimaryMed16),
                            TextSpan(
                                text: '${state.kurs} so’m',
                                style: TextStyle(
                                    fontFamily: 'Regular',
                                    fontSize: 18.sp,
                                    color: primaryColor)),
                          ])),
                        ],
                      ),
                    ),
                    SvgPicture.asset('assets/icons/ic_divider.svg',
                        fit: BoxFit.cover),
                    Padding(
                      padding: EdgeInsets.only(
                          right: 7.w, top: 24.h, left: 7.w, bottom: 14.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text('Narx turi:', style: textStylePrimaryMed16),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Radio(
                                value: 'So’m',
                                groupValue: group1,
                                fillColor:
                                    MaterialStateProperty.all(primaryColor),
                                activeColor: primaryColor,
                                onChanged: (value) {
                                  setState(() {
                                    group1 = value.toString();
                                  });
                                }),
                            Text('So’m', style: textStylePrimaryMed14),
                          ],
                        ),
                        SizedBox(width: 50.w),
                        Row(
                          children: [
                            Radio(
                                value: 'Valyuta',
                                groupValue: group1,
                                fillColor:
                                    MaterialStateProperty.all(primaryColor),
                                activeColor: primaryColor,
                                onChanged: (value) {
                                  setState(() {
                                    group1 = value.toString();
                                  });
                                }),
                            Text('Valyuta', style: textStylePrimaryMed14),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 5.h),
                    SvgPicture.asset('assets/icons/ic_divider.svg',
                        fit: BoxFit.cover),
                    Padding(
                      padding: EdgeInsets.only(
                          right: 7.w, top: 24.h, left: 7.w, bottom: 14.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text('Savdo turi:', style: textStylePrimaryMed16),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Radio(
                                value: 'Chakana',
                                groupValue: group2,
                                fillColor:
                                    MaterialStateProperty.all(primaryColor),
                                activeColor: primaryColor,
                                onChanged: (value) {
                                  setState(() {
                                    group2 = value.toString();
                                  });
                                }),
                            Text('Chakana', style: textStylePrimaryMed14),
                          ],
                        ),
                        Row(
                          children: [
                            Radio(
                                value: 'Ulgurji',
                                groupValue: group2,
                                fillColor:
                                    MaterialStateProperty.all(primaryColor),
                                activeColor: primaryColor,
                                onChanged: (value) {
                                  setState(() {
                                    group2 = value.toString();
                                  });
                                }),
                            Text('Ulgurji', style: textStylePrimaryMed14),
                          ],
                        ),
                        Row(
                          children: [
                            Radio(
                                value: 'Plastik',
                                groupValue: group2,
                                fillColor:
                                    MaterialStateProperty.all(primaryColor),
                                activeColor: primaryColor,
                                onChanged: (value) {
                                  setState(() {
                                    group2 = value.toString();
                                  });
                                }),
                            Text('Plastik', style: textStylePrimaryMed14),
                          ],
                        ),
                        SizedBox(width: 10.w),
                      ],
                    ),
                    SizedBox(height: 32.h),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProductPage.screen(),
                            ));
                      },
                      style: buttonStyle,
                      child: const Text(
                        'Mahsulotga o’tish',
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ));
          }
          return Center(
            child: Column(
              children: [
                SizedBox(
                    height: 310.h, child: const CupertinoActivityIndicator()),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProductPage.screen(),
                        ));
                  },
                  style: buttonStyle,
                  child: const Text(
                    'Mahsulotga o’tish',
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
