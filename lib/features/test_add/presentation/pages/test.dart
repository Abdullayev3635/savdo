import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:savdo_agnet_client/features/test_add/presentation/manager/test_bloc.dart';

import '../../../../di/dependency_injection.dart';

class Test extends StatefulWidget {
  const Test({Key? key}) : super(key: key);

  static Widget screen() =>
      BlocProvider(create: (context) => di<TestBloc>(), child: const Test(),);

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  late TestBloc bloc;
  @override
  void initState() {
    super.initState();
    bloc = BlocProvider.of<TestBloc>(context);
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    bloc.close();
  }
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TestBloc, TestState>(
      builder: (context, state) {
        return Scaffold(
          body: Container(),
          floatingActionButton: FloatingActionButton(onPressed:(){bloc.add(GetDataEvent());},),
        );
      },
    );
  }
}
