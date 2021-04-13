
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_provider_rx/generated/l10n.dart';
import 'package:flutter_provider_rx/widget/paging_text_view.dart';
import 'package:flutter_provider_rx/utils/app_assets.dart';
import 'package:flutter_provider_rx/utils/app_colors.dart';
import 'package:flutter_provider_rx/utils/styles.dart';


import 'package:rxdart/rxdart.dart';

class EmptyScreen extends StatelessWidget {
  final sampleText = '''
Flutter is an open-source UI software development kit created by Google. 
It is used to develop applications for Android, iOS, Linux, Mac, Windows, Google Fuchsia,[4] and the web from a single codebase.[5]
The first version of Flutter was known as codename "Sky" and ran on the Android operating system. 
It was unveiled at the 2015 Dart developer summit,[6] with the stated intent of being able to render consistently at 120 frames per second.[7]
During the keynote of Google Developer Days in Shanghai, Google announced Flutter Release Preview 2, which is the last big release before Flutter 1.0. 
On December 4, 2018, Flutter 1.0 was released at the Flutter Live event, denoting the first "stable" version of the Framework. 
On December 11, 2019, Flutter 1.12 was released at the Flutter Interactive event.[8]
On May 6, 2020, the Dart SDK in version 2.8 and the Flutter in version 1.17.0 were released, where support was added to the Metal API, improving performance on iOS devices (approximately 50%), new Material widgets, and new network tracking.
On March 3, 2021, Google released Flutter 2 during an online Flutter Engage event. 
This major update brought official support for web-based applications as well as early-access desktop application support for Windows, MacOS, and Linux.[9]
On March 3, 2021, Google released Flutter 2 during an online Flutter Engage event.
''';
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
      body: Center(
        child: InkWell(
          onTap: () {
            showDialog(context: context,builder: (context) => Scaffold(
              body: LayoutBuilder(
                builder: (context, size) {
                  print("layout size: $size");
                  return PagingText(
                    sampleText,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 30,
                    ),
                  );
                }
              ),
            ),
            );
          },
          child: Container(
            height: 50,
            width: 100,
            color: Colors.red,
          ),
        ),
      ),
    );
  }
}





