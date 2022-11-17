import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:savdo_agnet_client/core/widgets/appBarWidget.dart';
import 'package:savdo_agnet_client/core/widgets/costum_toast.dart';
import 'package:savdo_agnet_client/features/korzina_screen/data/korzina_hive/korzina_hive.dart';
import 'package:savdo_agnet_client/features/korzina_screen/data/korzina_hive/tolov_hive.dart';
import 'package:savdo_agnet_client/features/korzina_screen/prezentation/widgets/dialog_send.dart';
import 'package:savdo_agnet_client/features/korzina_screen/prezentation/widgets/korzina_shimmer_widget.dart';
import 'package:savdo_agnet_client/features/savatcha_failure/presentation/pages/savatcha_failure_dialog.dart';

import '../../../../../../../core/utils/app_constants.dart';
import '../../../../di/dependency_injection.dart';
import '../bloc/korzina_bloc.dart';
import '../widgets/korzina_items.dart';
import '../widgets/tolov_items.dart';

class KorzinaScreen extends StatefulWidget {
  const KorzinaScreen({Key? key}) : super(key: key);

  static Widget screen() => BlocProvider(
        create: (context) => di<KorzinaBloc>()..add(KorzinaInitialEvent()),
        child: const KorzinaScreen(),
      );

  @override
  State<KorzinaScreen> createState() => _KorzinaScreenState();
}

class _KorzinaScreenState extends State<KorzinaScreen> {
  num jamiSummaSum = 0;
  num jamiSummaVal = 0;
  num jamiSummaOther = 0;
  late KorzinaBloc bloc;
  var korzinaProductList = <KorzinaCard>[];

