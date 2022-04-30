import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:savdo_agnet_client/core/widgets/appBarWidget.dart';
import 'package:savdo_agnet_client/features/korzina_screen/data/korzina_hive/korzina_hive.dart';

import '../../../../../../../core/utils/app_constants.dart';
import '../../../../di/dependency_injection.dart';
import '../bloc/korzina_bloc.dart';
import '../widgets/korzina_items.dart';

class KorzinaScreen extends StatefulWidget {
  const KorzinaScreen({Key? key}) : super(key: key);

  static Widget screen() => BlocProvider(
      create: (context) => di<KorzinaBloc>(), child: const KorzinaScreen());

  @override
  State<KorzinaScreen> createState() => _KorzinaScreenState();
}

class _KorzinaScreenState extends State<KorzinaScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<KorzinaBloc, KorzinaState>(
      builder: (context, state) {
        return ValueListenableBuilder<Box<KorzinaCard>>(
          valueListenable: Hive.box<KorzinaCard>('korzina_box').listenable(),
          builder: (context, box, _) {
            var transaction = box.values.toList().cast<KorzinaCard>();
            return Scaffold(
              backgroundColor: cBackgroundColor,
              appBar: appBarWidget(context, 'Savatcha'),
              body: Center(
                child: transaction.isEmpty
                    ? Container()
                    : ListView.builder(
                        reverse: transaction.length <= 2 ? false : true,
                        physics: const BouncingScrollPhysics(),
                        padding: EdgeInsets.symmetric(horizontal: 21.w),
                        itemCount: transaction.length,
                        itemBuilder: (context, index) {
                          return KorzinaItemsWidget(
                            price: transaction[index].price,
                            size: transaction[index].size,
                            name: transaction[index].name,
                            image: transaction[index].image,
                            blok: transaction[index].blok,
                            id: transaction[index].id,
                            brandNomi: 'a',
                            residue: transaction[index].residue,
                            currencyId: transaction[index].currencyId,
                            category: transaction[index].category,
                            currencyName: transaction[index].currencyName,
                            dona: transaction[index].dona,
                          );
                        },
                      ),
              ),
              floatingActionButton: Visibility(
                visible: transaction.isEmpty ? false : true,
                child: ElevatedButton(
                  onPressed: () {},
                  child: Text('Buyurtma berish',
                      style: TextStyle(
                          fontFamily: 'Medium',
                          fontSize: 16.sp,
                          color: cWhiteColor)),
                  style: ButtonStyle(
                    fixedSize: MaterialStateProperty.all(Size(414.w, 82.h)),
                    padding:
                        MaterialStateProperty.all(const EdgeInsets.all(25)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                                top: Radius.circular(15.r)))),
                    backgroundColor: MaterialStateProperty.all(primaryColor),
                    elevation: MaterialStateProperty.all(0),
                  ),
                ),
              ),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerDocked,
            );
          },
        );
      },
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
//           title: 'Liqui Moly',
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
