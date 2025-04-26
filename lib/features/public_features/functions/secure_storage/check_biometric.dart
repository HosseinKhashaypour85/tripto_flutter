import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class CheckBioSecureStorage {
  final FlutterSecureStorage _storage = FlutterSecureStorage();

  Future<void> saveBiometricEnabled(bool value) async {
    await _storage.write(key: 'biometric_enabled', value: value.toString());
  }

  Future<bool> isBiometricEnabled() async {
    String? value = await _storage.read(key: 'biometric_enabled');
    return value == 'true';
  }

  Future<void> deleteUserToken() async {
    await _storage.delete(key: 'user_token');
  }
}
