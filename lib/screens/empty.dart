
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_provider_rx/generated/l10n.dart';
import 'package:flutter_provider_rx/utils/app_assets.dart';
import 'package:flutter_provider_rx/utils/app_colors.dart';
import 'package:flutter_provider_rx/utils/styles.dart';
import 'dart:math' as math;

import 'package:rxdart/rxdart.dart';

class EmptyScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.verdigris,
      appBar: AppBar(
        backgroundColor: AppColors.verdigris,
        title: Text(
          S.of(context).emptyScreen.toUpperCase(),
          style: AppTextStyle.normal.copyWith(
            fontSize: 25,
          ),
        ),
      ),
      body: Container(

      ),
    );
  }
}

class PagingTextField extends StatefulWidget {
  @override
  _PagingTextFieldState createState() => _PagingTextFieldState();
}

class _PagingTextFieldState extends State<PagingTextField> {
  final pageView = BehaviorSubject<int>();
  List<TextEditingController> listController = [];
  List<FocusNode> listFocus = [];
  List<Widget> listWidget = [];
  TextEditingController textController =  TextEditingController();

  final double fontSize = 14;
  int listPage = 1;
  PageController controller = PageController();
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    listController.add(TextEditingController());
    listFocus.add(FocusNode());
  }

  @override
  void dispose() {
    pageView.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: 100,
          width: MediaQuery.of(context).size.width,
          child: LayoutBuilder(
            builder: (context, size) {
              var layout = TextPainter(
                text: TextSpan(
                  style: AppTextStyle.normal,
                ),
                textDirection: TextDirection.ltr,
              );

              layout.layout(maxWidth: size.maxWidth);

              final height = layout.height;
              final maxLine = (size.maxHeight - 20) ~/ height;
              print("max line: $maxLine");

              return StreamBuilder<int>(
                stream: pageView.stream,
                initialData: 0,
                builder: (context, snapshot) {
                  return SizedBox(
                    child: PageView.builder(
                      controller: controller,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return TextFieldPage(
                          index: index,
                          focusNode: listFocus[index],
                          textController: listController[index],
                          maxLine: maxLine,
                          size: size,
                          onOverLap: (value){
                            if(!value){
                              addPage();
                            }
                          },
                        );
                      },
                      itemCount: listPage, // Can be null
                    ),
                  );
                }
              );
            }
          ),
        ),
      ),
    );
  }
  void addPage(){
    listPage++;
    currentIndex++;
    TextEditingController textEditingController = TextEditingController();
    listController.add(textEditingController);
    FocusNode focusNode = FocusNode();
    listFocus.add(focusNode);
    pageView.add(listPage);
    listFocus[currentIndex].requestFocus();
    controller.jumpToPage(currentIndex);
    print("add page");
  }
}

class TextFieldPage extends StatefulWidget {
  final int index;
  final int maxLine;
  final BoxConstraints size;
  final FocusNode focusNode;
  final TextEditingController textController;
  final Function(bool) onOverLap;

  TextFieldPage({
    this.index,
    this.maxLine,
    this.size,
    this.onOverLap,
    this.focusNode,
    this.textController,
  });

  @override
  _TextFieldPageState createState() => _TextFieldPageState();
}

class _TextFieldPageState extends State<TextFieldPage> with AutomaticKeepAliveClientMixin {
  double textSpanWidth = 0;

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      color: Colors.blue,
      child: TextField(
        maxLines: widget.maxLine,
        focusNode: widget.focusNode,
        controller: widget.textController,
        style: TextStyle(fontSize: 14, color: Colors.black),
        decoration: InputDecoration(
          border: InputBorder.none,
          contentPadding: EdgeInsets.zero,
          hintText: "input ${widget.index}",
        ),
        onChanged: (value){
          bool isFit = _checkTextFits(value, widget.maxLine, widget.size);
          widget.onOverLap(isFit);
          print("current fit: $isFit");
        },
      ),
    );
  }

  bool _checkTextFits(String text, int maxLines, BoxConstraints constraints) {
    var span = TextSpan(
      style: AppTextStyle.normal,
      text: text,
    );

    var word = span.toPlainText();

    var tp = TextPainter(
      text: TextSpan(style: span.style, text: word),
      textDirection: TextDirection.ltr,
      textScaleFactor: 1.0,
      maxLines: maxLines,
    );

    tp.layout(maxWidth: constraints.maxWidth);

    if (span.text.length > 0) {
      // replace all \n with 'space with \n' to prevent dropping last character to new line
      String textWithSpaces = span.text.replaceAll('\n', ' \n');
      // \n is 10, <space> is 32
      if (span.text.codeUnitAt(span.text.length - 1) != 10 &&
          span.text.codeUnitAt(span.text.length - 1) != 32) {
        textWithSpaces += ' ';
      }
      var secondPainter = TextPainter(
        text: TextSpan(
          text: textWithSpaces,
          style: span.style,
        ),
        textDirection: TextDirection.ltr,
        textScaleFactor: 1.0,
        maxLines: maxLines,
      );
      secondPainter.layout(maxWidth: constraints.maxWidth);
    }

    return !(tp.didExceedMaxLines ||
        tp.height > constraints.maxHeight ||
        tp.width > constraints.maxWidth);
  }
}



