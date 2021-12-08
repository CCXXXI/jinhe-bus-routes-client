import 'dart:collection';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:get/get.dart';

import '../../utils/log.dart';
import '../../utils/web.dart';

part 'query_logic.freezed.dart';

class QueryLogic extends GetxController with L {
  final dataList = <Data>[];
  final busy = true.obs;

  @override
  void onInit() {
    super.onInit();
    initDataList();
  }

  void initDataList() async {
    final stations = (await dio.get(Api.stations)).data;
    final sgMap = <String, StationGroup>{};
    for (final s in stations) {
      dataList.add(Station(s['zh'], s['en'], s['id']));
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

  final searchText = '搜'.obs;

  void check() {
    l.debug(data0);
    l.debug(data1);

    if (data0 is Route && data1 == null || data1 is Route && data0 == null) {
      searchText.value = '搜线路';
    } else {
      searchText.value = '搜';
    }
  }

  void search() async {
    busy.value = true;

    if (searchText.value == '搜线路') await searchRoute((data0 ?? data1) as Route);

    busy.value = false;
  }

  final basicInfo = ''.obs;

  Future<void> searchRoute(Route route) async {
    final Map<String, dynamic> r = (await dio.get(Api.route(route.name))).data;
    if (r.isEmpty) {
      basicInfo.value = '无查询结果';
    } else {
      basicInfo.value = '''
${r['direction']}    ${r['type']}
${r['runtime']}    间隔${r['interval']}分钟
全程${r['kilometer']}公里    ${r['oneway']}
''';
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
}
