import 'package:flutter/material.dart';

import 'app_colors.dart';

ThemeData appLightTheme(BuildContext context) {
  final base = ThemeData.light();
  return base.copyWith(
    //textTheme: _buildAppLightTextTheme(base.textTheme),
      dividerColor: AppColors.greyish,
      buttonColor: AppColors.terraCotta,
      colorScheme: const ColorScheme.light(
        primaryVariant: AppColors.crocodile,
        primary: AppColors.verdigris,
        onPrimary: AppColors.white,
        secondary: AppColors.terraCotta,
        onSecondary: AppColors.white,
        background: AppColors.white,
        onBackground: AppColors.blackTwo,
        error: Colors.red,
        onError: AppColors.white,
      )
  );
}

ThemeData appDarkTheme(BuildContext context) {
  final base = ThemeData.dark();
  return base.copyWith(
    backgroundColor: AppColors.nightRider,
    colorScheme: const ColorScheme.dark(
      primary: AppColors.nightRider,
    ),
    scaffoldBackgroundColor: AppColors.nightRider,
  );
}