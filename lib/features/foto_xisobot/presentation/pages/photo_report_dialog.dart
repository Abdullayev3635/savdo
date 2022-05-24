import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:savdo_agnet_client/core/photo/image_picker_utils.dart';
import 'package:savdo_agnet_client/core/utils/app_constants.dart';
import 'package:savdo_agnet_client/core/widgets/costum_toast.dart';
import 'package:savdo_agnet_client/di/dependency_injection.dart';
import 'package:savdo_agnet_client/features/foto_xisobot/data/datasources/foto_remote_datasource.dart';
import 'package:savdo_agnet_client/features/foto_xisobot/presentation/bloc/foto_bloc.dart';
import 'package:savdo_agnet_client/features/select_client/presentation/pages/select_client.dart';
import 'package:savdo_agnet_client/core/widgets/dialog_frame.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../tulov_qilish/presentation/widgets/text_field_widget.dart';

class PhotoReportDialog extends StatefulWidget {
  const PhotoReportDialog({Key? key}) : super(key: key);

  static Widget screen() => BlocProvider(
        create: (context) => di<FotoBloc>(),
        child: const PhotoReportDialog(),
      );

  @override
  _PhotoReportDialogState createState() => _PhotoReportDialogState();
}

class _PhotoReportDialogState extends State<PhotoReportDialog> {
  int clientId = 0;
  int regionId = 0;
  String clientName = 'Mijozni tanlang';
  String regionName = 'Region tanlang';
  File? _imageFile0, _imageFile1, _imageFile2;
  String sana0 = "", sana1 = "", sana2 = "";

  final customFormat = DateFormat('yyyy.MM.dd hh:mm');
  TextEditingController izohController = TextEditingController();
  late FotoBloc bloc;
  SharedPreferences sharedPreferences = di.get();

  @override
  void initState() {
    super.initState();
    bloc = BlocProvider.of<FotoBloc>(context);
    // pd = ProgressDialog(context: context);
  }

