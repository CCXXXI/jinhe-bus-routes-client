import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiver/iterables.dart';

import '../utils/database.dart';
import '../utils/log.dart';
import '../utils/string.dart';
import '../utils/web.dart';

class SettingsLogic extends GetxController with L {
  void primaryOnChanged(Color v) {
    theme
      ..primary = v
      ..save();
    Get.snackbar('主题设置已更新', '重启后生效');
  }

  void secondaryOnChanged(Color v) {
    theme
      ..secondary = v
      ..save();
    Get.snackbar('主题设置已更新', '重启后生效');
  }

  void surfaceOnChanged(Color v) {
    theme
      ..surface = v
      ..save();
    Get.snackbar('主题设置已更新', '重启后生效');
  }

  void backgroundOnChanged(Color v) {
    theme
      ..background = v
      ..save();
    Get.snackbar('主题设置已更新', '重启后生效');
  }

  /// - null: loading
  /// - empty: failed
  final latestVer = Rx<String?>(null);

  @override
  void onInit() {
    super.onInit();
    updateVerInfo();
  }

  void updateVerInfo() async {
    latestVer.value = null;
    latestVer.value = await _getLatestVer() ?? '';
    if (updateAvailable) {
      Get.snackbar('发现新版本', '$version → ${latestVer.value}');
    }
  }

  bool get updateAvailable {
    final latest = latestVer.value;

    if (latest == null || latest.isEmpty) return false;

    final l = latest.split('.').map(int.parse);
    final v = version.split('.').map(int.parse);
    for (final pair in zip([l, v])) {
      if (pair[0] > pair[1]) return true;
      if (pair[0] < pair[1]) return false;
    }

    return false;
  }

  /// Get latest release version from GitHub.
  Future<String?> _getLatestVer() async {
    try {
      final r = await dio.get(
        Api.releases,
        queryParameters: {'per_page': 1},
      );
      return (r.data[0]['name'] as String).substring(1);
    } catch (e) {
      l.error(e);
      Get.snackbar('获取最新版本失败', e.toString());
    }
  }

  void levelOnChanged(String v) {
    log
      ..level = v
      ..save();
    Get.snackbar('日志设置已更新', '重启后生效');
  }

  void stackTraceLevelOnChanged(String v) {
    log
      ..stackTraceLevel = v
      ..save();
    Get.snackbar('日志设置已更新', '重启后生效');
  }

  void includeCallerInfoOnChanged(bool v) {
    log
      ..includeCallerInfo = v
      ..save();
    Get.snackbar('日志设置已更新', '重启后生效');
  }
}
