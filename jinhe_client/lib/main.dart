import 'package:flutter/material.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:get/get.dart';
import 'package:loggy/loggy.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:window_size/window_size.dart';

import 'home/home_view.dart';
import 'settings/theme.dart';
import 'utils/database.dart';
import 'utils/log.dart';
import 'utils/string.dart';
import 'utils/web.dart';

void main() async {
  await initDatabase();
  Settings.init();
  initLog();
  if (GetPlatform.isDesktop && !GetPlatform.isWeb) initDesktop();
  await initMessages();
  checkDataVer();
  await initSentry(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      navigatorObservers: [SentryNavigatorObserver()],
      title: appName,
      home: HomePage(),
      theme: appTheme,
    );
  }
}

void initDesktop() {
  logDebug('initDesktop begin.');

  logDebug('ensureInitialized');
  WidgetsFlutterBinding.ensureInitialized();

  logDebug('setWindowTitle');
  setWindowTitle(appName);

  logDebug('setWindowMinSize');
  setWindowMinSize(const Size(512, 512));

  logInfo('initDesktop end.');
}

Future<void> initSentry(Widget app) async {
  logInfo('release: $release');

  Sentry.configureScope(
    (scope) => scope.user = SentryUser(
      ipAddress: '{{auto}}',
    ),
  );

  await SentryFlutter.init(
    (options) => options
      ..dsn =
          'https://85129d39be5542c4b1a6391f906006c2@o996799.ingest.sentry.io/6042560'
      ..tracesSampleRate = 1
      ..sendDefaultPii = true
      ..release = release,
    appRunner: () => runApp(app),
  );
}
