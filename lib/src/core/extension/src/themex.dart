import 'package:flutter/material.dart';

extension ThemeDataX on ThemeData {
  // Usage '''
  //  context.theme.when(dark: () => AppDarkColors.main, light: () => AppLightColors.main,)
  // ''''
  T when<T>({
    required T Function() light,
    required T Function() dark,
  }) {
    switch (brightness) {
      case Brightness.light:
        return light();
      case Brightness.dark:
        return dark();
    }
  }

  T whenByValue<T extends Object?>({
    required T light,
    required T dark,
  }) {
    switch (brightness) {
      case Brightness.light:
        return light;
      case Brightness.dark:
        return dark;

      default:
        return light;
    }
  }

  T maybeWhenByValue<T extends Object?>({
    required T orElse,
    T? light,
    T? dark,
  }) =>
      whenByValue<T>(
        light: light ?? orElse,
        dark: dark ?? orElse,
      );
}
