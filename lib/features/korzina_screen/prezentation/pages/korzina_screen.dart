import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:savdo_agnet_client/core/widgets/appBarWidget.dart';
import 'package:savdo_agnet_client/core/widgets/costum_toast.dart';
import 'package:savdo_agnet_client/features/korzina_screen/data/korzina_hive/korzina_hive.dart';
import 'package:savdo_agnet_client/features/korzina_screen/prezentation/widgets/dialog_send.dart';
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
            state.korzinaErrorList.isEmpty
                ? Future.delayed(Duration.zero, () async {
                    await box.clear();
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
                jamiSumma = 0;
                var transaction = box.values.toList().cast<KorzinaCard>();
                for (int i = 0; i < transaction.length; i++) {
                  jamiSumma +=
                      ((transaction[i].bloklarSoni! * transaction[i].blok!) +
                              transaction[i].dona!) *
                          transaction[i].price!;
                }
                return Scaffold(
                  backgroundColor: cBackgroundColor,
                  appBar: appBarWidget(context, 'Savatcha'),
                  body: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            left: 21.w, bottom: 10.h, right: 21.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Jami summa:', style: textStylePrimaryMed16),
                            Text('${jamiSumma.toStringAsFixed(2)} so\'m / \$',
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
                                    box: box, transaction: transaction)),
                      ),
                    ],
                  ),
                  floatingActionButtonLocation:
                      FloatingActionButtonLocation.centerDocked,
                  floatingActionButton: Visibility(
                    visible: transaction.isNotEmpty,
                    child: ElevatedButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return SendDialog(jamiSumma: jamiSumma, bloc: bloc, transaction: transaction,);
                          },
                        );
                      },
                      child: Text('Buyurtma berish',
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
