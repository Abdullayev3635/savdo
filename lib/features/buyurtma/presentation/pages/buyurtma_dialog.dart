import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:savdo_agnet_client/core/utils/app_constants.dart';
import 'package:savdo_agnet_client/features/buyurtma/data/model/currency_model.dart';
import 'package:savdo_agnet_client/features/buyurtma/data/model/price_type_model.dart';
import 'package:savdo_agnet_client/features/buyurtma/presentation/bloc/buyurtma_bloc/buyurtma_dialog_bloc.dart';
import 'package:savdo_agnet_client/features/buyurtma/presentation/bloc/qarizdorlik_bloc/qarizdorlik_bloc.dart';
import 'package:savdo_agnet_client/features/product/presentation/pages/product_page.dart';
import 'package:savdo_agnet_client/features/select_client/presentation/pages/select_client.dart';

import '../../../../core/widgets/dialog_frame.dart';
import '../../../../di/dependency_injection.dart';

class BuyurtmaDialog extends StatefulWidget {
  const BuyurtmaDialog({Key? key}) : super(key: key);

  static Widget screen() => MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) =>
                di<BuyurtmaDialogBloc>()..add(BuyurtmaInitialEvent()),
          ),
          BlocProvider(create: (context) => di<QarizdorlikBloc>()),
        ],
        child: const BuyurtmaDialog(),
      );

  @override
  _BuyurtmaDialogState createState() => _BuyurtmaDialogState();
}

class _BuyurtmaDialogState extends State<BuyurtmaDialog> {
  String group1 = 'So’m', group2 = 'Chakana';
  int clientId = 0;
  int clientQarzi = 0;
  String kurs = "0";

  String clientName = 'Mijozni tanlang';
  late BuyurtmaDialogBloc dialogBloc;
  late QarizdorlikBloc qarizdorlikBloc;

  @override
  void initState() {
    super.initState();
    dialogBloc = BlocProvider.of<BuyurtmaDialogBloc>(context);
    qarizdorlikBloc = BlocProvider.of<QarizdorlikBloc>(context);
  }

  @override
  void dispose() {
    dialogBloc.close();
    qarizdorlikBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AllDialogSkeleton(
      title: 'Buyurtma',
      icon: 'assets/icons/ic_shopping_cart.svg',
      child: Column(
        children: [
          BlocBuilder<QarizdorlikBloc, QarizdorlikState>(
            builder: (context, state) {
              if (state is QarizdorlikInitial) {
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
                                  qarizdorlikBloc.add(ClientSelectedEvent(
                                      customerId: clientId, salesAgentId: 1));
                                })
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
                  ],
                );
              } else if (state is QarizdorlikLoading) {
                return SizedBox(
                    child: const Center(child: CupertinoActivityIndicator()),
                    height: 200.h);
              } else if (state is QarizdorlikLoaded) {
                return Column(
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
                                  })
                                },
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
                          right: 7.w, top: 22.h, left: 7.w, bottom: 24.h),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            flex: 3,
                            child: Text(
                              'Qarzdorligi:',
                              style: textStylePrimaryMed16,
                            ),
                          ),
                          Expanded(
                            child: Container(
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
                    SvgPicture.asset('assets/icons/ic_divider.svg',
                        fit: BoxFit.cover),
                  ],
                );
              } else {
                return Container();
              }
            },
          ),
          BlocBuilder<BuyurtmaDialogBloc, BuyurtmaDialogState>(
            builder: (context, state) {
              if (state is BuyurtmaDialogSelectedSuccessState) {
                List<CurrencyModel>? currencyList =
                    state.buyurtmaList[0].currency;
                List<PriceTypeModel>? priceTypeList =
                    state.buyurtmaList[0].priceType;

                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
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
                                text: '$kurs so’m',
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
                      children: [
                        Expanded(
                          child: SizedBox(
                            height: 50.h,
                            child: ListView.builder(
                                physics: const BouncingScrollPhysics(),
                                scrollDirection: Axis.horizontal,
                                shrinkWrap: true,
                                itemCount: currencyList?.length,
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        group1 = '$index';
                                      });
                                    },
                                    child: Row(
                                      children: [
                                        Radio(
                                            value: '$index',
                                            groupValue: group1,
                                            fillColor:
                                                MaterialStateProperty.all(
                                                    primaryColor),
                                            activeColor: primaryColor,
                                            onChanged: (value) {
                                              setState(() {
                                                group1 = value.toString();
                                                kurs = currencyList![index]
                                                        .value ??
                                                    "0";
                                              });
                                            }),
                                        Text(
                                            currencyList![index].name ?? "null",
                                            style: textStylePrimaryMed14),
                                      ],
                                    ),
                                  );
                                }),
                          ),
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
                      children: [
                        Expanded(
                          child: SizedBox(
                            height: 50.h,
                            child: ListView.builder(
                                physics: const BouncingScrollPhysics(),
                                scrollDirection: Axis.horizontal,
                                shrinkWrap: true,
                                itemCount: priceTypeList?.length,
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        group2 = '$index';
                                      });
                                    },
                                    child: Row(
                                      children: [
                                        Radio(
                                            value: '$index',
                                            groupValue: group2,
                                            fillColor:
                                                MaterialStateProperty.all(
                                                    primaryColor),
                                            activeColor: primaryColor,
                                            onChanged: (value) {
                                              setState(() {
                                                group2 = value.toString();
                                              });
                                            }),
                                        Text(
                                            priceTypeList![index].name ??
                                                "null",
                                            style: textStylePrimaryMed14),
                                      ],
                                    ),
                                  );
                                }),
                          ),
                        ),
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
                );
              } else if (state is BuyurtmaDialogLoadingState) {
                return SizedBox(
                    child: const Center(child: CupertinoActivityIndicator()),
                    height: 400.h);
              } else {
                return Container();
              }
            },
          ),
        ],
      ),
    );
  }
}

// Padding(
//   padding: EdgeInsets.only(
//       right: 7.w, top: 22.h, left: 7.w, bottom: 34.h),
//   child: Row(
//     crossAxisAlignment: CrossAxisAlignment.center,
//     children: [
//       Expanded(
//         child: Text(
//           'Qarzdorligi:',
//           style: textStylePrimaryMed16,
//         ),
//       ),
//       Column(
//         crossAxisAlignment: CrossAxisAlignment.end,
//         children: [
//           Text(
//             '0 so’m',
//             style: TextStyle(
//                 color: cOrangeColor,
//                 fontSize: 18.sp,
//                 fontFamily: 'Regular'),
//           ),
//           SizedBox(height: 14.h),
//           Text(
//             '0 \$',
//             style: TextStyle(
//                 color: cOrangeColor,
//                 fontSize: 18.sp,
//                 fontFamily: 'Regular'),
//           ),
//         ],
//       ),
//     ],
//   ),
// ),
