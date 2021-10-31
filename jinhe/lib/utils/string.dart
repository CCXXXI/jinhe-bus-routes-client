import 'package:flutter/services.dart';
import 'package:loggy/loggy.dart';

import 'pangu.dart';

// package_info_plus cannot get real info on windows
// record them manually
const appName = '金河市公交线路系统';
const packageName = 'io.github.ccxxxi.jinhe';
const version = '0.2.0';
const buildNumber = '2';

const release = '$packageName@$version+$buildNumber';

extension PanGu on String {
  String get s {
    final res = spacingText(this);

    if (res != this) {
      logDebug('"$this" -> "$res"');
    } else {
      logDebug('Unnecessary spacingText: "$this"');
    }

    return res;
  }
}

late String license;

Future<void> initMessages() async =>
    license = await rootBundle.loadString('assets/LICENSE');
