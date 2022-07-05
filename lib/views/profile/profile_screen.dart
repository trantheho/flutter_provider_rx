import 'package:flutter/material.dart';
import 'package:flutter_provider_rx/commands/authenticate_command/logout_command.dart';
import 'package:flutter_provider_rx/di/app_di.dart';
import 'package:flutter_provider_rx/internal/app_controller.dart';
import 'package:flutter_provider_rx/provider/auth_provider.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        /*leading: IconButton(
          onPressed: (){
            //appController.router.pop();
          },
          icon: const Icon(Icons.arrow_back, color: Colors.black,),
        ),*/
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: logout,
          child: const Text('logout'),
        ),
      ),
    );
  }

  void logout(){
    context.read<AuthProvider>().updateLoggedIn(false);
    LogoutCommand().run();
  }
}

