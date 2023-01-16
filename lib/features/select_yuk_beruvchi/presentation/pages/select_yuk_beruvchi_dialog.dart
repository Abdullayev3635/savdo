import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:savdo_agnet_client/core/utils/app_constants.dart';

import '../../../../di/dependency_injection.dart';
import '../bloc/viloyat/yuk_bloc.dart';

class SelectYukBeruvchi extends StatefulWidget {
  const SelectYukBeruvchi({Key? key}) : super(key: key);

  static Widget screen() => BlocProvider(
        create: (context) =>
            di<YukBeruvchiBloc>()..add(GetSelectViloyatEvent()),
        child: const SelectYukBeruvchi(),
      );

  @override
  _SelectViloyatState createState() => _SelectViloyatState();
}

class _SelectViloyatState extends State<SelectYukBeruvchi> {
  late YukBeruvchiBloc _bloc;

  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    _bloc = BlocProvider.of<YukBeruvchiBloc>(context);
    super.initState();
  }

  @override
  void dispose() {
    _bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.r),
      ),
      elevation: 2,
      insetPadding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 50.h),
      child: Container(
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.symmetric(horizontal: 10.w),
        child: BlocBuilder<YukBeruvchiBloc, ViloyatState>(
          builder: (context, state) {
            if (state is SelectViloyatSuccess) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(height: 20.h),
                  TextField(
                      style: textStylePrimaryReg16,
                      textAlign: TextAlign.left,
                      decoration: InputDecoration(
                        hintText: 'Qidirish',
                        prefixIcon: const Icon(Icons.search),
                        contentPadding: EdgeInsets.all(20.0.sp),
                      ),
                      onChanged: (text) {
                        _bloc.add(
                            FilterViloyatEvent(text: text, list: state.list));
                      }),
                  Expanded(
                    child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: state.list.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            Navigator.pop(context, {
                              "id": state.list[index].id,
                              "title": state.list[index].name,
                            });
                          },
                          child: Container(
                            height: 50.h,
                            width: MediaQuery.of(context).size.width,
                            margin: EdgeInsets.symmetric(
                              horizontal: 10.w,
                              vertical: 6.h,
                            ),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: primaryColor),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  state.list[index].name!,
                                  style: TextStyle(
                                      fontSize: 16.sp, color: cWhiteColor),
                                  maxLines: 2,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 20.h),
                ],
              );
            } else if (state is SelectViloyatLoading) {
              return Column(
                children: [
                  SizedBox(height: 20.h),
                  TextField(
                    style: textStylePrimaryReg16,
                    textAlign: TextAlign.left,
                    decoration: InputDecoration(
                      hintText: 'Qidirish',
                      prefixIcon: const Icon(Icons.search),
                      contentPadding: EdgeInsets.all(20.0.sp),
                    ),
                  ),
                  const Expanded(child: CupertinoActivityIndicator()),
                ],
              );
            } else {
              return Column(
                children: [
                  SizedBox(height: 20.h),
                  TextField(
                    style: textStylePrimaryReg16,
                    textAlign: TextAlign.left,
                    decoration: InputDecoration(
                      hintText: 'Qidirish',
                      prefixIcon: const Icon(Icons.search),
                      contentPadding: EdgeInsets.all(20.0.sp),
                    ),
                  ),
                  const Expanded(child: CupertinoActivityIndicator()),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
