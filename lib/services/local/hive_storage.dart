import 'package:hive/hive.dart';

class HiveStorage {
  HiveStorage._private();
  static final HiveStorage instance = HiveStorage._private();


  Future<String> getAccessToken() async {
    final box = await Hive.openBox<String>('token');
    final String accessToken = box.get('accessToken');
    return accessToken;
  }

  Future<void> saveAccessToken(String token) async {
    final box = await Hive.openBox<String>('token');
    await box.put('accessToken', token);
  }

  Future<void> removeAccessToken() async {
    final box = await Hive.openBox<String>('token');
    await box.put('accessToken', '');
  }

  Future<void> saveLocale(String languageCode) async {
    final box = await Hive.openBox<String>('locale');
    await box.put('languageCode', languageCode);
  }

  Future<String> getLocale() async {
    final box = await Hive.openBox<String>('locale');
    final String code =  box.get('languageCode');
    return code;
  }
}