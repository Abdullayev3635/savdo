import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:savdo_agnet_client/core/widgets/appBarWidget.dart';
import 'package:savdo_agnet_client/core/widgets/costum_toast.dart';
import 'package:savdo_agnet_client/features/korzina_screen/data/korzina_hive/korzina_hive.dart';
import 'package:savdo_agnet_client/features/korzina_screen/prezentation/widgets/korzina_shimmer_widget.dart';
import 'package:savdo_agnet_client/features/savatcha_failure/presentation/pages/savatcha_failure_dialog.dart';

import '../../../../../../../core/utils/app_constants.dart';
import '../../../../di/dependency_injection.dart';
import '../bloc/korzina_bloc.dart';
import '../widgets/korzina_items.dart';

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
  num jamiSumma = 0;
  late KorzinaBloc bloc;

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
            state.korzinaErrorList.isEmpty
                ? {
                    Navigator.pop(context),
                    CustomToast.showToast('Malumot muvvafaqiyatli uzatildi!'),
                  }
                : showDialog(
                    context: context,
                    builder: (context) {
                      return const SavatchaFailureDialog();
                    });
          } else if (state is KorzinaSuccessState) {
            return ValueListenableBuilder<Box<KorzinaCard>>(
                valueListenable: Hive.box<KorzinaCard>(korzinaBox).listenable(),
                builder: (context, box, _) {
                  jamiSumma = 0;
                  var transaction = box.values.toList().cast<KorzinaCard>();
                  for (int i = 0; i < transaction.length; i++) {
                    jamiSumma += ((int.parse(transaction[i].bloklarSoni!) *
                                int.parse(transaction[i].blok!)) +
                            int.parse(transaction[i].dona!)) *
                        double.parse(transaction[i].price!);
                  }
                  return Scaffold(
                    backgroundColor: cBackgroundColor,
                    appBar: appBarWidget(context, 'Savatcha'),
                    body: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 21.w, bottom: 10.h,right: 21.w),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Jami summa:', style: textStylePrimaryMed16),
                              Text('${jamiSumma.toStringAsFixed(2)} so’m',
                                  style: textStylePrimaryMed16),
                            ],
                          ),
                        ),
                        Container(
                          child: transaction.isEmpty
                              ? Container()
                              : SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height / 1.3,
                                  child: KorzinaItemsWidget(
                                      box: box,
                                      transaction: transaction)),
                        ),
                      ],
                    ),
                    floatingActionButton: Visibility(
                      visible: transaction.isNotEmpty,
                      child: ElevatedButton(
                        onPressed: () {
                          bloc.add(KorzinaSendDataEvent(
                              card: state.korzinaSaveList));
                        },
                        child: Text('Buyurtma berish',
                            style: TextStyle(
                                fontFamily: 'Medium',
                                fontSize: 16.sp,
                                color: cWhiteColor)),
                        style: ButtonStyle(
                          fixedSize:
                              MaterialStateProperty.all(Size(414.w, 82.h)),
                          padding: MaterialStateProperty.all(
                              const EdgeInsets.all(25)),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.vertical(
                                          top: Radius.circular(15.r)))),
                          backgroundColor:
                              MaterialStateProperty.all(primaryColor),
                          elevation: MaterialStateProperty.all(0),
                        ),
                      ),
                    ),
                    floatingActionButtonLocation:
                        FloatingActionButtonLocation.centerDocked,
                  );
                });
          }
          return const Scaffold(
            backgroundColor: cBackgroundColor,
          );
          // return ValueListenableBuilder<Box<KorzinaCard>>(
          //   valueListenable: Hive.box<KorzinaCard>('korzina_box').listenable(),
          //   builder: (context, box, _) {
          //     jamiSumma = 0;
          //     var transaction = box.values.toList().cast<KorzinaCard>();
          //     for (int i = 0; i < transaction.length; i++) {
          //       jamiSumma += ((int.parse(transaction[i].bloklarSoni!) *
          //                   int.parse(transaction[i].blok!)) +
          //               int.parse(transaction[i].dona!)) *
          //           int.parse(transaction[i].price!);
          //     }
          //     return Scaffold();
          //   },
          // );
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
