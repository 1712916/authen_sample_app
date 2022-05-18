import 'package:flutter/material.dart';

import 'app_colors.dart';

class ThemeResource {
  static ThemeData getTheme({ThemeData? theme, required ThemeMode themeMode}) {
    ThemeData themeData = theme ?? ThemeData();
    AppColors appColors = AppColors.getColor(AppColors.getColorStyle(themeMode));
    return themeData.copyWith(
      primaryColor: appColors.primaryColor,
      backgroundColor: appColors.backgroundColor,
      textTheme: themeData.textTheme.copyWith(
      ),
      canvasColor: appColors.canvasColor,
      cardColor: appColors.cardColor,
      hintColor: appColors.hintColor,
      errorColor: appColors.errorColor,
      focusColor: appColors.focusColor,
      disabledColor: appColors.disabledColor,
      dividerColor: appColors.dividerColor,
      shadowColor: appColors.shadowColor,
    );
  }
}