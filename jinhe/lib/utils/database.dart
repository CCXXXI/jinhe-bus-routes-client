import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:loggy/loggy.dart';
import 'package:path_provider/path_provider.dart';

part 'database.g.dart';

Future<void> initDatabase({bool clear = false}) async {
  if (!GetPlatform.isWeb && GetPlatform.isDesktop) {
    final dir = await getApplicationSupportDirectory();
    Hive.init(dir.path);
  } else {
    await Hive.initFlutter();
  }

  Hive.registerAdapter(LogAdapter());
  Hive.registerAdapter(ThemeAdapter());

  conf = await Hive.openBox('conf');

  if (clear) await conf.clear();

  if (!conf.containsKey('log')) await conf.put('log', _Log());
  if (!conf.containsKey('theme')) await conf.put('theme', _Theme());
}

late final Box conf;

@HiveType(typeId: 0)
class _Log extends HiveObject {
  @HiveField(0)
  String level = LogLevel.all.name;
  static final _levelMap = {for (final l in LogLevel.values) l.name: l};

  LogLevel get level_ => _levelMap[level]!;

  List<String> get levels => _levelMap.keys.toList();

  @HiveField(1)
  String stackTraceLevel = LogLevel.off.name;

  LogLevel get stackTraceLevel_ => _levelMap[stackTraceLevel]!;

  @HiveField(2)
  bool includeCallerInfo = false;
}

final _Log log = conf.get('log');

@HiveType(typeId: 2)
class _Theme extends HiveObject {
  static final _black = Colors.black.value;
  static final _white = Colors.white.value;

  Color _on(Color color) =>
      color.computeLuminance() > .5 ? Colors.black : Colors.white;

  @HiveField(0)
  int _primary = _white;

  Color get primary => Color(_primary);

  set primary(Color primary) => _primary = primary.value;

  Color get onPrimary => _on(primary);

  @HiveField(1)
  int _secondary = _white;

  Color get secondary => Color(_secondary);

  set secondary(Color secondary) => _secondary = secondary.value;

  Color get onSecondary => _on(secondary);

  @HiveField(2)
  int _surface = _white;

  Color get surface => Color(_surface);

  set surface(Color surface) => _surface = surface.value;

  Color get onSurface => _on(surface);

  @HiveField(3)
  int _background = _black;

  Color get background => Color(_background);

  set background(Color background) => _background = background.value;

  Color get onBackground => _on(background);
}

final _Theme theme = conf.get('theme');
