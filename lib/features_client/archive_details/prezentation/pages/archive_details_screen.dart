import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:savdo_agnet_client/core/widgets/appBarWidget.dart';
import 'package:savdo_agnet_client/core/widgets/costum_toast.dart';
import 'package:savdo_agnet_client/features/archive_details/data/model/archive_details_model.dart';
import 'package:savdo_agnet_client/features/archive_details/prezentation/widgets/detail_list_items.dart';
import 'package:savdo_agnet_client/features/archive_details/prezentation/widgets/details_shimmer_widget.dart';

import '../../../../../../../core/utils/app_constants.dart';
import '../../../../di/dependency_injection.dart';
import '../bloc/archive_details_bloc.dart';

int? globalOrderId = 0;

class ArchiveDetailsScreen extends StatefulWidget {
  const ArchiveDetailsScreen({Key? key}) : super(key: key);

  static Widget screen({required int? orderId}) {
    globalOrderId = orderId;
    return BlocProvider(
        create: (context) => di<ArchiveDetailsBloc>()
          ..add(GetArchiveDetailsData(orderId: orderId)),
        child: const ArchiveDetailsScreen(),
      );
  }

  @override
  State<ArchiveDetailsScreen> createState() => _ArchiveDetailsScreenState();
}

class _ArchiveDetailsScreenState extends State<ArchiveDetailsScreen> {
  late ArchiveDetailsBloc bloc;
  var archiveDetailsList = <ArchiveDetailsModel>[];
  num totalPrice = 0;

  @override
  void initState() {
    super.initState();
    bloc = BlocProvider.of<ArchiveDetailsBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<ArchiveDetailsBloc, ArchiveDetailsState>(
          builder: (context, state) {
        if (state is ArchiveDetailsFailureState) {
          CustomToast.showToast('Malumot uzatishda xatolik yuz berdi');
        } else if (state is ArchiveDetailsLoadingState) {
          return Scaffold(
            backgroundColor: cBackgroundColor,
            appBar: appBarWidget(context, 'Buyurtma №$globalOrderId'),
            body: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.0),
              child: DetailsShimmerWidget(),
            ),
          );
        } else if (state is ArchiveDetailsLoadedState) {
          archiveDetailsList = state.list;
          totalPrice = 0;
          for (int i = 0; i < state.list.length; i++) {
            totalPrice += int.parse(archiveDetailsList[i].quantity ?? '0') *
                int.parse(archiveDetailsList[i].price ?? '0');
          }
        }

        return Scaffold(
          backgroundColor: cBackgroundColor,
          appBar: appBarWidget(context, 'Buyurtma №$globalOrderId'),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: archiveDetailsList.isEmpty
                    ? Container()
                    : SizedBox(
                        height: MediaQuery.of(context).size.height / 1.3,
                        child: DetailListItems(detailsList: archiveDetailsList),
                      ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
