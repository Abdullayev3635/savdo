import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:savdo_agnet_client/core/utils/app_constants.dart';
import 'package:savdo_agnet_client/features/main/presentation/pages/main_page.dart';

import '../../../../di/dependency_injection.dart';
import '../../domain/bloc/pass_bloc.dart';
import '../widgets/num_pad.dart';

class PasswordScreen extends StatefulWidget {
  const PasswordScreen({Key? key}) : super(key: key);

  static Widget screen() => BlocProvider(
        create: (context) => di<PassBloc>(),
        child: const PasswordScreen(),
      );

  @override
  _PasswordScreenState createState() => _PasswordScreenState();
}

class _PasswordScreenState extends State<PasswordScreen> {
  late PassBloc bloc;
  bool onError = false;

  @override
  void initState() {
    bloc = BlocProvider.of<PassBloc>(context);
    super.initState();
  }

  @override
  void dispose() {
    bloc.close();
    super.dispose();
  }

  final TextEditingController _pinPutController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PassBloc, PassState>(
      builder: (context, state) {
        SchedulerBinding.instance?.addPostFrameCallback((_) {
          if (state is PassSuccess) {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const MainPage(),
                ));
          }
        });
        return Scaffold(
          body: Container(
            color: primaryColor,
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SvgPicture.asset("assets/icons/imsoft_logo.svg",
                        color: cWhiteColor, width: 268.w, height: 55.h),
                    SizedBox(height: 103.h),
                    Text(
                      'Maxfiy parol kiriting',
                      style: TextStyle(
                          fontFamily: 'Medium',
                          fontSize: 18.sp,
                          color: cWhiteColor),
                    ),
                    SizedBox(height: 12.sp),
                    SizedBox(
                      width: 114.w,
                      height: 20.h,
                      child: PinCodeTextField(
                        showCursor: false,
                        appContext: context,
                        controller: _pinPutController,
                        length: 4,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        obscuringWidget: Container(
                          height: 10.h,
                          width: 10.w,
                          decoration: BoxDecoration(
                            color: cWhiteColor,
                            borderRadius: BorderRadius.circular(7),
                          ),
                        ),
                        enableActiveFill: true,
                        enablePinAutofill: true,
                        pinTheme: PinTheme(
                          fieldHeight: 10.h,
                          fieldWidth: 10.w,
                          borderWidth: 0,
                          shape: PinCodeFieldShape.circle,
                          activeColor: cWhiteColor,
                          inactiveColor: cInActiveColor,
                          disabledColor: cInActiveColor,
                          activeFillColor: cInActiveColor,
                          selectedFillColor: cInActiveColor,
                          inactiveFillColor: cInActiveColor,
                          errorBorderColor: cInActiveColor,
                        ),
                        onCompleted: (value) {
                          if (value.length == 4) {
                            bloc.add(PassCompileEvent(
                                passController: _pinPutController));
                          }
                        },
                        onChanged: (controllerPin) {},
                      ),
                    ),
                    SizedBox(
                      height: 35.h,
                    ),
                    numPad(_pinPutController, context),
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
