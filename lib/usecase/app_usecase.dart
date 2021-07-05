import 'package:flutter/material.dart';
import 'package:flutter_provider_rx/provider/book_provider.dart';
import 'package:flutter_provider_rx/provider/main_provider.dart';
import 'package:provider/provider.dart';

BuildContext _mainContext;
BuildContext get mainContext => _mainContext;

void setContext(BuildContext c) {
  _mainContext = c;
}

abstract class AppUseCase {

  T getProvided<T>() {
    assert(_mainContext != null, "You must call AbstractCommand.init(BuildContext) method before calling Commands.");
    return _mainContext.read<T>();
  }

  MainProvider get mainProvider => getProvided();

  BookProvider get bookProvider => getProvided();
}