  @override
  void initState() {
    super.initState();
    bloc = BlocProvider.of<KorzinaBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<KorzinaBloc, KorzinaState>(
        builder: (context, state) {
          if (state is KorzinaFailureState) {
            CustomToast.showToast('Malumot uzatishda xatolik yuz berdi');
          } else if (state is KorzinaLoadingState) {
            return Scaffold(
              backgroundColor: cBackgroundColor,
              appBar: appBarWidget(context, 'Savatcha'),
              body: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.0),
                child: KorzinaShimmerWidget(),
              ),
            );
          } else if (state is KorzinaErrorMessageState) {
            var box = Hive.box<KorzinaCard>(korzinaBox);
            var payBox = Hive.box<TolovHive>(tolovBox);
            state.korzinaErrorList.isEmpty
                ? Future.delayed(Duration.zero, () async {
                    await box.clear();
                    await payBox.clear();
                    Navigator.pop(context);
                    CustomToast.showToast('Malumot muvvafaqiyatli uzatildi!');
                  })
                : Future.delayed(Duration.zero, () async {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return SavatchaFailureDialog(
                            list: state.korzinaErrorList,
                          );
                        });
                  });
          } else if (state is KorzinaSuccessState) {
            korzinaProductList = state.korzinaSaveList;
          }
          return ValueListenableBuilder<Box<KorzinaCard>>(
              valueListenable: Hive.box<KorzinaCard>(korzinaBox).listenable(),
              builder: (context, box, _) {
                jamiSummaSum = 0;
                jamiSummaVal = 0;
                var transaction = box.values.toList().cast<KorzinaCard>();
                for (int i = 0; i < transaction.length; i++) {
                  if (transaction[i].currencyId == 1) {
                    jamiSummaSum +=
                        ((transaction[i].bloklarSoni! * transaction[i].blok!) +
                                transaction[i].dona!) *
                            transaction[i].price!;
                  } else if (transaction[i].currencyId == 2) {
                    jamiSummaVal +=
                        ((transaction[i].bloklarSoni! * transaction[i].blok!) +
                                transaction[i].dona!) *
                            transaction[i].price!;
                  } else {
                    jamiSummaOther +=
                        ((transaction[i].bloklarSoni! * transaction[i].blok!) +
                                transaction[i].dona!) *
                            transaction[i].price!;
                  }
                }
                return Scaffold(
                  backgroundColor: cBackgroundColor,
                  appBar: appBarWidget(context, 'Savatcha'),
                  body: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 50.h,
                        child: Padding(
                          padding: EdgeInsets.only(
                              left: 21.w, bottom: 10.h, right: 21.w),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Jami summa:', style: textStylePrimaryMed16),
                              Column(
                                children: [
                                  Text(
                                      '${jamiSummaSum.toStringAsFixed(0)} so\'m',
                                      style: textStylePrimaryMed16),
                                  Text('${jamiSummaVal.toStringAsFixed(2)} \$',
                                      style: textStylePrimaryMed16),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: DefaultTabController(
                          length: 2,
                          child: Column(
                            children: <Widget>[
                              Container(
                                constraints:
                                    const BoxConstraints(maxHeight: 100.0),
                                child: Material(
                                  color: cTextFieldColor,
                                  child: TabBar(
                                    indicatorColor: primaryColor,
                                    indicatorSize: TabBarIndicatorSize.label,
                                    tabs: [
                                      Container(
                                        padding: EdgeInsets.all(5.h),
                                        height: 32.h,
                                        child: Text(
                                          "Maxsulotlar",
                                          style: textStylePrimaryReg20,
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.all(5.h),
                                        height: 32.h,
                                        child: Text("To'lovlar",
                                            style: textStylePrimaryReg20),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                child: TabBarView(
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(
                                          top: 15.h, bottom: 50),
                                      child: transaction.isEmpty
                                          ? Container()
                                          : SizedBox(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height /
                                                  1.3,
                                              child: KorzinaItemsWidget(
                                                  box: box,
                                                  transaction: transaction),
                                            ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(top: 15.h),
                                      child: const TolovItemsWidget(),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  floatingActionButtonLocation:
                      FloatingActionButtonLocation.centerDocked,
                  floatingActionButton: Visibility(
                    visible: transaction.isNotEmpty,
                    child: ElevatedButton(
                      onPressed: () async {
                        final box = Hive.box<TolovHive>(tolovBox);
                        final paymentList =
                            box.values.toList().cast<TolovHive>();
                        bloc.add(KorzinaSendDataEvent(
                            card: transaction, payment: paymentList));
                      },
                      child: Text(
                        'Buyurtma berish',
                        style: TextStyle(
                          fontFamily: 'Medium',
                          fontSize: 16.sp,
                          color: cWhiteColor,
                        ),
                      ),
                      style: korzinaButtonStyle,
                    ),
                  ),
                );
              });
        },
      ),
    );
  }
}
// return Scaffold(
//   backgroundColor: cBackgroundColor,
//   appBar: appBarWidget(context, 'Savatcha'),
//   body: Center(
//     // child: transaction.isEmpty
//     //     ? Container()
//     child: ListView.builder(
//       itemCount: 20,
//       itemBuilder: (context, index) {
//         return KorzinaItemsWidget(
//           id: index,
//           brandNomi: 'Bradley Hand',
//           image: 'assets/images/truck.png',
//           title: 'Liqui Molly',
//           count: '40',
//           price: 10000,
//           carType: 'Yengil mashinalar',
//           rating: 4,
//         );
//       },
//       physics: const BouncingScrollPhysics(),
//     ),
//   ),
//   floatingActionButton: Visibility(
//     // visible: transaction.isEmpty ? false : true,
//     child: ElevatedButton(
//         onPressed: () {
//           showDialog(
//               context: context,
//               builder: (context) {
//                 return const SavatchaFailureDialog();
//               });
//         },
//         child: Text(
//           'Buyurtma berish',
//           style: TextStyle(
//               fontFamily: 'Medium', fontSize: 16.sp, color: cWhiteColor),
//         ),
//         style: ButtonStyle(
//           fixedSize: MaterialStateProperty.all(
//               Size.fromWidth(MediaQuery.of(context).size.width + 10)),
//           padding: MaterialStateProperty.all(const EdgeInsets.all(31)),
//           shape: MaterialStateProperty.all<RoundedRectangleBorder>(
//               RoundedRectangleBorder(
//                   borderRadius:
//                       BorderRadius.vertical(top: Radius.circular(15.r)))),
//           backgroundColor: MaterialStateProperty.all(primaryColor),
//           elevation: MaterialStateProperty.all(0),
//         )),
//   ),
//   floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
// );
