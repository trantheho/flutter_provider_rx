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
import 'package:flutter_provider_rx/provider/home_provider.dart';
import 'package:flutter_provider_rx/provider/main_provider.dart';
import 'package:flutter_provider_rx/services/network/network_util.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'generated/l10n.dart';
import 'internal/widget/loading.dart';
import 'provider/auth_provider.dart';
import 'services/app_services/user_service.dart';
import 'views/error_screen.dart';

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
        ChangeNotifierProvider(create: (_) => HomeProvider.init()),
        ChangeNotifierProvider(create: (_) => BookProvider()),
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        Provider(create: (c) => UserService()),

      ],
      child: Builder(builder: (context) {
        base_provider.setContext(context);
        return const MyApp();
      }),
    ),
  );
  //runApp(App());
}

Future<void> _initLocaleStorage() async {
  Directory directory = await getApplicationDocumentsDirectory();
  Hive.init(directory.path);
}

class MyApp extends StatefulWidget {
  const MyApp({Key key}) : super(key: key);

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
      return MaterialApp.router(
        localizationsDelegates: const [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        locale: localeProvider.locale ?? Locale(ui.window.locale?.languageCode),
        supportedLocales: S.delegate.supportedLocales,
        debugShowCheckedModeBanner: false,
        title: 'Flutter Provider Rx',
        builder: (context, child) {
          ErrorWidget.builder = (FlutterErrorDetails errorDetails) {
            return ErrorScreen(error: errorDetails.summary.toString());
          };

          return Stack(
            children: [
              child,
              Consumer<base_provider.LoadingProvider>(
                  builder: (_, loadingProvider, __) {
                return loadingProvider.loading ? const AppLoading() : const SizedBox.shrink();
              }),
            ],
          );
        },
        routerDelegate: appController.router.goRouter.routerDelegate,
        routeInformationParser: appController.router.goRouter.routeInformationParser,
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
      if (!network) {
        appController.dialog.showNetworkDialog(
          context: context,
          title: "Internet",
          message: "No internet connection",
        );
      }
    });
  }
}
