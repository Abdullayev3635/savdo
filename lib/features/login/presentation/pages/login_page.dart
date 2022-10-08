import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import '../../../../core/utils/app_constants.dart';
import '../../../../di/dependency_injection.dart';
import '../bloc/login_bloc.dart';
import '../widgets/call_button.dart';
import '../widgets/login_widget.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  static Widget screen() => BlocProvider(
    create: (context) => di<LoginBloc>(),
    child: const LoginPage(),
  );

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late LoginBloc _loginBloc;

  var maskFormatter = MaskTextInputFormatter(mask: '(##) ###-##-##');
  TextEditingController tel = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loginBloc = BlocProvider.of<LoginBloc>(context);
  }

  @override
  void dispose() {
    _loginBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: cBackgroundColor,
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        reverse: true,
        child: BlocBuilder<LoginBloc, LoginState>(
          builder: (context, state) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 182.h),
                LoginWidget(
                  maskFormatter: maskFormatter,
                  tel: tel,
                  password: password,
                  bloc: _loginBloc,
                  state: state,
                ),
                SizedBox(height: 24.h),
                const CallButtonWidget(),
              ],
            );
          },
        ),
      ),
      // resizeToAvoidBottomInset: false,
    );
  }
}
