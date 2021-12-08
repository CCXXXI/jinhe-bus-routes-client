import 'package:get/get.dart';

import '../../home/query/query_logic.dart';

class SpecialStationLogic extends GetxController {
  final logic = Get.find<QueryLogic>();
  final res = ''.obs;

  @override
  void onInit() {
    super.onInit();
    getRes();
  }

  void getRes() async {
    var c0 = <String>[], c1 = <String>[], c2 = <String>[];
    for (final s in logic.stationMap.values.map((e) => e.zh).toSet()) {
      if (s.startsWith('地铁')) c0.add(s);
      if (s.endsWith('(始发站)')) c1.add(s);
      if (s.endsWith('(终点站)')) c2.add(s);
    }
    res.value = '地铁站：${c0.length}\n${c0.join('、')}\n\n'
        '始发站：${c1.length}\n${c1.join('、')}\n\n'
        '终点站：${c2.length}\n${c2.join('、')}';
  }
}
