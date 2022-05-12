import 'package:flutter/material.dart';
import 'package:flutter_provider_rx/internal/router/route_utils.dart';
import 'package:flutter_provider_rx/internal/utils/app_assets.dart';
import 'package:flutter_provider_rx/main.dart';
import 'package:flutter_provider_rx/provider/auth_provider.dart';
import 'package:provider/provider.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(AppImages.logo),
      ),
    );
  }
}
