import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class PagingText extends StatefulWidget {
  final String text;
  final TextStyle style;

  PagingText(
      this.text, {
        this.style = const TextStyle(
          color: Colors.black,
          fontSize: 30,
        ),
      });

  @override
  _PagingTextState createState() => _PagingTextState();
}

class _PagingTextState extends State<PagingText> {
  final List<String> _pageTexts = [];
  int _currentIndex = 0;
  bool _needPaging = true;
  bool _isPaging = false;
  final _pageKey = GlobalKey();

  @override
  void didUpdateWidget(PagingText oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.text != oldWidget.text) {
      setState(() {
        _pageTexts.clear();
        _currentIndex = 0;
        _needPaging = true;
        _isPaging = false;
      });
    }
  }

  void _paginate() {
    final pageSize =
        (_pageKey.currentContext.findRenderObject() as RenderBox).size;
    print("page size: $pageSize");

    _pageTexts.clear();

    final textSpan = TextSpan(
      text: widget.text,
      style: widget.style,
    );
    final textPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
    );
    textPainter.layout(
      minWidth: 0,
      maxWidth: pageSize.width,
    );

    // https://medium.com/swlh/flutter-line-metrics-fd98ab180a64
    List<LineMetrics> lines = textPainter.computeLineMetrics();
    double currentPageBottom = pageSize.height;
    int currentPageStartIndex = 0;
    int currentPageEndIndex = 0;
    bool isPrevLineOverflowPage = false;

    for (int i = 0; i < lines.length; i++) {
      final line = lines[i];

      final left = line.left;
      final top = line.baseline - line.ascent;
      final bottom = line.baseline + line.descent;

      // The result of getPositionForOffset function is shift by 1 index.
      // Ex: index = 0, pageText = ''
      // index = 1, pageText = 'The first line text'
      // So I need to use this weird logic to make it works.

      if (currentPageBottom < bottom) {
        currentPageEndIndex =
            textPainter.getPositionForOffset(Offset(left, top)).offset;
        final pageText =
        widget.text.substring(currentPageStartIndex, currentPageEndIndex);
        _pageTexts.add(pageText);
        currentPageStartIndex = currentPageEndIndex;
        currentPageBottom = top + pageSize.height;
      }
    }

    final lastPageText = widget.text.substring(currentPageStartIndex);
    _pageTexts.add(lastPageText);

    setState(() {
      _currentIndex = 0;
      _needPaging = false;
      _isPaging = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_needPaging && !_isPaging) {
      _isPaging = true;

      SchedulerBinding.instance.addPostFrameCallback((_) {
        _paginate();
      });
    }

    return Stack(
      children: [
        Column(
          children: [
            Expanded(
              child: SizedBox.expand(
                key: _pageKey,
                child: Text(
                  _isPaging ? ' ' : _pageTexts[_currentIndex],
                  style: widget.style,
                ),
              ),
            ),
            IntrinsicHeight(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: Icon(Icons.first_page),
                    onPressed: () {
                      setState(() {
                        _currentIndex = 0;
                      });
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.navigate_before),
                    onPressed: () {
                      setState(() {
                        if (_currentIndex > 0) _currentIndex--;
                      });
                    },
                  ),
                  Text(
                    _isPaging ? '' : '${_currentIndex + 1}/${_pageTexts.length}',
                  ),
                  IconButton(
                    icon: Icon(Icons.navigate_next),
                    onPressed: () {
                      setState(() {
                        if (_currentIndex < _pageTexts.length - 1)
                          _currentIndex++;
                      });
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.last_page),
                    onPressed: () {
                      setState(() {
                        _currentIndex = _pageTexts.length - 1;
                      });
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
        if (_isPaging)
          Center(
            child: CircularProgressIndicator(),
          ),
      ],
    );
  }
}