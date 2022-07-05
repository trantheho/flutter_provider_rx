import 'package:flutter/material.dart';
import 'package:flutter_provider_rx/services/local/hive_storage.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';

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


class LoadingManager{
  final _loadingStream = BehaviorSubject<bool>();
  ValueStream get stream => _loadingStream.stream;

  void hide() => _loadingStream.add(false);

  void show()=> _loadingStream.add(true);

  void dispose()=> _loadingStream.close();
}


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