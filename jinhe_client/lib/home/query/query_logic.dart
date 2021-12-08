import 'dart:collection';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:get/get.dart';

import '../../utils/log.dart';
import '../../utils/web.dart';

part 'query_logic.freezed.dart';

class QueryLogic extends GetxController with L {
  final dataList = <Data>[];
  final busy = true.obs;
  final stationMap = <String, Station>{};

  @override
  void onInit() {
    super.onInit();
    initData();
  }

  void initData() async {
    final stations = (await dio.get(Api.stations)).data;
    final sgMap = <String, StationGroup>{};
    for (final s in stations) {
      final station = Station(s['zh'], s['en'], s['id']);
      stationMap[station.id] = station;
      dataList.add(station);
      if (sgMap.containsKey(s['zh'])) {
        sgMap[s['zh']]!.ids.add(s['id']);
      } else {
        sgMap[s['zh']] =
            StationGroup(s['zh'], s['en'], SplayTreeSet.of([s['id']]));
      }
    }
    for (final sg in sgMap.values) {
      if (sg.ids.length > 1) dataList.add(sg);
    }

    final routes = (await dio.get(Api.routes)).data;
    routes.forEach((k, v) {
      if (v == '0') {
        dataList.add(Route(k, null));
      } else {
        dataList.add(Route(k, true));
        dataList.add(Route(k, false));
      }
    });

    busy.value = false;
  }

  Data? data0, data1;

  void updateData0(Data? data) {
    data0 = data;
    check();
  }

  void updateData1(Data? data) {
    data1 = data;
    check();
  }

  final buttonText = '查'.obs;

  void check() {
    l.debug(data0);
    l.debug(data1);

    if (data0 is Route && data1 == null || data1 is Route && data0 == null) {
      buttonText.value = '查线路';
    } else if (data0 is StationGroup && data1 == null ||
        data1 is StationGroup && data0 == null) {
      buttonText.value = '查同名站点';
    } else {
      buttonText.value = '查';
    }
  }

  final basicInfo = ''.obs;
  final th = <Data>[].obs;
  final table = <List<String>>[].obs;

  void query() async {
    busy.value = true;
    basicInfo.value = '';
    th.clear();
    table.clear();

    if (buttonText.value == '查线路') {
      await queryRoute((data0 ?? data1) as Route);
    } else if (buttonText.value == '查同名站点') {
      await queryStationGroup((data0 ?? data1) as StationGroup);
    }

    busy.value = false;
  }

  Future<void> queryRoute(Route route) async {
    final Map<String, dynamic> infoR =
        (await dio.get(Api.route(route.name))).data;

    if (infoR.isEmpty) {
      basicInfo.value = '无查询结果';
      return;
    }

    basicInfo.value = '''
${infoR['direction']}    ${infoR['type']}
${infoR['runtime']}    间隔${infoR['interval']}分钟
全程${infoR['kilometer']}公里    ${infoR['oneway']}
''';

    final List<dynamic> firstR =
        (await dio.get(Api.routeFirst(route.fullName))).data;
    th.value = firstR.map((f) => stationMap[f[0] as String]!).toList();
    final List<dynamic> stepsR =
        (await dio.get(Api.routeSteps(route.fullName))).data;
    table.value = stepsR
        .map((s) => firstR.map((f) {
              int t = f[1].toInt() + s;
              t %= 60 * 24;
              final h = (t ~/ 60).toString().padLeft(2, '0');
              final m = (t % 60).toString().padLeft(2, '0');
              return '$h:$m';
            }).toList())
        .toList();
  }

  Future<void> queryStationGroup(StationGroup sg) async {
    for (final id in sg.ids) {
      final List<dynamic> r = (await dio.get(Api.stationFirst(id))).data;
      basicInfo.value += '站点 $id 停靠线路：\n'
          '${r.map((e) => Route.fromFullName(e[0]).str).join('\n')}\n\n';
    }
  }
}

abstract class Data {
  String get str;
}

@freezed
class Station with _$Station implements Data {
  Station._();

  factory Station(String zh, String en, String id) = _Station;

  @override
  String get str => '$zh $en $id';
}

@freezed
class StationGroup with _$StationGroup implements Data {
  StationGroup._();

  factory StationGroup(String zh, String en, SplayTreeSet<String> ids) =
      _StationGroup;

  @override
  String get str => '$zh $en ${ids.length}个站点';
}

@freezed
class Route with _$Route implements Data {
  Route._();

  factory Route(String name, bool? up) = _Route;

  @override
  String get str {
    var r = '$name路';
    if (up != null) {
      r += ' ${up! ? '上' : '下'}行';
    }
    return r;
  }

  String get fullName {
    var r = name;
    if (up != null) {
      r += up! ? 'u' : 'd';
    }
    return r;
  }

  factory Route.fromFullName(String n) {
    if (n.endsWith('u')) {
      return Route(n.substring(0, n.length - 1), true);
    } else if (n.endsWith('d')) {
      return Route(n.substring(0, n.length - 1), false);
    } else {
      return Route(n, null);
    }
  }
}
