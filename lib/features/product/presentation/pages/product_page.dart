import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:savdo_agnet_client/core/utils/app_constants.dart';
import 'package:savdo_agnet_client/features/firmalar/presentation/widgets/text_field_widget.dart';
import 'package:savdo_agnet_client/features/product_items/presentation/pages/products.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({Key? key}) : super(key: key);

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: cBackgroundColor,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            // backgroundColor: Colors.transparent,
            automaticallyImplyLeading: false,
            toolbarHeight: 280.h,
            floating: false,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFieldWidget(controller: controller),
                ],
              ),
            ),
          ),
          SliverList(
              delegate: SliverChildListDelegate(
            [
              Container(
                height: MediaQuery.of(context).size.height / 1.64,
                margin: EdgeInsets.only(top: 36.h, left: 21.w, right: 21.w),
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
              )
            ],
          ))
        ],
      ),
    );
  }
}

class ProductItemsWidget extends StatelessWidget {
  final String title, image, count;

  const ProductItemsWidget({
    required this.title,
    required this.count,
    required this.image,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.r), color: cWhiteColor),
      margin: EdgeInsets.only(bottom: 16.h),
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.all(13.w),
            padding: EdgeInsets.symmetric(vertical: 18.h, horizontal: 8.w),
            width: 71.w,
            height: 71.h,
            child: SvgPicture.asset(image,
                fit: BoxFit.scaleDown,
                width: 40.w,
                color: const Color(0xffBFC3FA),
                height: 40.h),
            decoration: BoxDecoration(
                color: cImageB2Color,
                borderRadius: BorderRadius.circular(10.r)),
          ),
          SizedBox(width: 4.w),
          Expanded(
              child: Text(
            title,
            style: TextStyle(
                fontSize: 18.sp, fontFamily: 'Medium', color: cGrayColor),
          )),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 31.w, vertical: 38.h),
            child: Text(count, style: textStylePrimary16),
          )
        ],
      ),
    );
  }
}
