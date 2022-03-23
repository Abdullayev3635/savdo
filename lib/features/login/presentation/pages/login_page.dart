import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import '../widgets/call_button.dart';
import '../widgets/login_widget.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var maskFormatter = MaskTextInputFormatter(mask: '(##) ###-##-##');
  TextEditingController tel = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        reverse: true,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 182.h),
            // const Spacer(flex: 3),
            LoginWidget(
                maskFormatter: maskFormatter, tel: tel, password: password),
            SizedBox(height: 24.h),
            const CallButtonWidget(),
            // const Spacer(flex: 2),
          ],
        ),
      ),
      // resizeToAvoidBottomInset: false,
    );
  }
}
