import 'dart:async';
import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_provider_rx/internal/app_config.dart';
import 'package:flutter_provider_rx/internal/base/base_provider.dart'
    as base_provider;
import 'package:flutter_provider_rx/main.dart';
import 'package:flutter_provider_rx/provider/book_provider.dart';
import 'package:flutter_provider_rx/provider/main_provider.dart';
import 'package:flutter_provider_rx/services/network/network_util.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'generated/l10n.dart';
import 'internal/globals.dart';
import 'internal/widget/loading.dart';
import 'services/app_services/user_service.dart';
import 'views/authentication/login/login_screen.dart';
import 'views/main_screen/main_screen.dart';

Future<void> initMyApp() async {
  WidgetsFlutterBinding.ensureInitialized();
  AppConfig.build(Environment.dev);
  await _initLocaleStorage();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => base_provider.LoadingProvider()),
        ChangeNotifierProvider(create: (_) => base_provider.LocaleProvider()),
        ChangeNotifierProvider(create: (_) => MainProvider()),
        ChangeNotifierProvider(create: (_) => BookProvider()),
        Provider(create: (c) => UserService()),
      ],
      child: Builder(builder: (context) {
        base_provider.setContext(context);
        return MyApp();
      }),
    ),
  );
}

Future<void> _initLocaleStorage() async {
  Directory directory = await getApplicationDocumentsDirectory();
  Hive.init(directory.path);
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  StreamSubscription networkSubscription;

  @override
  void dispose() {
    appController.loading.dispose();
    appController.locale.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) => postBuild(context));
    return Consumer<base_provider.LocaleProvider>(
        builder: (_, localeProvider, __) {
      return MaterialApp(
        localizationsDelegates: [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        locale: localeProvider.locale ?? Locale(ui.window.locale?.languageCode),
        supportedLocales: S.delegate.supportedLocales,
        navigatorKey: AppGlobals.rootNavKey,
        debugShowCheckedModeBanner: false,
        title: 'Flutter Provider Rx',
        builder: (context, child) {
          return Stack(
            children: [
              child,
              Consumer<base_provider.LoadingProvider>(
                  builder: (_, loadingProvider, __) {
                return loadingProvider.loading ? AppLoading() : SizedBox();
              }),
            ],
          );
        },
        home: FutureBuilder(
          future: context.read<MainProvider>().getCurrentUser(),
          builder: (context, state) {
            if (state.connectionState == ConnectionState.done) {
              final user = context.watch<MainProvider>().currentUser;

              return user != null ? MainScreen() : LoginScreen();
            } else {
              return AppLoading();
            }
          },
        ),
      );
    });
  }

  void postBuild(BuildContext context) {
    checkNetworkResult();
  }

  void checkNetworkResult() {
    networkSubscription?.cancel();
    networkSubscription =
        NetworkingUtil().networkStatus.stream.distinct().listen((network) {
      print('connect network: $network');
      if (!network) {
        appController.dialog.showNetworkDialog("Network", "Network not connected");
      }
    });
  }
}
