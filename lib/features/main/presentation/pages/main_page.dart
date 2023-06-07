import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hive/hive.dart';
import 'package:savdo_agnet_client/core/utils/app_constants.dart';
import 'package:savdo_agnet_client/di/dependency_injection.dart';
import 'package:savdo_agnet_client/features/archive/presentation/pages/archive_page.dart';
import 'package:savdo_agnet_client/features/buyurtma/presentation/bloc/buyurtma_bloc/buyurtma_dialog_bloc.dart';
import 'package:savdo_agnet_client/features/buyurtma/presentation/pages/buyurtma_dialog.dart';
import 'package:savdo_agnet_client/features/foto_xisobot/presentation/pages/photo_report_dialog.dart';
import 'package:savdo_agnet_client/features/korzina_screen/data/korzina_hive/tolov_hive.dart';
import 'package:savdo_agnet_client/features/mijozlar/presentation/pages/mijozlar_dialog.dart';
import 'package:savdo_agnet_client/features/profile/presentation/pages/profile_page.dart';
import 'package:savdo_agnet_client/features/tulov_qilish/presentation/pages/tulov_qilish_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/network/network_info.dart';
import '../../../../core/widgets/costum_toast.dart';
import '../../../../core/widgets/failure_dialog.dart';
import '../../../buyurtma/data/model/branch_model.dart';
import '../../../korzina_screen/data/korzina_hive/korzina_hive.dart';
import '../../../product/presentation/pages/product_page.dart';
import '../../../report_dialog/presentation/pages/report_select.dart';
import '../widgets/menu_items.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  String branchGroup = '0';
  DateTime? currentBackPressTime;
  SharedPreferences sharedPreferences = di.get();
  NetworkInfo networkInfo = di.get();
  String name = "";
  bool isAgent = false;
  late BuyurtmaDialogBloc dialogBloc;
  late List<BranchModel> branchList;

  @override
  void initState() {
    sharedPreferences.setString( sharedBuyurtmaBranchId, sharedPreferences.getString(sharedBranchId) ?? "0");
    dialogBloc = BlocProvider.of<BuyurtmaDialogBloc>(context);
    context.read<BuyurtmaDialogBloc>().add(BuyurtmaInitialEvent());
    name = sharedPreferences.getString("worker_name") ?? "";
    isAgent = sharedPreferences.getBool(sharedIsAgent) ?? false;
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        DateTime now = DateTime.now();
        if (currentBackPressTime == null || now.difference(currentBackPressTime!) > const Duration(seconds: 2)) {
          currentBackPressTime = now;
          CustomToast.showToast("Dasturdan chiqish uchun ikki marta bosing!");
          return Future.value(false);
        }
        return Future.value(true);
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: cBackgroundColor,
        body: Container(
          padding: EdgeInsets.only(top: 10.h, bottom: 30.h),
          child: BlocBuilder<BuyurtmaDialogBloc, BuyurtmaDialogState>(
            builder: (context, state) {
              if (state is BuyurtmaDialogSelectedSuccessState) {
                branchList = state.buyurtmaList[0].branchs!;
                if(branchList.isNotEmpty){
                  branchGroup = branchList.indexWhere((item) => item.id == int.parse(sharedPreferences.getString(sharedBuyurtmaBranchId) ?? "0")).toString();
                }
                return Column(
                  children: [
                    const Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 2,
                              child: AutoSizeText(name,
                                  maxLines: 2,
                                  style: TextStyle(
                                      fontFamily: 'ExtraBold',
                                      fontSize: 32.sp,
                                      color: primaryColor)),
                            ),
                            SizedBox(height: 8.h),
                            Row(
                              children: [
                                Text(
                                    'Hayrli kun ' +
                                        (isAgent == true ? "agent! " : "!"),
                                    style: textStylePrimaryMed16),
                                Image.asset(
                                  'assets/icons/ic_hand.png',
                                  width: 14.w,
                                  height: 14.h,
                                ),
                              ],
                            ),
                            sharedPreferences.getBool(sharedIsAgent) == true
                                ? Column(
                                    children: [
                                      SizedBox(height: 15.h),
                                      Row(
                                        children: [
                                          Text('Filial:',
                                              textAlign: TextAlign.left,
                                              style: textStylePrimaryMed16),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 50.h,
                                        child: ListView.builder(
                                            physics: const BouncingScrollPhysics(),
                                            scrollDirection: Axis.horizontal,
                                            shrinkWrap: true,
                                            itemCount: branchList.length,
                                            itemBuilder: (context, index) {
                                              return GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    branchGroup = index.toString();
                                                    sharedPreferences.setString( sharedBuyurtmaBranchId, branchList[index].id.toString());
                                                    context.read<BuyurtmaDialogBloc>().add(BuyurtmaInitialEvent());
                                                  });
                                                },
                                                child: Row(
                                                  children: [
                                                    Radio(
                                                        value: '$index',
                                                        groupValue: branchGroup,
                                                        fillColor: MaterialStateProperty.all(primaryColor),
                                                        activeColor: primaryColor,
                                                        onChanged: (value) {
                                                          setState(() {
                                                            branchGroup = value.toString();
                                                            sharedPreferences.setString( sharedBuyurtmaBranchId, branchList[int.parse(value.toString())].id.toString());
                                                            context.read<BuyurtmaDialogBloc>().add(BuyurtmaInitialEvent());
                                                          });
                                                        }),
                                                    Text(
                                                      branchList[index].name ?? "",
                                                      maxLines: 1,
                                                      style: textStylePrimaryMed14,
                                                    ),
                                                  ],
                                                ),
                                              );
                                            }),
                                      ),
                                      SizedBox(height: 10.h),
                                    ],
                                  )
                                : Container(),
                          ],
                        ),
                        IconButton(
                            highlightColor: Colors.transparent,
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const ProfilePage(),
                                  ));
                            },
                            icon:
                                SvgPicture.asset('assets/icons/ic_person.svg'))
                      ],
                    ),
                    const Spacer(),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.r),
                        color: cWhiteColor,
                      ),
                      margin: EdgeInsets.only(right: 22.w, left: 22.w),
                      padding: EdgeInsets.symmetric(
                          horizontal: 21.w, vertical: 23.h),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              MenuItems(
                                  onTap: () {
                                    var box = Hive.box<KorzinaCard>(korzinaBox);
                                    var box2 = Hive.box<TolovHive>(tolovBox);
                                    if (box.isNotEmpty && box2.isNotEmpty) {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              ProductPage.screen(),
                                        ),
                                      );
                                    } else {
                                      showDialog(
                                          context: context,
                                          builder: (context) {
                                            return BuyurtmaDialog.screen();
                                          });
                                    }
                                  },
                                  title: 'Yangi buyurtma',
                                  image: 'assets/icons/ic_shopping_cart.svg'),
                              MenuItems(
                                  onTap: () {
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          return TulovQilishDialog.screen();
                                        });
                                  },
                                  title: 'To’lov',
                                  image: 'assets/icons/ic_dollar_circle.svg'),
                            ],
                          ),
                          SizedBox(height: 16.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              MenuItems(
                                  onTap: () {
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          return const ReportSelect();
                                        });
                                  },
                                  title: 'Hisobot',
                                  image: 'assets/icons/ic_hisobot.svg'),
                              MenuItems(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            ArchivePage.screen(),
                                      ),
                                    );
                                  },
                                  title: 'Arhiv',
                                  image: 'assets/icons/ic_archive.svg'),
                            ],
                          ),
                          SizedBox(height: 16.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              MenuItems(
                                  onTap: () {
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          return PhotoReportDialog.screen();
                                        });
                                  },
                                  title: 'Foto hisobot',
                                  image: 'assets/icons/ic_camera.svg'),
                              MenuItems(
                                  onTap: () {
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          return const MijozlarDialog();
                                        });
                                  },
                                  title: 'Mijozlar',
                                  image: 'assets/icons/ic_two_person.svg'),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                  ],
                );
              } else if (state is BuyurtmaDialogLoadingState) {
                return SizedBox(
                    child: const Center(
                      child: CupertinoActivityIndicator(),
                    ),
                    height: 400.h);
              } else if (state is BuyurtmaDialogNoInternetState) {
                return ShowFailureDialog(onTap: () async {
                  if (await networkInfo.isConnected) {
                    dialogBloc.add(BuyurtmaInitialEvent());
                    Navigator.pop(context);
                  } else {
                    CustomToast.showToast('Internet bilan aloqani tekshiring!');
                  }
                });
              }
              return SizedBox(
                  child: const Center(child: CupertinoActivityIndicator()),
                  height: 400.h);
            },
          ),
        ),
        // ),
      ),
    );
  }
}
