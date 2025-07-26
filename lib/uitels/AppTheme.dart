import 'package:flutter/material.dart';
import 'package:untitled/uitels/AppColors.dart';
import 'package:untitled/uitels/AppTextStyle.dart';

class AppTheme{
  static final ThemeData lightTheme=ThemeData(
   focusColor: AppColors.whiteBgColor,

    appBarTheme: AppBarTheme(
      color: AppColors.primaryColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusGeometry.only(
          bottomLeft: Radius.circular(50),
          bottomRight: Radius.circular(50)
        )
      )
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: AppColors.primaryColor,

    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: AppColors.primaryColor,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: AppColors.whiteBgColor,
      unselectedItemColor: AppColors.whiteBgColor,
      showUnselectedLabels: false,
      selectedLabelStyle: AppTextStyle.bold16White,
      unselectedLabelStyle: AppTextStyle.bold16White
    ),
   iconTheme: IconThemeData(
     color: Colors.black
   ),
    textTheme: TextTheme(
      headlineLarge: AppTextStyle.bold16Black,
      headlineMedium: AppTextStyle.bold16Primary,
      headlineSmall: AppTextStyle.bold16White,
      titleMedium: TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.bold,
        fontSize: 24
      )
    ),
    scaffoldBackgroundColor:AppColors.whiteBgColor,
    inputDecorationTheme: InputDecorationTheme(
      outlineBorder: BorderSide(
       color: AppColors.greyColor
      )
    )

  );

  //////////////////////////////////
  static final ThemeData darkTheme=ThemeData(
      focusColor: AppColors.primaryColor,
      appBarTheme: AppBarTheme(
          color: AppColors.wiehgtBlackBgColor,

      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: AppColors.wiehgtBlackBgColor,
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: AppColors.wiehgtBlackBgColor,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: AppColors.whiteBgColor,
          unselectedItemColor: AppColors.whiteBgColor,
          showUnselectedLabels: false,
          selectedLabelStyle: AppTextStyle.bold16White,
          unselectedLabelStyle: AppTextStyle.bold16White
      ),
      iconTheme: IconThemeData(
          color: AppColors.primaryColor
      ),
      textTheme: TextTheme(
          headlineMedium: AppTextStyle.bold16White,
          headlineLarge: AppTextStyle.bold16White,
          headlineSmall: AppTextStyle.bold16White,
          titleMedium: TextStyle(
              color: AppColors.primaryColor,
              fontWeight: FontWeight.bold,
              fontSize: 24
          )
      ),
      scaffoldBackgroundColor:AppColors.wiehgtBlackBgColor,
      inputDecorationTheme: InputDecorationTheme(
          outlineBorder: BorderSide(
              color: AppColors.primaryColor
          )
      )
  );
}