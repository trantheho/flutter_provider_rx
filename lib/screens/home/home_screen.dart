import 'package:flutter/material.dart';
import 'package:flutter_provider_rx/models/book_model.dart';
import 'package:flutter_provider_rx/screens/home/tab/popular_tab.dart';
import 'package:flutter_provider_rx/screens/home/widget_build/item_book.dart';
import 'package:flutter_provider_rx/provider/main_provider.dart';
import 'package:flutter_provider_rx/utils/styles.dart';
import 'package:flutter_provider_rx/widget/button.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin{
  TabController tabController;
  PageController pageController;

  final List<Book> listBook = [
    Book(
      image: "https://lh3.googleusercontent.com/proxy/SjYAjWzYd0YK1vsvx-br1XZb5y-HMQSSkYHu6xwaimdSFRnohnc3uDJqpGWe1aN3aXRVYguwuVeVfHPo8zx5VDnONmOLPiqJx4cehfdT",
      name: "Tây Du",
      subName: "The Ton Ngo Khong",
    ),
    Book(
      image: "https://img.vncdn.xyz/storage20/hh247/images/vu-canh-ky-2-f2689.jpg",
      name: "Vũ Canh Kỷ",
      subName: "The Vu Canh",
    ),
    Book(
      image: "https://img.tvzingvn.net/uploads/2020/07/5f0a3c90acc3999-35268.jpg",
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          bottom: false,
          child: Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildUserInfo(),

                SizedBox(height: 20,),

                Text(
                  "Recomended",
                  style: AppTextStyle.bold.copyWith(fontSize: 25),
                ),

                SizedBox(height: 20,),

                _buildListBook(),

                SizedBox(height: 20,),

                _buildTapBar(),

                _buildTabBarView(),

              ],
            ),
          ),
        )
    );
  }


  Widget _buildUserInfo(){
    return Padding(
      padding: const EdgeInsets.only(right: 20, top: 20),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
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

          SizedBox(width: 10,),

          Expanded(
            child: Text(
              "Hi ${context.watch<MainProvider>().currentUser.name}!",
              style: AppTextStyle.normal,
            ),
          ),

          IconButton(
            icon: Icon(Icons.search_outlined, size: 24, color: Colors.black,),
            onPressed: null,
            padding: EdgeInsets.zero,
          ),

          IconButton(
            padding: EdgeInsets.zero,
            icon: Icon(Icons.bookmark_border_outlined, size: 24, color: Colors.black,),
            onPressed: null,
          ),
        ],
      ),
    );

  }

  Widget _buildListBook(){
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

  Widget _buildTapBar(){
    return Container(
      height: 50,
      margin: EdgeInsets.only(right: 20,),
      color: Colors.white,
      child: TabBar(
        controller: tabController,
        labelColor: Colors.blue,
        labelStyle: AppTextStyle.medium,
        unselectedLabelColor: Colors.grey,
        //indicatorColor: Colors.transparent,
        indicatorPadding: EdgeInsets.only(right: 8),
        tabs: [
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

  Widget _buildTabBarView(){
    return Expanded(
      child: TabBarView(
        controller: tabController,
          children: [
            PopularTab(),
            PopularTab(),
            PopularTab(),
          ]
      ),
    );
  }


}
