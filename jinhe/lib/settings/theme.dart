import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/database.dart';

ColorScheme get _colorScheme => ColorScheme.dark(
      primary: theme.primary,
      onPrimary: theme.onPrimary,
      secondary: theme.secondary,
      onSecondary: theme.onSecondary,
      surface: theme.surface,
      onSurface: theme.onSurface,
      background: theme.background,
      onBackground: theme.onBackground,
    );

ThemeData get appTheme => ThemeData.from(colorScheme: _colorScheme);

void updateTheme() => Get.snackbar(
      '主题设置已更新',
      '重启后生效',
    );
