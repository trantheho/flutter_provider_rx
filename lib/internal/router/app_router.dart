import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_provider_rx/internal/base/base_provider.dart';
import 'package:flutter_provider_rx/internal/router/route_utils.dart';
import 'package:flutter_provider_rx/internal/widget/loading.dart';
import 'package:flutter_provider_rx/models/book_model.dart';
import 'package:flutter_provider_rx/provider/auth_provider.dart';
import 'package:flutter_provider_rx/provider/main_provider.dart';
import 'package:flutter_provider_rx/views/authentication/login/login_screen.dart';
import 'package:flutter_provider_rx/views/book_detail/book_detail_screen.dart';
import 'package:flutter_provider_rx/views/empty.dart';
import 'package:flutter_provider_rx/views/error_screen.dart';
import 'package:flutter_provider_rx/views/home/home_screen.dart';
import 'package:flutter_provider_rx/views/main_screen/main_screen.dart';
import 'package:flutter_provider_rx/views/onboarding/onboarding_screen.dart';
import 'package:flutter_provider_rx/views/profile/profile_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class AppRouter{
  final AuthProvider _authProvider;
  GoRouter get goRouter => _goRouter;
  final GoRouter _goRouter;
  static const _scaffoldKey = ValueKey<String>('App scaffold');

  AppRouter(this._authProvider) : _goRouter = GoRouter(
    debugLogDiagnostics: true,
    refreshListenable: _authProvider,
    urlPathStrategy: UrlPathStrategy.path,
    initialLocation: AppPage.root.path,
    errorBuilder: (_, state) => ErrorScreen(error: state.error.toString(),),
    routes: <GoRoute>[
      GoRoute(
        path: AppPage.root.path,
        name: AppPage.root.name,
        redirect: (state) => AppPage.home.path.replaceAll(':${AppPage.home.param}', 'popular'),
      ),
      GoRoute(
        path: AppPage.login.path,
        name: AppPage.login.name,
        builder: (_, state) => const LoginScreen(),
      ),
      GoRoute(
        path: AppPage.main.path,
        name: AppPage.main.name,
        redirect: (state) => AppPage.home.path.replaceAll(':${AppPage.home.param}', mainContext
            .watch<MainProvider>()
            .homeData.currentTabName),
      ),
      GoRoute(
        path: AppPage.home.path,
        name: AppPage.home.name,
        pageBuilder: (context, state) => FadeTransitionPage(
          key: _scaffoldKey,
          child: MainScreen(
            tab: MainTab.home,
            index: 0,
            child: HomeScreen(kind: state.params[AppPage.home.param]),
          ),
        ),
        routes: [
          GoRoute(
            path: AppPage.book.path,
            name: AppPage.book.name,
            builder: (context, state) {
              final _bookId = state.params[AppPage.book.param];
              final _book = mainContext
                        .watch<MainProvider>()
                        .homeData
                        .popularList
                        .firstWhere((element) => element.id == _bookId, orElse: () => Book(
                image: "https://photos.animetvn.tv/upload/film/006T5GTEly1ggmu3oerihj30u01hc7wi.png",
                name: "Tây Du",
                subName: "The Ton Ngo Khong",
                id: '0',
              ));

              return BookDetailScreen(book: _book);
            },
          ),
        ],
      ),
      GoRoute(
        path: AppPage.store.path,
        name: AppPage.store.name,
        pageBuilder: (context, state) => FadeTransitionPage(
          key: _scaffoldKey,
          child: MainScreen(
            tab: MainTab.store,
            index: 1,
            child: const EmptyScreen(),
          ),
        ),
      ),
      GoRoute(
        path: AppPage.bag.path,
        name: AppPage.bag.name,
        pageBuilder: (context, state) => FadeTransitionPage(
          key: _scaffoldKey,
          child: MainScreen(
            tab: MainTab.bag,
            index: 2,
            child: const EmptyScreen(),
          ),
        ),
      ),
      GoRoute(
        path: AppPage.profile.path,
        name: AppPage.profile.name,
        pageBuilder: (context, state) => FadeTransitionPage(
          key: _scaffoldKey,
          child: MainScreen(
            tab: MainTab.profile,
            index: 3,
            child: const ProfileScreen(),
          ),
        ),
      ),
    ],
    redirect: (state) => _guard(_authProvider, state),
    navigatorBuilder: (_, state, child) => _authProvider.loading
        ? const OnBoardingScreen() : child,
  );

  static String _guard(AuthProvider _authProvider, GoRouterState state) {
    final _isLogin = _authProvider.isLoggedIn;
    final _loginLocation = state.subloc == state.namedLocation(AppPage.login.name);
    if(!_isLogin) return _loginLocation ? null : AppPage.login.path;
    if(_isLogin && _loginLocation) return AppPage.root.path;
    return null;
  }

  GoRouter of(BuildContext context) => GoRouter.of(context);

  void pop() => _goRouter.location != AppPage.root.path ? _goRouter.pop() : null;
}


/// TransitionPage
class FadeTransitionPage extends CustomTransitionPage<void> {
  FadeTransitionPage({
    @required LocalKey key,
    @required Widget child,
  }) : super(
      key: key,
      transitionsBuilder: (c, animation, a2, child) => FadeTransition(
        opacity: animation.drive(CurveTween(curve: Curves.easeIn)),
        child: child,
      ),
      child: child);
}