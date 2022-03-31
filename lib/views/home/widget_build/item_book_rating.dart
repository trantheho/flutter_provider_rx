import 'package:flutter/material.dart';
import 'package:flutter_provider_rx/internal/utils/styles.dart';
import 'package:flutter_provider_rx/models/book_model.dart';

class ItemBookRating extends StatelessWidget {
  final Book book;
  final Function onItemPressed;

  ItemBookRating({this.book, this.onItemPressed,});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onItemPressed(),
      child: Container(
        height: 120,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 70,
              height: 120,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(book.image),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            SizedBox(width: 10,),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 15,),
                  Text(
                    book.name,
                    style: AppTextStyle.medium,
                  ),
                  SizedBox(height: 4,),
                  Text(
                    book.subName,
                    style: AppTextStyle.normal.copyWith(color: Colors.blueGrey),
                  ),
                  Spacer(),
                  Row(
                    children: [
                      Icon(
                        Icons.star,
                        color: Colors.yellow,
                      ),
                      Text('5.0', style: AppTextStyle.normal,),
                    ],
                  ),
                  SizedBox(height: 15,)
                ],
              ),
            ),
            Icon(
              book.bookmark ? Icons.bookmark : Icons.bookmark_border_rounded,
              color: book.bookmark ?  Colors.blue : Colors.black,
            )
          ],
        ),
      ),
    );
  }
}
