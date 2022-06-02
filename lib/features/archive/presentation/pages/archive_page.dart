import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:savdo_agnet_client/core/utils/app_constants.dart';
import 'package:savdo_agnet_client/core/widgets/appBarWidget.dart';
import 'package:savdo_agnet_client/features/archive/presentation/bloc/archive_bloc.dart';
import 'package:savdo_agnet_client/features/archive/presentation/widgets/archive_shimmer_widget.dart';

import '../../../../di/dependency_injection.dart';
import '../widgets/archive_items.dart';

class ArchivePage extends StatefulWidget {
  const ArchivePage({Key? key}) : super(key: key);

  static Widget screen() => BlocProvider(
        create: (context) => di<ArchiveBloc>()..add(GetArchiveEvent()),
        child: const ArchivePage(),
      );

  @override
  _ArchivePageState createState() => _ArchivePageState();
}

class _ArchivePageState extends State<ArchivePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: cBackgroundColor,
      appBar: appBarWidget(context, 'Arxiv'),
      body: BlocBuilder<ArchiveBloc, ArchiveState>(
        builder: (context, state) {
          if (state is ArchiveLoadedState) {
            return ArxivItems(list: state.list);
          } else if (state is ArchiveLoadingState) {
            return const Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.0),
              child: ArchiveShimmerWidget(),
            );
          } else if (state is ArchiveLoadedFailureState) {
            return Center(
              child: Text(state.message,
                  style: TextStyle(
                      fontSize: 20.sp,
                      color: const Color(0xff939EB4),
                      fontFamily: 'Medium')),
            );
          }
          return const Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.0),
            child: ArchiveShimmerWidget(),
          );
        },
      ),
    );
  }
}
