import 'package:flutter/material.dart';
import '../core/app_export.dart';

class AppDecoration {
  // Blue decorations
  static BoxDecoration get blue => BoxDecoration(
        // color: theme.colorScheme.primary,
        color: appTheme.blue800,
        boxShadow: [
          BoxShadow(
            color: appTheme.blueGray60019,
            spreadRadius: 2.h,
            blurRadius: 2.h,
            offset: Offset(
              0,
              4,
            ),
          )
        ],
      );
  // Fill decorations
  static BoxDecoration get fillBlue => BoxDecoration(
        color: appTheme.blue800,
      );
  static BoxDecoration get fillIndigoA => BoxDecoration(
        color: appTheme.indigoA400,
      );
  static BoxDecoration get fillWhiteA => BoxDecoration(
        color: appTheme.whiteA700,
      );
// Gradient decorations
  static BoxDecoration get gradientGrayToGray => BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment(0.5, 0),
          end: Alignment(0.5, 1),
          colors: [appTheme.gray5000, appTheme.gray50],
        ),
      );
  static BoxDecoration get gradientWhiteAToGray => BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment(0.61, 0.4),
          end: Alignment(0.79, 0.17),
          colors: [appTheme.whiteA700, appTheme.gray5002],
        ),
      );
  static BoxDecoration get gradientWhiteAToGray5002 => BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment(0.04, 1.03),
          end: Alignment(1.11, -0.07),
          colors: [appTheme.whiteA700, appTheme.gray5002],
        ),
      );
// Outline decorations
  static BoxDecoration get outline => BoxDecoration();
  static BoxDecoration get outlineBlueA2000f => BoxDecoration(
        color: appTheme.whiteA700,
        boxShadow: [
          BoxShadow(
            color: appTheme.blueA2000f,
            spreadRadius: 2.h,
            blurRadius: 2.h,
            offset: Offset(
              0,
              10,
            ),
          )
        ],
      );
  static BoxDecoration get outlineBlueA2000f1 => BoxDecoration(
        color: appTheme.whiteA700,
        boxShadow: [
          BoxShadow(
            color: appTheme.blueA2000f.withOpacity(0.07),
            spreadRadius: 2.h,
            blurRadius: 2.h,
            offset: Offset(
              0,
              -25,
            ),
          )
        ],
      );

  // Outline decorations
  static BoxDecoration get outlineSecondaryContainer => BoxDecoration(
        color: appTheme.whiteA700,
        // boxShadow: [
        //   BoxShadow(
        //     color: theme.colorScheme.secondaryContainer.withOpacity(0.09),
        //     spreadRadius: 2.h,
        //     blurRadius: 2.h,
        //     offset: Offset(
        //       0,
        //       -25,
        //     ),
        //   )
        // ],
      );
}

class BorderRadiusStyle {
  // Custom borders
  static BorderRadius get customBorderTL28 => BorderRadius.vertical(
        top: Radius.circular(28.h),
      );
// Rounded borders
  static BorderRadius get roundedBorder12 => BorderRadius.circular(
        12.h,
      );
  static BorderRadius get roundedBorder16 => BorderRadius.circular(
        16.h,
      );
  static BorderRadius get roundedBorder22 => BorderRadius.circular(
        22.h,
      );
  static BorderRadius get roundedBorder28 => BorderRadius.circular(
        28.h,
      );
}
