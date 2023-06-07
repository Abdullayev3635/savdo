import 'package:geolocator/geolocator.dart';

abstract class LocationService {
  Future<String> getLatLang();
}

class LocationServiceImpl extends LocationService {
  @override
  Future<String> getLatLang() async {
    LocationPermission permission;
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.deniedForever) {
        return "0,0";
      }
    }
    final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    return position.latitude.toString() + "," + position.longitude.toString();
  }
}
