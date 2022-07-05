import 'package:flutter/material.dart';
import 'package:flutter_provider_rx/di/app_di.dart';
import 'package:flutter_provider_rx/generated/l10n.dart';
import 'package:flutter_provider_rx/internal/router/route_utils.dart';
import 'package:flutter_provider_rx/internal/utils/styles.dart';
import 'package:flutter_provider_rx/internal/widget/lazy_indexed_stack.dart';
import 'package:flutter_provider_rx/views/empty.dart';
import 'package:flutter_provider_rx/views/home/home_screen.dart';
import 'package:flutter_provider_rx/views/profile/profile_screen.dart';

enum MainTab {
  home,
  store,
  bag,
  profile,
}

class MainScreen extends StatefulWidget {
  final MainTab tab;

  MainScreen({Key key, this.tab}) : super(key: key) {
    assert(tab.index != -1);
  }

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => null,
      child: Scaffold(
        backgroundColor: AppColors.terraCotta,
        body: Column(
          children: [
            Expanded(
              child: LazyIndexedStack(
                index: widget.tab.index,
                children: const [
                  HomeScreen(),
                  EmptyScreen(),
                  EmptyScreen(),
                  ProfileScreen(),
                ],
              ),
            ),
            NavigationBar(
              destinations: const [
                Destination(tab: MainTab.home),
                Destination(tab: MainTab.store),
                Destination(tab: MainTab.bag),
                Destination(tab: MainTab.profile),
              ],
              selectedIndex: widget.tab.index,
              onDestinationSelected: _tapBottomBar,
            )
          ],
        ),
      ),
    );
  }

  void _tapBottomBar(int index) {
    String _path = '';
    if(index == 0) _path = AppPage.home.path;
    if(index == 1) _path = AppPage.store.path;
    if(index == 2) _path = AppPage.bag.path;
    if(index == 3) _path = AppPage.profile.path;
    appController.router.of(context).go(_path);
  }
}

class Destination extends StatelessWidget {
  final MainTab tab;
  const Destination({Key key, this.tab}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String _label = '';
    IconData _icon;
    switch(tab){
      case MainTab.home:
        _icon = Icons.home;
        _label = S.of(context).home.toUpperCase();
        break;
      case MainTab.store:
        _icon = Icons.store;
        _label = S.of(context).store.toUpperCase();
        break;
      case MainTab.bag:
        _icon = Icons.shopping_bag;
        _label = S.of(context).myBag.toUpperCase();
        break;
      case MainTab.profile:
        _icon = Icons.person;
        _label = S.of(context).profile.toUpperCase();
        break;
      default:
        _icon = Icons.home;
        _label = S.of(context).home.toUpperCase();
        break;
    }

    return NavigationDestination(
      icon: Icon(
        _icon,
        size: 24,
      ),
      selectedIcon: Icon(
        _icon,
        size: 24,
        color: Colors.blue,
      ),
      label: _label,
    );
  }
}

