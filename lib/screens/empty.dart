import 'package:flutter/material.dart';
import 'package:flutter_provider_rx/generated/l10n.dart';
import 'package:flutter_provider_rx/utils/app_assets.dart';
import 'package:flutter_provider_rx/utils/app_colors.dart';
import 'package:flutter_provider_rx/utils/styles.dart';

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
