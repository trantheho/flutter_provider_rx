import 'package:flutter/material.dart';
import 'package:flutter_provider_rx/generated/l10n.dart';
import 'package:flutter_provider_rx/screens/home/home_screen.dart';
import 'package:flutter_provider_rx/screens/main_screen/main_controller.dart';
import 'package:flutter_provider_rx/utils/app_helper.dart';
import 'package:flutter_provider_rx/utils/styles.dart';

import '../empty.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with TickerProviderStateMixin {
  final mainController = MainController.instance;
  AnimationController bottomAppBarController;
  Animation<double> bottomAppBarCurve;
  PageController controller;
  List<Widget> _pages;
  int indexTab = 0;

  @override
  void initState() {
    _pages = [HomeScreen(), EmptyScreen(), EmptyScreen(), EmptyScreen()];
    controller = PageController(initialPage: 0, keepPage: true, viewportFraction: 1);
    indexTab = 0;
    bottomAppBarController = AnimationController(
      vsync: this,
      value: 1,
      duration: const Duration(milliseconds: 250),
    )..forward();
    bottomAppBarCurve = CurvedAnimation(
      parent: bottomAppBarController,
      curve: standardEasing,
      reverseCurve: standardEasing.flipped,
    );
    mainController.initPageController(controller, bottomAppBarController);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      // call api
    });
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    mainController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => null,
      child: Scaffold(
        backgroundColor: AppColors.terraCotta,
        body: Container(
          height: AppHelper.screenHeight(context),
          width: AppHelper.screenWidth(context),
          child: Column(
            children: [
              /*Expanded(
                child: LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints constraints) {
                    return ConstrainedBox(
                      constraints: BoxConstraints(
                          maxHeight: constraints.maxHeight
                      ),
                      child: IntrinsicHeight(
                        child: PageView(
                          controller: controller,
                          physics: NeverScrollableScrollPhysics(),
                          children: _pages,
                        ),
                      ),
                    );
                  },
                ),
              ),*/

              Expanded(child: PageView(
                controller: controller,
                physics: NeverScrollableScrollPhysics(),
                children: _pages,
              ),),
              _buildBottomNavigationBar(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBottomNavigationBar(){
    return SizeTransition(
      sizeFactor: bottomAppBarCurve,
      axisAlignment: -1,
      child: Container(
        height: kBottomNavigationBarHeight + MediaQuery.of(context).padding.bottom,
        child: StreamBuilder(
            stream: mainController.pageIndex.stream,
            initialData: 0,
            builder: (context,AsyncSnapshot<int> pageIndex) {
              indexTab = pageIndex.data;
              return Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildBottomNavigationBarItem(
                      AppColors.darkTerraCotta,
                      Icons.home,
                      S.of(context).home.toUpperCase(),
                      0,
                    ),

                    _buildBottomNavigationBarItem(
                      AppColors.terraCotta,
                      Icons.store,
                      S.of(context).store.toUpperCase(),
                      1,
                    ),

                    _buildBottomNavigationBarItem(
                      AppColors.terraCotta,
                      Icons.shopping_bag,
                      S.of(context).myBag.toUpperCase(),
                      2,
                    ),

                    _buildBottomNavigationBarItem(
                      AppColors.terraCotta,
                      Icons.person,
                      S.of(context).profile.toUpperCase(),
                      3,
                    ),
                  ],
                ),
              );
            }
        ),
      ),
    );
  }

  Widget _buildBottomNavigationBarItem(Color color, IconData icon, String title, int index) {
    return RawMaterialButton(
      onPressed: () => tapBottomBar(index),
      child: Container(
        width: AppHelper.screenWidth(context)/4,
        height: kBottomNavigationBarHeight + MediaQuery.of(context).padding.bottom,
        color: indexTab == index ? AppColors.darkTerraCotta : AppColors.terraCotta,
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom,),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(7.0),
              child: Icon(
                icon,
                size: 24,
              ),
            ),
            Text(
              title,
              style: AppTextStyle.normal,
            ),
          ],
        ),
      ),
    );
  }


  void tapBottomBar(int index) {
    AppHelper.distinctClick(action: () => mainController.pageIndex.add(index));
  }
}
