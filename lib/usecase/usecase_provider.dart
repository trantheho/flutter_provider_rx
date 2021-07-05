import 'package:flutter_provider_rx/provider/base/base_provider.dart';
import 'package:flutter_provider_rx/provider/book_provider.dart';
import 'package:flutter_provider_rx/provider/main_provider.dart';


/// add all model for use case  provider in app
class UseCaseProvider extends BaseProvider{
  MainProvider get mainProvider => getProvided();
  BookProvider get bookProvider => getProvided();
}