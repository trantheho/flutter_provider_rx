import 'package:flutter/material.dart';
import 'package:flutter_provider_rx/di/app_di.dart';
import 'package:flutter_provider_rx/internal/router/route_utils.dart';
import 'package:flutter_provider_rx/models/book_model.dart';
import 'package:flutter_provider_rx/provider/home_provider.dart';
import 'package:flutter_provider_rx/provider/main_provider.dart';
import 'package:flutter_provider_rx/views/home/widget_build/item_book_rating.dart';
import 'package:provider/provider.dart';

class PopularTab extends StatefulWidget {
  final String kind;
  const PopularTab({Key key, this.kind}) : super(key: key);

  @override
  State<PopularTab> createState() => _PopularTabState();
}

class _PopularTabState extends State<PopularTab> with AutomaticKeepAliveClientMixin{

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final _data = context.watch<MainProvider>().homeData;

    return ChangeNotifierProvider.value(
      value: _data,
      child: Consumer<HomeProvider>(
        builder: (context, _homeData, __) {
          return ListView.builder(
            itemCount: _homeData.popularList.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(top: 20, right: 20),
                child: ItemBookRating(
                  book: _homeData.popularList[index],
                  onItemPressed: () => _toBookDetail(_homeData.popularList[index], context: context),
                ),
              );
            },
          );
        }
      ),
    );
  }

  void _toBookDetail(Book book, {@required BuildContext context}) {
    appController.router.of(context).pushNamed(
          AppPage.book.name,
          params: {
            AppPage.book.param: book.id,
          },
          extra: book,
        );
  }
}
