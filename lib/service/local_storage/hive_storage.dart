import 'package:hive/hive.dart';

class HiveStorage {
  HiveStorage._private();
  static final HiveStorage instance = HiveStorage._private();


  Future<String> getAccessToken() async {
    var box = await Hive.openBox('token');
    String accessToken = await box.get('accessToken');
    return accessToken;
  }

  Future<void> saveAccessToken(String token) async {
    var box = await Hive.openBox('token');
    await box.put('accessToken', token);
  }

  Future<void> removeAccessToken() async {
    var box = await Hive.openBox('token');
    await box.put('accessToken', '');
  }



}