import 'package:flutter/material.dart';
import 'package:flutter_provider_rx/internal/app_controller.dart';
import 'package:flutter_provider_rx/internal/router/route_utils.dart';
import 'package:flutter_provider_rx/internal/utils/app_helper.dart';
import 'package:flutter_provider_rx/internal/utils/styles.dart';
import 'package:flutter_provider_rx/models/book_model.dart';
import 'package:flutter_provider_rx/provider/main_provider.dart';
import 'package:provider/provider.dart';

import 'tab/popular_tab.dart';
import 'widget_build/item_book.dart';

class HomeScreen extends StatefulWidget {
  //final String kind;
  const HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  TabController tabController;
  PageController pageController;

  final List<Book> listBook = [
    Book(
      image: "https://photos.animetvn.tv/upload/film/006T5GTEly1ggmu3oerihj30u01hc7wi.png",
      name: "Tây Du",
      subName: "The Ton Ngo Khong",
      id: '0',
    ),
    Book(
      image: "https://photos.animetvn.tv/upload/film/006T5GTEly1ggmu3oerihj30u01hc7wi.png",
      name: "Vũ Canh Kỷ",
      subName: "The Vu Canh",
      id: '1',
    ),
    Book(
      image: "https://photos.animetvn.tv/upload/film/006T5GTEly1ggmu3oerihj30u01hc7wi.png",
      name: "Nguyên Long",
      subName: "The Thor",
    ),
    Book(
      image: "https://photos.animetvn.tv/upload/film/006T5GTEly1ggmu3oerihj30u01hc7wi.png",
      name: "Vũ Động Càn Khôn",
      subName: "The Tieu Viem",
    ),
  ];

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this);
    tabController.index = 0;
    pageController = PageController(initialPage: 0, keepPage: true, viewportFraction: 1);
  }

  /*@override
  void didChangeDependencies() {
    super.didChangeDependencies();
    switch (widget.kind) {
      case 'popular':
        tabController.index = 0;
        break;

      case 'new':
        tabController.index = 1;
        break;

      case 'best':
        tabController.index = 2;
        break;
    }
  }*/

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: AppHelper.statusBarOverlayUI(Brightness.dark),
      child: Scaffold(
          body: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildUserInfo(),
              const SizedBox(
                height: 20,
              ),
              Text(
                "Recomended",
                style: AppTextStyle.bold.copyWith(fontSize: 25),
              ),
              const SizedBox(
                height: 20,
              ),
              _buildListBook(),
              const SizedBox(
                height: 20,
              ),
              _buildTapBar(),
              _buildTabBarView(),
            ],
          ),
        ),
      )),
    );
  }

  Widget _buildUserInfo() {
    return Padding(
      padding: const EdgeInsets.only(right: 20, top: 20),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: Image.network(
                "https://avatarfiles.alphacoders.com/255/thumb-1920-255228.jpg",
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: Text(
              "Hi ${context.watch<MainProvider>().currentUser?.name ?? ""}!",
              style: AppTextStyle.normal,
            ),
          ),
          const IconButton(
            icon: Icon(
              Icons.search_outlined,
              size: 24,
              color: Colors.black,
            ),
            onPressed: null,
            padding: EdgeInsets.zero,
          ),
          const IconButton(
            padding: EdgeInsets.zero,
            icon: Icon(
              Icons.bookmark_border_outlined,
              size: 24,
              color: Colors.black,
            ),
            onPressed: null,
          ),
        ],
      ),
    );
  }

  Widget _buildListBook() {
    return SizedBox(
      height: 250,
      child: ListView.builder(
        itemCount: listBook.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.only(right: 10),
            child: ItemBook(listBook[index]),
          );
        },
      ),
    );
  }

  Widget _buildTapBar() {
    return Container(
      height: 50,
      margin: const EdgeInsets.only(
        right: 20,
      ),
      color: Colors.white,
      child: TabBar(
        controller: tabController,
        labelColor: Colors.blue,
        labelStyle: AppTextStyle.medium,
        unselectedLabelColor: Colors.grey,
        indicatorPadding: const EdgeInsets.only(right: 8),
        onTap: _handleTabTapped,
        tabs: const [
          Tab(
            child: Align(
              alignment: Alignment.center,
              child: Text(
                "Popular",
              ),
            ),
          ),
          Tab(
            child: Align(
              alignment: Alignment.center,
              child: Text(
                "Newest",
              ),
            ),
          ),
          Tab(
            child: Align(
              alignment: Alignment.center,
              child: Text(
                "Best Review",
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabBarView() {
    return Expanded(
      child: TabBarView(
        controller: tabController,
        physics: const NeverScrollableScrollPhysics(),
        children: const [
          PopularTab(kind: 'popular',),
          PopularTab(kind: 'new'),
          PopularTab(kind: 'best-review',),
        ],
      ),
    );
  }

  void _handleTabTapped(int index) {
    switch (index) {
      case 1:
        tabController.animateTo(1);
        break;
      case 2:
        tabController.animateTo(2);
        break;
      case 0:
      default:
        tabController.animateTo(0);
        break;
    }
  }
}
