import 'color_manager.dart';
import 'font_manager.dart';
import 'styles_manager.dart';
import 'values_manager.dart';
import 'package:flutter/material.dart';

ThemeData getApplicationTheme() {
  return ThemeData(
    //main theme
    primaryColor: ColorManager.primary,
    primaryColorDark: ColorManager.darkPrimary,
    primaryColorLight: ColorManager.primary,
    disabledColor: ColorManager.darkGrey,
    splashColor: ColorManager.grey,
    scaffoldBackgroundColor: Colors.white,
    //app bar theme
    appBarTheme: const AppBarTheme(
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black)),
    //Card theme
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Colors.white,
      elevation: 5.0,
      unselectedItemColor: ColorManager.darkGrey,
      selectedItemColor: Colors.blue,
    ),
    cardTheme: CardTheme(
        color: ColorManager.white,
        shadowColor: ColorManager.grey,
        elevation: AppSize.s4),

    //input theme
    //Input Decoration Theme
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsets.all(AppPadding.p8),
      prefixIconColor: Colors.grey,
      prefixStyle: const TextStyle(color: Colors.grey),
      hintStyle:
          getRegularStyle(color: ColorManager.grey, fontSize: FontSize.s14),
      labelStyle:
          getMediumStyle(color: ColorManager.grey, fontSize: FontSize.s14),
      errorStyle: getRegularStyle(color: ColorManager.red),
      enabledBorder: _getOutlineInputBorder(color: ColorManager.grey),
      focusedBorder: _getOutlineInputBorder(color: ColorManager.primary),
      disabledBorder: _getOutlineInputBorder(color: ColorManager.darkGrey),
      errorBorder: _getOutlineInputBorder(color: ColorManager.red),
      focusedErrorBorder: _getOutlineInputBorder(color: ColorManager.primary),
    ),
    //text theme
    textTheme: TextTheme(
      displayLarge: getSemiBoldStyle(
          color: ColorManager.darkGrey, fontSize: FontSize.s16),
      headlineLarge:
          getBoldStyle(color: ColorManager.primary, fontSize: AppSize.s18),
      headlineMedium:
          getRegularStyle(color: ColorManager.grey, fontSize: AppSize.s18),
      titleMedium:
          getMediumStyle(color: ColorManager.black, fontSize: AppSize.s18),
      titleSmall:
          getRegularStyle(color: ColorManager.white, fontSize: AppSize.s18),
      labelSmall:
          getBoldStyle(color: ColorManager.primary, fontSize: AppSize.s12),
      labelLarge:
          getRegularStyle(color: ColorManager.darkGrey, fontSize: AppSize.s12),
      bodyMedium:
          getMediumStyle(color: ColorManager.primary, fontSize: AppSize.s14),
      bodyLarge:
          getRegularStyle(color: ColorManager.black, fontSize: AppSize.s14),
      bodySmall: getBoldStyle(color: ColorManager.black, fontSize: 22),
      /*displaySmall:
          getSemiBoldStyle(color: ColorManager.primary, fontSize: AppSize.s18),
      labelMedium:
          getMeiumStyle(color: ColorManager.gray2, fontSize: AppSize.s14),
      titleLarge:
          getRegularStyle(color: ColorManager.gray, fontSize: AppSize.s14),*/
    ),
    //button theme
    buttonTheme: ButtonThemeData(
        shape: const StadiumBorder(),
        disabledColor: ColorManager.darkGrey,
        buttonColor: ColorManager.primary,
        splashColor: ColorManager.darkPrimary),
    //elevated button theme
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        textStyle:
            getSemiBoldStyle(color: ColorManager.white, fontSize: FontSize.s16),
        backgroundColor: ColorManager.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSize.s12),
        ),
      ),
    ),
  );
}

OutlineInputBorder _getOutlineInputBorder(
    {required Color color, double appSize = AppSize.s8}) {
  return OutlineInputBorder(
    borderSide: BorderSide(color: color, width: AppSize.s1_5),
    borderRadius: BorderRadius.all(
      Radius.circular(appSize),
    ),
  );
}
