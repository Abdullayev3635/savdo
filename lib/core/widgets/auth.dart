import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';

class LocalAuthApi {
  static final _auth = LocalAuthentication();

  static Future<bool> hasBiometrics() async {
    try {
      return await _auth.canCheckBiometrics;
    } on PlatformException {
      return false;
    }
  }

  static Future<List<BiometricType>> getBiometrics() async {
    try {
      return await _auth.getAvailableBiometrics();
    } on PlatformException {
      return <BiometricType>[];
    }
  }

  static Future<bool> authenticate() async {
    final isAvailable = await hasBiometrics();
    final support = await _auth.isDeviceSupported();
    if (!isAvailable) return false;
    if (!support) return false;
    try {
      return await _auth.authenticate(
        localizedReason: 'Davom etish uchun barmog`ingizni bosing',
        useErrorDialogs: true,
      );
    } catch (e) {
      return false;
    }
  }
}
