import 'package:flutter/material.dart';
import '../core/app_export.dart';

extension on TextStyle {
  TextStyle get abel {
    return copyWith(
      fontFamily: 'Abel',
    );
  }

  TextStyle get mulish {
    return copyWith(
      fontFamily: 'Mulish',
    );
  }
}

/// A collection of pre-defined text styles for customizing text appearance,
/// categorized by different font families and weights.
/// Additionally, this class includes extensions on [TextStyle] to easily apply specific font families to text.
class CustomTextStyles {
  // Body text style
  static get bodyLarge16 => theme.textTheme.bodyLarge!.copyWith(
        fontSize: 16.fSize,
      );
  static get bodyLargeIndigoA40001 => theme.textTheme.bodyLarge!.copyWith(
        color: appTheme.indigoA40001,
        fontSize: 16.fSize,
      );
  static get bodyLargeWhiteA700 => theme.textTheme.bodyLarge!.copyWith(
        color: appTheme.whiteA700,
        fontSize: 16.fSize,
      );
  static get bodyMediumIndigo800 => theme.textTheme.bodyMedium!.copyWith(
        color: appTheme.indigo800,
      );
  static get bodyMediumIndigo800_1 => theme.textTheme.bodyMedium!.copyWith(
        color: appTheme.indigo800,
      );
  static get bodyMediumIndigoA40001 => theme.textTheme.bodyMedium!.copyWith(
        color: appTheme.indigoA40001,
      );
  static get bodyMediumIndigoA40001_1 => theme.textTheme.bodyMedium!.copyWith(
        color: appTheme.indigoA40001,
      );
  static get bodyMediumPrimary => theme.textTheme.bodyMedium!.copyWith(
        color: appTheme.blue800,
      );
  static get bodySmallBluegray400 => theme.textTheme.bodySmall!.copyWith(
        color: appTheme.blueGray400,
        fontSize: 10.fSize,
      );
  static get bodySmallBluegray400_1 => theme.textTheme.bodySmall!.copyWith(
        color: appTheme.blueGray400,
      );
  static get bodySmallIndigo800 => theme.textTheme.bodySmall!.copyWith(
        color: appTheme.indigo800,
      );
  static get bodySmallMulishWhiteA700 =>
      theme.textTheme.bodySmall!.mulish.copyWith(
        color: appTheme.whiteA700.withOpacity(0.87),
      );
  static get bodySmall_1 => theme.textTheme.bodySmall!;
  static get bodyLargeBluegray900 => theme.textTheme.bodyLarge!.copyWith(
        color: appTheme.blueGray900,
        fontSize: 16.fSize,
      );
// Title text style
  static get titleLargeBluegray900 => theme.textTheme.titleLarge!.copyWith(
        color: appTheme.blueGray900,
      );
  static get titleLargeBluegray90022 => theme.textTheme.titleLarge!.copyWith(
        color: appTheme.blueGray900,
        fontSize: 22.fSize,
      );
  static get titleMediumBluegray90022 => theme.textTheme.titleLarge!.copyWith(
        color: appTheme.blueGray900,
        fontSize: 18.fSize,
      );
}
