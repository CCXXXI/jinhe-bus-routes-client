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
    var c0 = 0, c1 = 0, c2 = 0;
    for (final s in logic.stationMap.values.map((e) => e.zh).toSet()) {
      if (s.startsWith('地铁')) c0++;
      if (s.endsWith('(始发站)')) c1++;
      if (s.endsWith('(终点站)')) c2++;
    }
    res.value = '地铁站：$c0\n始发站：$c1\n终点站：$c2';
  }
}
