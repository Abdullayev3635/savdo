import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:savdo_agnet_client/core/widgets/dialog_frame.dart';

import '../../../../core/utils/app_constants.dart';
import '../../../../core/widgets/costum_toast.dart';
import '../../../../di/dependency_injection.dart';
import '../bloc/pin_bloc.dart';
import '../widgets/password_text_field_widget.dart';

class PasswordEditDialog extends StatefulWidget {
  const PasswordEditDialog({Key? key}) : super(key: key);

  static Widget screen() => BlocProvider(
        create: (context) => di<PinBloc>()..add(IsSharedPinEmpty()),
        child: const PasswordEditDialog(),
      );

  @override
  _PasswordEditDialogState createState() => _PasswordEditDialogState();
}

class _PasswordEditDialogState extends State<PasswordEditDialog> {
  bool isOldVisible = true;
  bool isNewVisible = true;
  bool isConfirmVisible = true;
  TextEditingController oldPassword = TextEditingController();
  TextEditingController newPassword = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  var maskFormatter = MaskTextInputFormatter(mask: '####');
  late PinBloc bloc;

  @override
  void initState() {
    bloc = BlocProvider.of<PinBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AllDialogSkeleton(
      title: 'Parolni o’rnatish(o’zgartirish)',
      icon: 'assets/icons/ic_shield-security.svg',
      child: BlocBuilder<PinBloc, PinState>(
        builder: (context, state) {
          if (state is PinSuccessState) {
            Navigator.pop(context);
          } else if (state is PinConfirmFailureState) {
            CustomToast.showToast(state.message);
            bloc.add(IsSharedPinEmpty());
          } else if (state is PinIsEmptyState) {
            return Column(
              children: [
                SizedBox(height: 24.h),
                Visibility(
                  visible: state.isEmpty,
                  child: PasswordTextFieldWidget(
                    controller: oldPassword,
                    visible: isOldVisible,
                    hintTextTitle: 'Eski parolni kiriting',
                    inputFormatter: maskFormatter,
                    prefix: false,
                  ),
                ),
                PasswordTextFieldWidget(
                  controller: newPassword,
                  visible: isNewVisible,
                  hintTextTitle: 'Yangi parolni kiriting',
                  inputFormatter: maskFormatter,
                  prefix: true,
                ),
                PasswordTextFieldWidget(
                  controller: confirmPassword,
                  visible: isConfirmVisible,
                  hintTextTitle: 'Parolni tasdiqlang',
                  inputFormatter: maskFormatter,
                  prefix: true,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          'Qaytish',
                          style: textStylePrimaryMed16,
                        ),
                        style: ButtonStyle(
                          fixedSize: MaterialStateProperty.all(Size(
                              MediaQuery.of(context).size.width / 2.5, 57.h)),
                          elevation: MaterialStateProperty.all(0),
                          backgroundColor: MaterialStateProperty.all(
                              primaryColor.withOpacity(0.1)),
                          shape:
                              MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          )),
                        )),
                    ElevatedButton(
                      style: ButtonStyle(
                          fixedSize: MaterialStateProperty.all(Size(
                              MediaQuery.of(context).size.width / 2.5, 57.h)),
                          backgroundColor:
                              MaterialStateProperty.all(primaryColor),
                          elevation: MaterialStateProperty.all(0),
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)))),
                      onPressed: () {
                        bloc.add(OnPressedEvent(
                          newPassword: newPassword,
                          confirmPassword: confirmPassword,
                          oldPassword: oldPassword,
                        ));
                        setState(() {});
                      },
                      child: Text('Saqlash',
                          style: TextStyle(
                              color: cWhiteColor,
                              fontSize: 16.sp,
                              fontFamily: 'Medium')),
                    ),
                  ],
                )
              ],
            );
          }
          return  Center(
            child: SizedBox(
                height: 310.h,
                child: const CupertinoActivityIndicator()),
          );
        },
      ),
    );
  }
}
