import 'package:flutter/material.dart';

import '../utils/database.dart';

ColorScheme get _colorScheme => ColorScheme.light(
      primary: theme.primary,
      onPrimary: theme.onPrimary,
      secondary: theme.secondary,
      onSecondary: theme.onSecondary,
      surface: theme.surface,
      onSurface: theme.onSurface,
      background: theme.background,
      onBackground: theme.onBackground,
    );

TextTheme get _textTheme => (_colorScheme.onBackground == Colors.white
        ? Typography().white
        : Typography().black)
    .apply(fontFamily: 'NotoSansSC');

ThemeData get appTheme => ThemeData.from(
      colorScheme: _colorScheme,
      textTheme: _textTheme,
    );
