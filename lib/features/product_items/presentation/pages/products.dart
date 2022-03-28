import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:savdo_agnet_client/di/dependency_injection.dart';
import 'package:savdo_agnet_client/features/product_items/presentation/bloc/product_items_cubit.dart';
import 'package:savdo_agnet_client/features/product_items/presentation/widgets/search.dart';

import '../../../../core/utils/app_constants.dart';
import '../../../../core/widgets/appBarWidget.dart';
import '../widgets/product_items.dart';

String bName = '';

class Products extends StatefulWidget {
  const Products({Key? key}) : super(key: key);

  //

  static Widget screen(final String brandName) {
    bName = brandName;
    return BlocProvider(
      create: (context) => di<ProductItemsCubit>(),
      child: const Products(),
    );
  }

  @override
  State<Products> createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: cBackgroundColor,
      appBar: appBarWidget(context, bName),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          children: [
            ProductItemsTextFieldWidget(
              controller: textEditingController,
            ),
            Expanded(
              child: ListView.builder(
                  padding: EdgeInsets.only(top: 25.h),
                  physics: const BouncingScrollPhysics(),
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) => const Products(),
                        //   ),
                        // );
                      },
                      child: ProductItemsWidget(
                        id: index,
                        brandNomi: 'Bradley Hand',
                        image: 'assets/images/truck.png',
                        title: 'Liqui Moly',
                        count: '40',
                        price: 10000,
                        carType: 'Yengil mashinalar',
                        rating: 4,
                      ),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
