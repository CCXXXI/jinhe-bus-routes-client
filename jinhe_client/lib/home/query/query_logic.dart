import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:get/get.dart';
import 'package:tuple/tuple.dart';

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
  final now = Rx<TimeOfDay?>(null);

  void check() {
    l.debug(data0);
    l.debug(data1);

    now.value = null;

    if (data0 is Route && data1 == null || data1 is Route && data0 == null) {
      buttonText.value = '查线路';
    } else if (data0 is StationGroup && data1 == null ||
        data1 is StationGroup && data0 == null) {
      buttonText.value = '查同名站点';
    } else if (data0 is Station && data1 == null ||
        data1 is Station && data0 == null) {
      buttonText.value = '查最近班次';
      now.value = TimeOfDay.now();
    } else if ((data0 is StationGroup || data0 is Station) &&
        (data1 is StationGroup || data1 is Station)) {
      buttonText.value = '查推荐路线';
    } else if (data0 is Route && data1 is Route) {
      buttonText.value = '查重复站点';
    } else {
      buttonText.value = '查';
    }
  }

  final basic = ''.obs;
  final th = <Tuple2<Data, bool>>[].obs;
  final table = <List<String>>[].obs;

  void query() async {
    busy.value = true;
    basic.value = '';
    th.clear();
    table.clear();

    if (buttonText.value == '查线路') {
      await queryRoute((data0 ?? data1) as Route);
    } else if (buttonText.value == '查同名站点') {
      await queryStationGroup((data0 ?? data1) as StationGroup);
    } else if (buttonText.value == '查最近班次') {
      await queryStation((data0 ?? data1) as Station);
    } else if (buttonText.value == '查推荐路线') {
      await queryPath(data0!, data1!);
    } else if (buttonText.value == '查重复站点') {
      await queryRouteRoute(data0 as Route, data1 as Route);
    }

    busy.value = false;
  }

  Future<void> queryRoute(Route route) async {
    final Map<String, dynamic> infoR =
        (await dio.get(Api.route(route.name))).data;

    if (infoR.isEmpty) {
      basic.value = '查不到……';
      return;
    }

    basic.value = '''
${infoR['direction']}    ${infoR['type']}
${infoR['runtime']}    间隔${infoR['interval']}分钟
全程${infoR['kilometer']}公里    ${infoR['oneway']}
''';

    final List<dynamic> firstR =
        (await dio.get(Api.routeFirst(route.fullName))).data;
    th.value =
        firstR.map((f) => Tuple2(stationMap[f[0] as String]!, false)).toList();
    final List<dynamic> stepsR =
        (await dio.get(Api.routeSteps(route.fullName))).data;
    table.value = stepsR
        .map((s) => firstR.map((f) => t2s(f[1].toInt() + s)).toList())
        .toList();
  }

  static String t2s(int t) {
    t %= 60 * 24;
    final h = (t ~/ 60).toString().padLeft(2, '0');
    final m = (t % 60).toString().padLeft(2, '0');
    return '$h:$m';
  }

  Future<void> queryStationGroup(StationGroup sg) async {
    for (final id in sg.ids) {
      final List<dynamic> r = (await dio.get(Api.stationFirst(id))).data;
      basic.value += '站点 $id 停靠线路：\n'
          '${r.map((e) => Route.fromFullName(e[0]).str).join('\n')}\n\n';
    }
  }

  Future<void> queryStation(Station station) async {
    final List<dynamic> firstR =
        (await dio.get(Api.stationFirst(station.id))).data;
    th.value = firstR
        .map((f) => Tuple2(Route.fromFullName(f[0] as String), false))
        .toList();

    final tmp =
        List.generate(3, (_) => firstR.map((_) => '').toList()).toList();
    for (int i = 0; i != firstR.length; i++) {
      final List<dynamic> stepsR =
          (await dio.get(Api.routeSteps(firstR[i][0]))).data;
      final tmpList = <int>[];
      for (var days = -3; days <= 3; days++) {
        tmpList.addAll(
          stepsR.map((s) => (firstR[i][1].toInt() + s + 60 * 24 * days) as int),
        );
      }
      final nowV = now.value!.hour * 60 + now.value!.minute;
      final lb = lowerBound(tmpList, nowV);

      final v = List.generate(3, (j) => tmpList[lb + j] - nowV);
      for (var j = 0; j != 3; j++) {
        tmp[j][i] = _m2s(v[j]);
      }
      if (v[0] <= 5) th[i] = th[i].withItem2(true);
    }
    table.value = tmp;
  }

  static String _m2s(int m) {
    if (m == 0) {
      return '即将到达';
    } else if (m < 60) {
      return '${m}m';
    } else {
      return '${m ~/ 60}h${m % 60}m';
    }
  }

  Future<void> queryPath(Data fromRaw, Data toRaw) async {
    SplayTreeSet<String> from, to;
    if (fromRaw is StationGroup) {
      from = fromRaw.ids;
    } else {
      from = SplayTreeSet.of([(fromRaw as Station).id]);
    }
    if (toRaw is StationGroup) {
      to = toRaw.ids;
    } else {
      to = SplayTreeSet.of([(toRaw as Station).id]);
    }

    if (from.intersection(to).isNotEmpty) {
      basic.value = '原地传送？';
      return;
    }

    final List<dynamic> r = (await dio.get(Api.path(from, to))).data;

    if (r.length % 3 != 1) {
      l.debug('r.length=${r.length}');
      basic.value = '查不到……';
      return;
    }

    var trCnt = 0, timeCnt = 0;
    var pre = r[1];
    final buffer = StringBuffer();
    buffer.write('从 ${stationMap[r[0]]!.str} 出发，');
    buffer.writeln('乘 ${Route.fromFullName(r[1]).str}');
    for (int i = 4; i < r.length; i += 3) {
      final time = r[i - 2] as int, station = r[i - 1], route = r[i];
      timeCnt += time;
      buffer.writeln('$time 分钟后到达 ${stationMap[station]!.str}');
      if (route != pre) {
        trCnt++;
        pre = route;
        buffer.writeln('换乘 ${Route.fromFullName(route).str}');
      }
    }
    final time = r[r.length - 2] as int, station = r[r.length - 1];
    timeCnt += time;
    buffer.writeln('$time 分钟后到达 ${stationMap[station]!.str}');
    buffer.writeln();
    buffer.write(trCnt == 0 ? '直达' : '换乘 $trCnt 次');
    buffer.write('，全程共 ${r.length ~/ 3} 站，$timeCnt 分钟。');
    basic.value = buffer.toString();
  }

  Future<void> queryRouteRoute(Route r0, Route r1) async {
    final List<dynamic> u = (await dio.get(Api.routeFirst(r0.fullName))).data;
    final List<dynamic> v = (await dio.get(Api.routeFirst(r1.fullName))).data;
    basic.value = Set.of(u.map((e) => e[0]))
        .intersection(Set.of(v.map((e) => e[0])))
        .map((e) => stationMap[e]!.str)
        .join('\n');
    if (basic.isEmpty) basic.value = '无重复站点';
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
