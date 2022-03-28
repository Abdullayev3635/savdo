import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:savdo_agnet_client/core/widgets/appBarWidget.dart';
import 'package:savdo_agnet_client/features/savatcha_failure/presentation/pages/savatcha_failure_dialog.dart';

import '../../../../../../../core/utils/app_constants.dart';
import '../../../../di/dependency_injection.dart';
import '../../domain/bloc/korzina_bloc.dart';
import '../widgets/korzina_items.dart';

class KorzinaScreen extends StatefulWidget {
  const KorzinaScreen({Key? key}) : super(key: key);

  static Widget screen() => BlocProvider(
        create: (context) => di<KorzinaBloc>(),
        child: const KorzinaScreen(),
      );

  @override
  State<KorzinaScreen> createState() => _KorzinaScreenState();
}

class _KorzinaScreenState extends State<KorzinaScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: cBackgroundColor,
      appBar: appBarWidget(context, 'Savatcha'),
      body: Center(
        // child: transaction.isEmpty
        //     ? Container()
        child: ListView.builder(
          itemCount: 20,
          itemBuilder: (context, index) {
            return KorzinaItemsWidget(
              id: index,
              brandNomi: 'Bradley Hand',
              image: 'assets/images/truck.png',
              title: 'Liqui Moly',
              count: '40',
              price: 10000,
              carType: 'Yengil mashinalar',
              rating: 4,
            );
          },
          physics: const BouncingScrollPhysics(),
        ),
      ),
      floatingActionButton: Visibility(
        // visible: transaction.isEmpty ? false : true,
        child: ElevatedButton(
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return const SavatchaFailureDialog();
                  });
            },
            child: Text(
              'Buyurtma berish',
              style: TextStyle(
                  fontFamily: 'Medium', fontSize: 16.sp, color: cWhiteColor),
            ),
            style: ButtonStyle(
              fixedSize: MaterialStateProperty.all(
                  Size.fromWidth(MediaQuery.of(context).size.width + 10)),
              padding: MaterialStateProperty.all(const EdgeInsets.all(31)),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(15.r)))),
              backgroundColor: MaterialStateProperty.all(primaryColor),
              elevation: MaterialStateProperty.all(0),
            )),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
    // int jamiSumma = 0;
    // return BlocBuilder<KorzinaBloc, KorzinaState>(builder: (context, state) {
    //   return ValueListenableBuilder<Box<KorzinaCard>>(
    //       valueListenable: Hive.box<KorzinaCard>('korzina_box').listenable(),
    //       builder: (context, box, _) {
    //         Hive.openBox<KorzinaCard>('korzina_box');
    //         var transaction = box.values.toList().cast<KorzinaCard>();
    //         // for (int i = 0; i < transaction.length; i++) {
    //         //   jamiSumma += transaction[i].number * transaction[i].price;
    //         // }
    //         return Scaffold(
    //           backgroundColor: cBackgroundColor,
    //           appBar: appBarWidget(context, 'Savatcha'),
    //           body: Center(
    //             child: transaction.isEmpty
    //                 ? Container()
    //                 : ListView.builder(
    //                     itemBuilder: (context, index) {
    //                       return KorzinaItemsWidget(
    //                         price: transaction[index].price,
    //                         rating: transaction[index].rating,
    //                         title: transaction[index].title,
    //                         image: transaction[index].image,
    //                         carType: transaction[index].carType,
    //                         id: transaction[index].id,
    //                       );
    //                     },
    //                     reverse: transaction.length <= 2 ? false : true,
    //                     physics: const BouncingScrollPhysics(),
    //                     // children: [
    //                     //   KorzinaItemsWidget(
    //                     //     price: transaction[i].,
    //                     //   ),
    //                     //   Container(
    //                     //       margin: EdgeInsets.only(
    //                     //           top: 24.h,
    //                     //           right: 14.w,
    //                     //           left: 14.w,
    //                     //           bottom: 200),
    //                     //       decoration: BoxDecoration(
    //                     //         color: cWhiteColor,
    //                     //         borderRadius: BorderRadius.circular(22),
    //                     //       ),
    //                     //       child: Column(children: [
    //                     //         // buildBoxCard(transaction, box),
    //                     //         SizedBox(
    //                     //             width: 350.w,
    //                     //             child: SvgPicture.asset(
    //                     //                 'assets/icons/line.svg',
    //                     //                 fit: BoxFit.fitWidth)),
    //                     //         // OrderDescriptionWidget(
    //                     //         //     transaction: transaction),
    //                     //         // Padding(
    //                     //         //     padding: EdgeInsets.only(
    //                     //         //         bottom: 22.h,
    //                     //         //         left: 23.w,
    //                     //         //         right: 23.w,
    //                     //         //         top: 10),
    //                     //         //     child: Column(children: [
    //                     //         //       Row(
    //                     //         //         mainAxisAlignment:
    //                     //         //             MainAxisAlignment.spaceBetween,
    //                     //         //         children: [
    //                     //         //           Text(
    //                     //         //             'Jami summa:',
    //                     //         //             style: TextStyle(
    //                     //         //                 color: ctext2Color,
    //                     //         //                 fontSize: 14.sp,
    //                     //         //                 fontFamily: 'Medium'),
    //                     //         //           ),
    //                     //         //           RichText(
    //                     //         //             text: TextSpan(
    //                     //         //                 text: '$jamiSumma ',
    //                     //         //                 style: TextStyle(
    //                     //         //                     color: cFirstColor,
    //                     //         //                     fontSize: 24.sp,
    //                     //         //                     fontFamily: 'Medium'),
    //                     //         //                 children: [
    //                     //         //                   TextSpan(
    //                     //         //                       text: 'UZS',
    //                     //         //                       style: TextStyle(
    //                     //         //                           color: cFirstColor,
    //                     //         //                           fontSize: 14.sp,
    //                     //         //                           fontFamily:
    //                     //         //                               'Medium'))
    //                     //         //                 ]),
    //                     //         //           ),
    //                     //         //         ],
    //                     //         //       ),
    //                     //         //     ]))
    //                     //       ]))
    //                     // ],
    //                   ),
    //           ),
    //           floatingActionButton: Visibility(
    //             visible: transaction.isEmpty ? false : true,
    //             child: Padding(
    //               padding: const EdgeInsets.only(bottom: 80.0),
    //               child: ElevatedButton(
    //                   onPressed: () {},
    //                   child: Text(
    //                     'Buyurtma berish',
    //                     style: TextStyle(
    //                         fontFamily: 'Medium',
    //                         fontSize: 16.sp,
    //                         color: cWhiteColor),
    //                   ),
    //                   style: ButtonStyle(
    //                     fixedSize:
    //                         MaterialStateProperty.all(Size.fromWidth(348.w)),
    //                     padding:
    //                         MaterialStateProperty.all(const EdgeInsets.all(25)),
    //                     shape:
    //                         MaterialStateProperty.all<RoundedRectangleBorder>(
    //                             RoundedRectangleBorder(
    //                                 borderRadius:
    //                                     BorderRadius.circular(18.0.r))),
    //                     backgroundColor:
    //                         MaterialStateProperty.all(primaryColor),
    //                     elevation: MaterialStateProperty.all(0),
    //                   )),
    //             ),
    //           ),
    //         );
    //       });
    // });
  }
}
