import 'dart:async';
import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_provider_rx/provider/book_provider.dart';
import 'package:flutter_provider_rx/provider/main_provider.dart';
import 'package:flutter_provider_rx/screens/authentication/login/login_screen.dart';
import 'package:flutter_provider_rx/screens/main_screen/main.dart';
import 'package:flutter_provider_rx/service/network_util.dart';
import 'package:flutter_provider_rx/usecase/app_usecase.dart' as appUseCase;
import 'package:flutter_provider_rx/utils/app_helper.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';

import 'generated/l10n.dart';
import 'globals.dart';
import 'widget/loading.dart';

void main() async {
  await initMyApp();
}

Future<void> initMyApp() async {
  WidgetsFlutterBinding.ensureInitialized();
  Directory directory = await getApplicationDocumentsDirectory();
  Hive.init(directory.path);
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MainProvider()),
        ChangeNotifierProvider(create: (_) => BookProvider()),
      ],
      child: Builder(builder: (context) {
        appUseCase.setContext(context);
        return MyApp();
      }),
    ),
  );
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  StreamSubscription networkSubscription;

  @override
  void dispose() {
    appController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) => postBuild(context));
    return MaterialApp(
      localizationsDelegates: [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      locale: Locale(ui.window.locale?.languageCode),
      supportedLocales: S.delegate.supportedLocales,
      navigatorKey: AppGlobals.rootNavKey,
      debugShowCheckedModeBanner: false,
      title: 'Flutter Provider Rx',
      builder: (context, child){
        return Stack(
          children: [
            child,
            StreamBuilder<bool>(
                stream: appController.loading.stream,
                initialData: false,
                builder: (context, snapshot) {
                  return snapshot.data ? AppLoading() : SizedBox();
                }
            ),
          ],
        );
      },
      home: FutureBuilder(
        future: context.read<MainProvider>().getCurrentUser(),
        builder:(context, state){

          if(state.connectionState == ConnectionState.done){

            final user = context.watch<MainProvider>().currentUser;

            return user != null ? MainScreen() : LoginScreen();
          }
          else{
            return AppLoading();
          }
        },
      ),
    );
  }


  void postBuild(BuildContext context) {
    checkNetworkResult();
  }

  void checkNetworkResult() {
    networkSubscription?.cancel();
    networkSubscription = NetworkingUtil().networkStatus.stream.distinct().listen((network){
      Logging.log('connect network: $network');
      if(!network){
        // show alert network
        AppHelper.dialogController.showNetworkDialog("Network", "Network not connected");
      }
    });
  }
}

class AppController {
  AppController._private();
  static final instance = AppController._private();
  final _appLoading = BehaviorSubject<bool>();
  bool _showAlertTimeOut = false;

  get loading => _appLoading;
  get alertTimeout => _showAlertTimeOut;

  void showLoading(){
    _appLoading.add(true);
  }

  void hideLoading(){
   _appLoading.add(false);
  }

  void dispose(){
    _appLoading.close();
  }
}

final appController = AppController.instance;
