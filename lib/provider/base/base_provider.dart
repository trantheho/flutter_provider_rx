import 'package:flutter/material.dart';
import 'package:flutter_provider_rx/provider/book_provider.dart';
import 'package:flutter_provider_rx/provider/main_provider.dart';
import 'package:flutter_provider_rx/services/local_storage/hive_storage.dart';
import 'package:provider/provider.dart';

BuildContext _mainContext;
BuildContext get mainContext => _mainContext;

void setContext(BuildContext c) {
  _mainContext = c;
}

abstract class BaseProvider {
  T getProvided<T>() {
    assert(_mainContext != null, "You must call AbstractCommand.init(BuildContext) method before calling Commands.");
    return _mainContext.read<T>();
  }
}

/// provider for loading
class LoadingProvider extends ChangeNotifier {
  bool _isLoading = false;

  bool get loading => _isLoading;

  void show(){
    _isLoading = true;
    notifyListeners();
  }

  void hide(){
    _isLoading = false;
    notifyListeners();
  }
}

/// provider for locale and language
class LocaleProvider extends ChangeNotifier {
  Locale locale;

  LocaleProvider() {
    _loadLocale();
  }

  Future<void> _loadLocale() async {
    final languageCode = await HiveStorage.instance.getLocale() ?? '';

    if (languageCode.isNotEmpty) {
      locale = Locale(languageCode);
    } else {
      locale = const Locale('en');
    }
    notifyListeners();
  }

  Future<void> updateLocale(Locale newLocale) async {
    try{
      await HiveStorage.instance.saveLocale(newLocale.languageCode);
      locale = newLocale;
      notifyListeners();
    }
    catch(error){
      throw StateError("update locale failed ${error.toString()}");
    }
  }
}