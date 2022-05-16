import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:savdo_agnet_client/core/photo/image_picker_utils.dart';
import 'package:savdo_agnet_client/core/utils/app_constants.dart';
import 'package:savdo_agnet_client/di/dependency_injection.dart';
import 'package:savdo_agnet_client/features/select_client/presentation/pages/select_client.dart';
import 'package:savdo_agnet_client/core/widgets/dialog_frame.dart';
import '../../../tulov_qilish/presentation/widgets/text_field_widget.dart';

class PhotoReportDialog extends StatefulWidget {
  const PhotoReportDialog({Key? key}) : super(key: key);

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

  @override
  Widget build(BuildContext context) {
    TextEditingController izohController = TextEditingController();
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
                            clientName = value['name'].toString();
                            regionId = value['region_id'];
                            regionName = value['region_name'].toString();
                          })
                        }
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
                  SizedBox(
                    width: 16.w,
                  ),
                  pickedImage(_imageFile1, "1"),
                  SizedBox(
                    width: 16.w,
                  ),
                  pickedImage(_imageFile2, "2"),
                ],
              ),
            ),
            TextFieldHintWidget(
                keyboardType: TextInputType.text,
                controller: izohController,
                hintText: 'Izoh'),
            SizedBox(height: 24.h),
            ElevatedButton(
                onPressed: () {},
                style: buttonStyle,
                child: const Text(
                  'Davom etish',
                  textAlign: TextAlign.center,
                )),
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
        child: _imageFile == null
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
