import 'package:flutter/material.dart';
import 'package:flutter_provider_rx/internal/utils/styles.dart';
import 'package:flutter_provider_rx/models/book_model.dart';

class ItemBook extends StatelessWidget {
  final Book book;

  const ItemBook(this.book, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 150,
            height: 200,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(book.image),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          const SizedBox(
            height: 4,
          ),
          Text(
            book.name,
            style: AppTextStyle.medium,
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            book.subName,
            overflow: TextOverflow.ellipsis,
            style: AppTextStyle.normal.copyWith(color: Colors.blueGrey),
          ),
        ],
      ),
    );
  }
}
