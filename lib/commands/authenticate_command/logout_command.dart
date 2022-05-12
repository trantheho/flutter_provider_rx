import 'package:flutter_provider_rx/commands/base_command.dart';

class LogoutCommand extends BaseCommand{

  Future<void> run() async{
   mainProvider.updateCurrentUser = null;
  }
}