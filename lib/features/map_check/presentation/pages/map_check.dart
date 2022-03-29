import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:savdo_agnet_client/core/utils/app_constants.dart';

class MapCheck extends StatefulWidget {
  const MapCheck({Key? key}) : super(key: key);

  @override
  State<MapCheck> createState() => MapCheckState();
}

class MapCheckState extends State<MapCheck> {
  @override
  void initState() {
    _determinePosition(_controller, 10, textEditingController);
    super.initState();
  }

  final Completer<GoogleMapController> _controller = Completer();

  TextEditingController textEditingController = TextEditingController();

  String adress = "";

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(41.311155, 69.279700),
    zoom: 12,
  );
  var myMarker = const Marker(
    markerId: MarkerId("Salom"),
    position: LatLng(41.311155, 69.279700),
    icon: BitmapDescriptor.defaultMarker,
  );

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(20.r))),
        backgroundColor: Colors.white,
        leading: Padding(
          padding: const EdgeInsets.only(left: 15),
          child: IconButton(

            onPressed: () {
              Navigator.pop(context);
            },
            icon: SvgPicture.asset("assets/icons/ic_arrow_back.svg"),
          ),
        ),
        title: const Text(
          "Joylashuv",
          style: TextStyle(
            fontFamily: "Medium",
            color: primaryColor,
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
        toolbarHeight: 94,
        bottom: PreferredSize(
          preferredSize: const Size(double.infinity, 100),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.r),
                color: cTextFieldColor,
              ),
              height: 60.h,
              padding: EdgeInsets.fromLTRB(15.w, 2.h, 5.w, 0.h),
              child: Center(
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        _adress(textEditingController.text, _controller);
                      },
                      icon: SvgPicture.asset(
                        'assets/icons/ic_search.svg',
                        width: 24.w,
                        height: 24.h,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    Expanded(
                      child: TextFormField(
                        cursorColor: primaryColor,
                        controller: textEditingController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Qidirish",
                          hintStyle: TextStyle(
                              fontSize: 16.sp,
                              color: cHintTextColor,
                              fontFamily: "Regular"),
                          prefixIconConstraints: BoxConstraints(
                            maxWidth: 30.w,
                            maxHeight: 30.h,
                            minHeight: 25.h,
                            minWidth: 25.w,
                          ),
                        ),
                        style: TextStyle(
                            fontSize: 16.sp,
                            color: primaryColor,
                            fontFamily: "Regular"),
                      ),
                    ),
                    IconButton(
                      icon: SvgPicture.asset(
                        'assets/icons/ic_gps.svg',
                      ),
                      onPressed: () {
                        _determinePosition(
                            _controller, 18, textEditingController);
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          GoogleMap(
            mapType: MapType.normal,
            onTap: _tapped,
            zoomControlsEnabled: false,
            markers: {myMarker},
            initialCameraPosition: _kGooglePlex,
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                height: 110.h,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: cWhiteColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.r),
                    topRight: Radius.circular(20.r),
                  ),
                ),
                child: Center(
                  child: Container(
                    decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(15.r),
                    ),
                    height: 65.h,
                    width: 368.w,
                    child: Center(
                      child: Text(
                        'Saqlash',
                        style: TextStyle(
                            color: cWhiteColor,
                            fontFamily: 'Medium',
                            fontWeight: FontWeight.w500,
                            fontSize: 16.sp),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  _adress(String adress, Completer<GoogleMapController> controller1) async {
    List<Location> locations = await locationFromAddress(adress);
    myMarker = Marker(
        markerId: const MarkerId("salom"),
        position: LatLng(locations[0].latitude, locations[0].longitude));
    setState(() {});
    final GoogleMapController controller = await controller1.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: LatLng(locations[0].latitude, locations[0].longitude),
        zoom: 14)));
    _tapped(LatLng(locations[0].latitude, locations[0].longitude));
  }

  _tapped(LatLng tappedPoint) async {
    setState(() {
      myMarker =
          Marker(markerId: const MarkerId("salom"), position: tappedPoint);
    });
    List<Placemark> placemarks = await placemarkFromCoordinates(
        tappedPoint.latitude, tappedPoint.longitude);
    textEditingController.text = placemarks[0].administrativeArea.toString() +
        ", " +
        (placemarks[0].thoroughfare ?? placemarks[0].street).toString();
  }

  _determinePosition(Completer<GoogleMapController> controller1, double zoom,
      TextEditingController textEditingController) async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    var position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    final GoogleMapController controller = await controller1.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
      target: LatLng(position.latitude, position.longitude),
      zoom: zoom,
    )));
    if (zoom == 18) {
      List<Placemark> placemarks =
          await placemarkFromCoordinates(position.latitude, position.longitude);
      textEditingController.text = placemarks[0].administrativeArea.toString() +
          ", " +
          (placemarks[0].thoroughfare ?? placemarks[0].street).toString();
    }

    myMarker = Marker(
        markerId: const MarkerId("salom"),
        position: LatLng(position.latitude, position.longitude));
    setState(() {});
  }
}
