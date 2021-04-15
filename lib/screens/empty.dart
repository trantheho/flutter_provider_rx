import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_provider_rx/generated/l10n.dart';
import 'package:flutter_provider_rx/widget/divider_dotted_line.dart';
import 'package:flutter_provider_rx/widget/paging_text_view.dart';
import 'package:flutter_provider_rx/utils/app_assets.dart';
import 'package:flutter_provider_rx/utils/app_colors.dart';
import 'package:flutter_provider_rx/utils/styles.dart';
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
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            DividerDottedLine(
              color: Colors.white,
              height: 100.0,
              width: 50,
              strokeWidth: 1.0,
              dottedLength: 10.0,
              space: 2.0,
            ),
            SizedBox(
              height: 20,
            ),
            DividerDottedLine(
              color: Colors.white,
              height: 70.0,
              width: 70.0,
              strokeWidth: 1.0,
              //dottedLength: 10.0,
              space: 5.0,
              border: DividerDottedLineBorder.all(50),
            ),
            SizedBox(
              height: 20,
            ),
            DividerDottedLine(
              color: Colors.white,
              strokeWidth: 1.0,
              dottedLength: 10.0,
              space: 2.0,
              border: DividerDottedLineBorder.all(5),
              child: Center(
                child: Container(
                  height: 70,
                  width: 200,
                  child: Icon(
                    Icons.add_circle_outline,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
