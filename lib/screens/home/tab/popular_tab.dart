import 'package:flutter/material.dart';
import 'package:flutter_provider_rx/models/book_model.dart';
import 'package:flutter_provider_rx/provider/book_provider.dart';
import 'package:flutter_provider_rx/screens/book_detail/book_detail_screen.dart';
import 'package:flutter_provider_rx/screens/home/widget_build/item_book_rating.dart';
import 'package:flutter_provider_rx/provider/main_provider.dart';
import 'package:flutter_provider_rx/utils/app_routes.dart';
import 'package:flutter_provider_rx/utils/app_screen_name.dart';
import 'package:provider/provider.dart';

class PopularTab extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final list = context.watch<BookProvider>().listPopular;
    return ListView.builder(
      itemCount: list.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(top: 20, right: 20),
            child: ItemBookRating(
            book: list[index],
            onItemPressed: () => AppRoutes().push(
                context,
                AppScreenName.detail,
                BookDetailScreen(
                  book: list[index],
                ),
            ),
          ),
        );
        },
    );
  }
}
