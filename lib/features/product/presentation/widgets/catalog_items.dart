import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../core/utils/app_constants.dart';
import '../bloc/catalog/category_bloc.dart';

// ignore: must_be_immutable
class CatalogItems extends StatefulWidget {
  CatalogSuccessState state;
  CatalogBloc bloc;

  CatalogItems({
    Key? key,
    required this.state,
    required this.bloc,
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
      shrinkWrap: true,
      primary: false,
      itemCount: widget.state.list.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: widget.state.isLarge ? 4 : 1,
        mainAxisExtent: 90.w,
        crossAxisSpacing: 10.h,
        childAspectRatio: 1 / 1,
        mainAxisSpacing: widget.state.isLarge ? 20.w : 0.w,
      ),
      physics: const BouncingScrollPhysics(),
      padding:
          EdgeInsets.only(left: widget.state.isLarge ? 3.w : 11.w, top: 5.h),
      scrollDirection: widget.state.isLarge ? Axis.vertical : Axis.horizontal,
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: GestureDetector(
            onTap: () => setState(() => widget.bloc.add(ChangeColor(
                widget.state.list,
                index,
                widget.state.count,
                !widget.state.isLarge))),
            child: SizedBox(
              width: 89.w,
              height: widget.state.isLarge ? 380.h : 91.h,
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
                            child: Container(
                              color: const Color(0xffEDEDFD),
                              height: 66.h,
                              width: 66.w,
                              child: widget.state.list[index].image == null
                                  ? Container(
                                      margin: const EdgeInsets.all(20),
                                      child: SvgPicture.asset(
                                        'assets/icons/ic_fon_gallery.svg',
                                        fit: BoxFit.cover,
                                      ),
                                    )
                                  : CachedNetworkImage(
                                      fit: BoxFit.cover,
                                      imageUrl:
                                          widget.state.list[index].image ??
                                              'assets/icons/ic_fon_gallery.svg',
                                      placeholder: (context, url) {
                                        return Container(
                                          margin: const EdgeInsets.all(20),
                                          child: SvgPicture.asset(
                                            'assets/icons/ic_fon_gallery.svg',
                                            fit: BoxFit.cover,
                                          ),
                                        );
                                      },
                                    ),
                            )),
                      ),
                      SizedBox(
                          height: widget.state.selected != index ? 12.h : 18.h),
                      widget.state.selected != index
                          ? Text(
                              /// bu shunchaki so'zlarni bosh harf bilan yozish uchun
                              '${widget.state.list[index].name![0].toUpperCase()}${widget.state.list[index].name!.substring(1)}',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  color: primaryColor,
                                  fontFamily: 'Medium',
                                  fontSize: 10.sp),
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
                  Visibility(
                    visible: widget.state.count > 0,
                    child: Positioned(
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
                          '${widget.state.list[index].id}',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: cWhiteColor,
                              fontFamily: 'Medium',
                              fontSize: 9.sp),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
