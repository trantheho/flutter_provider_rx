
import 'package:flutter_provider_rx/internal/base/base_provider.dart';
import 'package:flutter_provider_rx/provider/book_provider.dart';
import 'package:flutter_provider_rx/provider/main_provider.dart';
import 'package:flutter_provider_rx/services/app_services/user_service.dart';

class BaseCommand extends BaseProvider{
  // provider
  MainProvider get mainProvider => getProvided();
  BookProvider get bookProvider => getProvided();

  // service
  UserService get userService => getProvided();
}