  @override
  void dispose() {
    super.dispose();
    bloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height / 5),
      reverse: true,
      child: AllDialogSkeleton(
        title: 'Foto hisobot',
        icon: 'assets/icons/ic_camera.svg',
        child: Column(
          children: [
            SizedBox(height: 23.h),
            GestureDetector(
              onTap: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return SelectPart.screen();
                    }).then((value) => {
                      if (value != null)
                        {
                          setState(() {
                            clientId = value['id'];
                            regionId = value['regionId'];
                            clientName = value['name'].toString();
                            regionName = value['regionName'].toString();
                          })
                        },
                    });
              },
              child: Container(
                height: 60.h,
                margin: EdgeInsets.only(bottom: 16.h),
                padding: EdgeInsets.only(left: 18.w, right: 10.w),
                decoration: BoxDecoration(
                    color: cTextFieldColor,
                    borderRadius: BorderRadius.circular(10.r)),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        clientName,
                        style: textStylePrimaryMed14,
                      ),
                    ),
                    SvgPicture.asset('assets/icons/ic_dropdown.svg')
                  ],
                ),
              ),
            ),
            Container(
              height: 60.h,
              margin: EdgeInsets.only(bottom: 16.h),
              padding: EdgeInsets.only(left: 18.w, right: 10.w),
              decoration: BoxDecoration(
                  color: cTextFieldColor,
                  borderRadius: BorderRadius.circular(10.r)),
              child: Row(
                children: [
                  Expanded(
                    child: Text(regionName, style: textStylePrimaryMed14),
                  ),
                  SvgPicture.asset('assets/icons/ic_dropdown.svg')
                ],
              ),
            ),
            SizedBox(
              height: 103.h,
              child: Row(
                children: [
                  pickedImage(_imageFile0, "0"),
                  SizedBox(width: 16.w),
                  pickedImage(_imageFile1, "1"),
                  SizedBox(width: 16.w),
                  pickedImage(_imageFile2, "2"),
                ],
              ),
            ),
            TextFieldHintWidget(
                keyboardType: TextInputType.text,
                controller: izohController,
                hintText: 'Izoh'),
            SizedBox(height: 24.h),
            BlocBuilder<FotoBloc, FotoState>(
              builder: (context, state) {
                if (state is FotoLoading) {
                  Future.delayed(
                    Duration.zero,
                    () {
                      return showDialog(
                          context: context,
                          builder: (context) {
                            return ValueListenableBuilder(
                              valueListenable: progress,
                              builder: (context, value, widget) {
                                return Dialog(
                                  insetPadding: EdgeInsets.symmetric(
                                      vertical: 20.h, horizontal: 50.w),
                                  child: Container(
                                    height: 80.h,
                                    padding:
                                        EdgeInsets.symmetric(vertical: 20.h),
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 10.w),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.r),
                                      color: Colors.white,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        CircularProgressIndicator(
                                          value: double.parse(value.toString()),
                                          valueColor:
                                              const AlwaysStoppedAnimation<
                                                  Color>(primaryColor),
                                        ),
                                        SizedBox(width: 15.w),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            Text('Malumotlar yuklanmoqda...',
                                                style: textStylePrimaryMed14),
                                            Text('${value.toString()}/100%',
                                                style: textStylePrimaryMed14)
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          });
                    },
                  );
                } else if (state is FotoLoaded) {
                  // pd.close();
                  Navigator.pop(context);
                  Future.delayed(Duration.zero, () {
                    Navigator.pop(context);
                  });
                  CustomToast.showToast(state.message);
                }
                return Container();
              },
            ),
            ElevatedButton(
              onPressed: () {
                if (_imageFile0 != null ||
                    _imageFile1 != null ||
                    _imageFile2 != null && clientName != 'Mijozni tanlang') {
                  bloc.add(SendFotoEvent(
                    image1: _imageFile0 == null ? ' ' : _imageFile0?.path,
                    image2: _imageFile1 == null ? ' ' : _imageFile1?.path,
                    image3: _imageFile2 == null ? ' ' : _imageFile2?.path,
                    customerId: clientId,
                    regionId: regionId,
                    salesAgentId: int.parse(
                        sharedPreferences.getString(sharedSalesAgentId) ?? ''),
                  ));
                } else {
                  CustomToast.showToast('Iltimos mijoz va suratlarni tanlang!');
                }
              },
              style: buttonStyle,
              child: const Text(
                'Davom etish',
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget pickedImage(File? _imageFile, String key) {
    return Expanded(
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () async {
          final picker = di<ImagePickerUtils>();
          if (key == "0") {
            _imageFile0 = File(await picker.selectImageFromCamera());
            sana0 = customFormat.format(DateTime.now()).toString();
          } else if (key == "1") {
            _imageFile1 = File(await picker.selectImageFromCamera());
            sana1 = customFormat.format(DateTime.now()).toString();
          } else if (key == "2") {
            _imageFile2 = File(await picker.selectImageFromCamera());
            sana2 = customFormat.format(DateTime.now()).toString();
          }
          setState(() {});
        },
        child: (_imageFile == null || _imageFile.path == '')
            ? SvgPicture.asset('assets/icons/ic_add_image.svg')
            : Stack(
                clipBehavior: Clip.none,
                fit: StackFit.expand,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Image.file(
                      _imageFile,
                      fit: BoxFit.fill,
                    ),
                  ),
                  Align(
                    alignment: const Alignment(1.15, -1.15),
                    child: InkWell(
                      onTap: () {
                        if (key == "0") {
                          _imageFile0 = null;
                        } else if (key == "1") {
                          _imageFile1 = null;
                        } else if (key == "2") {
                          _imageFile2 = null;
                        }
                        setState(() {});
                      },
                      child: SvgPicture.asset(
                        "assets/icons/ic_red_close.svg",
                        width: 20.w,
                        height: 20.h,
                      ),
                    ),
                  ),
                ],
              ),
      ),
      flex: 1,
    );
  }
}
