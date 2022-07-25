import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:savdo_agnet_client/core/utils/app_constants.dart';
import 'package:savdo_agnet_client/features/firmalar/data/model/firma_model.dart';
import 'package:savdo_agnet_client/features/firmalar/presentation/bloc/firma_cubit.dart';
import 'package:savdo_agnet_client/features/login/presentation/pages/login_page.dart';

import '../../../../core/network/network_info.dart';
import '../../../../di/dependency_injection.dart';
import '../widgets/grid_items_widget.dart';
import '../widgets/text_field_widget.dart';

class FirmalarPage extends StatefulWidget {
  const FirmalarPage({Key? key}) : super(key: key);

  static Widget screen() => BlocProvider(
        create: (context) =>
            SearchFirmaItemsCubit(maxsulotlarBulimiCubit: firmaList),
        child: const FirmalarPage(),
      );

  @override
  _FirmalarPageState createState() => _FirmalarPageState();
}

class _FirmalarPageState extends State<FirmalarPage> {
  TextEditingController controller = TextEditingController();
  late SearchFirmaItemsCubit _bloc;
  final NetworkInfo networkInfo = di.get();

  @override
  void initState() {
    _bloc = BlocProvider.of<SearchFirmaItemsCubit>(context);
    super.initState();
  }

  @override
  void dispose() {
    _bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: cBackgroundColor,
      resizeToAvoidBottomInset: false,
      body: BlocBuilder<SearchFirmaItemsCubit, SearchFirmaItemsState>(
        builder: (context, state) {
          return Container(
            padding: EdgeInsets.only(left: 28.w, right: 28.w, top: 101.h),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Firmalar',
                  style: TextStyle(
                      color: cBlackColor,
                      fontSize: 24.sp,
                      fontFamily: 'Regular'),
                ),
                TextFieldWidget(
                  controller: BlocProvider.of<SearchFirmaItemsCubit>(context)
                      .state
                      .filter,
                ),
                Expanded(
                  child: GridView.builder(
                      padding: EdgeInsets.symmetric(vertical: 20.h),
                      physics: const BouncingScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 200.w,
                        childAspectRatio: 1,
                        crossAxisSpacing: 16.w,
                        mainAxisSpacing: 16.h,
                      ),
                      itemCount: state.firma.length,
                      itemBuilder: (BuildContext ctx, index) {
                        return GridViewItemsWidget(
                          onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const LoginPage(),
                              )),
                           index: index,
                          state: state,
                        );
                      }),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
