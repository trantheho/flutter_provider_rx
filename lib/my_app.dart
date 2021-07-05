import 'dart:async';
import 'dart:io';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_provider_rx/app_config.dart';
import 'package:flutter_provider_rx/base/app_controller.dart';
import 'package:flutter_provider_rx/provider/book_provider.dart';
import 'package:flutter_provider_rx/provider/main_provider.dart';
import 'package:flutter_provider_rx/screens/authentication/login/login_screen.dart';
import 'package:flutter_provider_rx/screens/main_screen/main.dart';
import 'package:flutter_provider_rx/services/network/network_util.dart';
import 'package:flutter_provider_rx/provider/base/base_provider.dart'
    as baseProvider;
import 'package:flutter_provider_rx/utils/app_helper.dart';
import 'package:flutter_provider_rx/widget/dialog.dart';
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
  AppConfig.build(Environment.dev);
  Directory directory = await getApplicationDocumentsDirectory();
  Hive.init(directory.path);
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => baseProvider.LoadingProvider()),
        ChangeNotifierProvider(create: (_) => baseProvider.LocaleProvider()),
        ChangeNotifierProvider(create: (_) => MainProvider()),
        ChangeNotifierProvider(create: (_) => BookProvider()),
      ],
      child: Builder(builder: (context) {
        baseProvider.setContext(context);
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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) => postBuild(context));
    return Consumer<baseProvider.LocaleProvider>(
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
              Consumer<baseProvider.LoadingProvider>(
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
      Logging.log('connect network: $network');
      if (!network) {
        // show alert network
        DialogController(AppGlobals.currentState.overlay.context)
            .showNetworkDialog("Network", "Network not connected");
      }
    });
  }
}
