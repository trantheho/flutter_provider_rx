import 'package:flutter/material.dart';
import 'package:flutter_provider_rx/models/book_model.dart';
import 'package:flutter_provider_rx/provider/book_provider.dart';
import 'package:flutter_provider_rx/provider/main_provider.dart';
import 'package:flutter_provider_rx/utils/styles.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';

class BookDetailScreen extends StatefulWidget {
  final Book book;

  BookDetailScreen({this.book});

  @override
  _BookDetailScreenState createState() => _BookDetailScreenState();
}

class _BookDetailScreenState extends State<BookDetailScreen> {

  @override
  Widget build(BuildContext context) {
    final _bookProvider = context.read<BookProvider>();
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            onPressed: () => Navigator.pop(context)),
      ),
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Container(
              width: 250,
              height: 350,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(widget.book.image),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            _buildContent(_bookProvider),
          ],
        ),
      ),
    );
  }

  Widget _buildContent(BookProvider bookProvider) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25),
            topRight: Radius.circular(25),
          ),
          color: Colors.white,
        ),
        padding: EdgeInsets.only(left: 20, right: 20, top: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.book.name,
                        style: AppTextStyle.bold.copyWith(fontSize: 16),
                      ),
                      Text(
                        widget.book.subName,
                        style: AppTextStyle.normal
                            .copyWith(color: Colors.blueGrey),
                      ),
                    ],
                  ),
                ),
                BookMarkButton(
                  initBookMark: widget.book.bookmark,
                  onTap: (value) =>
                      bookProvider.updateFavorite(widget.book.id, value),
                ),
              ],
            ),
            Row(
              children: [
                Icon(
                  Icons.star,
                  color: Colors.yellow,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  "4.5",
                  style: AppTextStyle.normal,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class BookMarkButton extends StatefulWidget {
  final bool initBookMark;
  final Function(bool) onTap;

  BookMarkButton({Key key, this.onTap, this.initBookMark}) : super(key: key);

  @override
  _BookMarkButtonState createState() => _BookMarkButtonState();
}

class _BookMarkButtonState extends State<BookMarkButton> {
  bool bookmark = false;

  @override
  void initState() {
    super.initState();
    bookmark = widget.initBookMark;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          bookmark = !bookmark;
          widget.onTap(bookmark);
        });
      },
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.blue,
        ),
        child: Center(
          child: Icon(
            Icons.bookmark,
            color: bookmark ? Colors.deepOrange : Colors.white,
          ),
        ),
      ),
    );
  }
}
