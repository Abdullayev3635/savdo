import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/utils/app_constants.dart';
import '../bloc/catalog/catalog_bloc.dart';

// ignore: must_be_immutable
class CatalogItems extends StatefulWidget {
  CatalogSuccessState state;

  CatalogItems({
    Key? key,
    required this.state,
  }) : super(key: key);

  @override
  State<CatalogItems> createState() => _CatalogItemsState();
}

class _CatalogItemsState extends State<CatalogItems> {
  bool isActive = false;
  CatalogFailureState? failureState;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: widget.state.list.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: widget.state.isLarge ? 4 : 1,
        mainAxisExtent: 90.w,
        crossAxisSpacing: 10.h,
        childAspectRatio: 1 / 1,
        mainAxisSpacing: widget.state.isLarge ? 20.w : 0,
      ),
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.only(left: widget.state.isLarge ? 3.w : 11.w, top: 5),
      scrollDirection: widget.state.isLarge ? Axis.vertical : Axis.horizontal,
      itemBuilder: (context, index) => Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        child: GestureDetector(
          onTap: () {
            setState(() {
              isActive = !isActive;
            });
          },
          child: SizedBox(
            width: 89.w,
            height: widget.state.isLarge ? 380 : 91.h,
            child: Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.topRight,
              children: [
                Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(15.r),
                      child: ShaderMask(
                          shaderCallback: (Rect bounds) {
                            return LinearGradient(stops: const [
                              0.0,
                              0.0
                            ], colors: [
                              Colors.transparent,
                              widget.state.selected == index
                                  ? primaryColor07
                                  : Colors.transparent
                            ]).createShader(bounds);
                          },
                          blendMode: BlendMode.srcATop,
                          child:
                              Image.network(widget.state.list[index].image!)),
                    ),
                    SizedBox(height: isActive ? 12.h : 18.h),
                    widget.state.selected == index
                        ? Text(
                            '${widget.state.list[widget.state.selected].name}',
                            style: const TextStyle(
                                color: primaryColor,
                                fontFamily: 'Medium',
                                fontSize: 10),
                          )
                        : Container(
                            width: 13.w,
                            height: 3.h,
                            decoration: BoxDecoration(
                              color: primaryColor,
                              borderRadius: BorderRadius.circular(3.5.r),
                            ),
                          )
                  ],
                ),
                Positioned(
                  top: -4,
                  right: -5,
                  child: Container(
                    width: 18.w,
                    height: 18.h,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: const Color(0xffEB5757),
                        border: Border.all(width: 3, color: cWhiteColor)),
                    child: Text(
                      '4',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: cWhiteColor,
                          fontFamily: 'Medium',
                          fontSize: 9.sp),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
