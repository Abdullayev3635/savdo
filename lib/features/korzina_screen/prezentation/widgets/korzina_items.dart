import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hive/hive.dart';
import 'package:savdo_agnet_client/core/utils/app_constants.dart';
import 'package:savdo_agnet_client/di/dependency_injection.dart';
import 'package:savdo_agnet_client/features/korzina_screen/data/korzina_hive/korzina_hive.dart';
import 'package:savdo_agnet_client/features/product_items/presentation/widgets/product_dialog.dart';

import '../bloc/korzina_bloc.dart';

class KorzinaItemsWidget extends StatefulWidget {
  final List<KorzinaCard>? transaction;
  final Box<KorzinaCard> box;

  const KorzinaItemsWidget({
    Key? key,
    required this.transaction,
    required this.box,
  }) : super(key: key);

  @override
  State<KorzinaItemsWidget> createState() => _KorzinaItemsWidgetState();
}

class _KorzinaItemsWidgetState extends State<KorzinaItemsWidget> {
  late KorzinaBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = di<KorzinaBloc>()..add(KorzinaInitialEvent());
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      primary: false,
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.symmetric(horizontal: 21.w),
      itemCount: widget.transaction!.isEmpty ? 0 : widget.transaction?.length,
      itemBuilder: (context, index) {
        KorzinaCard? card = widget.box.getAt(index);

        return Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.r), color: cWhiteColor),
          child: SlidableAutoCloseBehavior(
            closeWhenTapped: true,
            child: Slidable(
              key: Key('${card?.id}'),
              direction: Axis.horizontal,
              endActionPane: ActionPane(
                extentRatio: 0.48,
                motion: const BehindMotion(),
                dragDismissible: false,
                children: [
                  InkWell(
                    onTap: () async {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return ProductItemDialog(
                              bloklarSoni:
                                  widget.transaction?[index].bloklarSoni,
                              dona: widget.transaction?[index].dona,
                              blok: widget.transaction?[index].blok ?? '0',
                              category: widget.transaction?[index].category,
                              name: widget.transaction?[index].name,
                              price: widget.transaction?[index].price,
                              image: null,
                              residue: widget.transaction?[index].residue,
                              id: widget.transaction![index].id!,
                              size: widget.transaction![index].size,
                              currencyName:
                                  widget.transaction![index].currencyName,
                              currencyId: widget.transaction![index].currencyId,
                            );
                          });
                    },
                    borderRadius: const BorderRadius.horizontal(
                        right: Radius.circular(15)),
                    child: Container(
                      width: 88.w,
                      height: 167.h,
                      decoration: const BoxDecoration(color: primaryColor),
                      child: const Icon(Icons.edit, color: cWhiteColor),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {});
                      card?.delete();
                      bloc.add(KorzinaInitialEvent());
                    },
                    borderRadius:
                        BorderRadius.horizontal(right: Radius.circular(15.r)),
                    child: Container(
                      width: 88.w,
                      height: 167.h,
                      decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.horizontal(
                              right: Radius.circular(15.r))),
                      child: const Icon(Icons.delete, color: cWhiteColor),
                    ),
                  ),
                ],
              ),
              child: Container(
                padding: EdgeInsets.only(top: 21.h, bottom: 12.h, left: 21.w),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.r),
                    color: cWhiteColor),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 70.h,
                      width: 70.w,
                      margin: EdgeInsets.only(bottom: 9.h),
                      // padding: const EdgeInsets.all(45),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.r),
                        color: cBackgroundColor,
                      ),
                      child: SizedBox(
                          child:
                              // widget.image == null?
                              SvgPicture.asset(
                        "assets/icons/ic_gallery.svg",
                        fit: BoxFit.none,
                        color: const Color(0xffBFC3FA),
                      )
                          // : Image.network(widget.image!),
                          ///todo: imageni ko'rish kerak
                          ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 23.w),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                              widget.transaction![index].name ??
                                  ''.toUpperCase(),
                              style: TextStyle(
                                  color: primaryColor,
                                  fontSize: 18.sp,
                                  fontFamily: 'GilroyMedium')),
                          SizedBox(height: 4.h),
                          Text(
                            widget.transaction![index].category ?? '',
                            style: TextStyle(
                                fontFamily: 'GilroyRegular',
                                fontSize: 12.sp,
                                color: primaryColor),
                          ),
                          SizedBox(height: 7.h),
                          Text(
                            '${widget.transaction![index].price} ${widget.transaction![index].currencyName}',
                            style: TextStyle(
                                color: const Color(0xffDC200E),
                                fontSize: 16.sp,
                                fontFamily: 'GilroyMedium'),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
