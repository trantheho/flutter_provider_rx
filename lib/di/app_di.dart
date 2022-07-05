import 'package:flutter_provider_rx/internal/app_controller.dart';
import 'package:get_it/get_it.dart';

class AppDI {

  static void registerSingletons({bool testMode = false}) {
    GetIt.I.registerLazySingleton(() => AppController());

    if (testMode) {
      GetIt.I.pushNewScope();
      // TODO: implement test mode
    }
  }
}

/// Create global shortcut methods for common managers and services
final _get = GetIt.I.get;
AppController get appController => _get<AppController>();