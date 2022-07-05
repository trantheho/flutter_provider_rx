import 'package:flutter_provider_rx/di/app_di.dart';
import 'package:flutter_provider_rx/my_app.dart';
import 'package:get_it/get_it.dart';

import 'internal/app_controller.dart';

void main() async {
  AppDI.registerSingletons();
  await initMyApp();
}


