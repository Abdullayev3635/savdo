import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:savdo_agnet_client/features/product_items/presentation/widgets/search.dart';

import '../../../../core/utils/app_constants.dart';
import '../widgets/product_items.dart';

class Products extends StatefulWidget {
  const Products({Key? key}) : super(key: key);

  @override
  State<Products> createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  TextEditingController textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        color: cBackgroundColor,
        child: Column(
          children: [
            TextFieldWidget(controller: textEditingController,),
            Container(
              height: MediaQuery.of(context).size.height / 1.33,
              margin: EdgeInsets.only(top: 36.h),
              child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const Products(),
                          ),
                        );
                      },
                      child: const ProductItemsWidget(
                        image: 'assets/icons/ic_gallery.svg',
                        title: 'Liqui Moly',
                        count: '40',
                      ),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      leadingWidth: 70,
      elevation: 0,
      backgroundColor: cBackgroundColor,
      leading: IconButton(
        onPressed: () {},
        icon: SvgPicture.asset("assets/icons/ic_arrow_back.svg"),
      ),
      title: Text(
        "Brend nomi",
        style: TextStyle(
          fontFamily: "Medium",
          fontSize: 20.sp,
          fontWeight: FontWeight.w500,
          color: primaryColor,
        ),
      ),
      centerTitle: true,
    );
  }
}
