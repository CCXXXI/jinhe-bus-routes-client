import 'package:get/get.dart';

import '../../home/query/query_logic.dart';
import '../../utils/web.dart';

class StationRouteLogic extends GetxController {
  final logic = Get.find<QueryLogic>();
  final res = ''.obs;

  @override
  void onInit() {
    super.onInit();
    getRes();
  }

  void getRes() async {
    final List<dynamic> r = (await dio.get(Api.stationsRoutes)).data;
    res.value = r
        .map((s) =>
            '${logic.stationMap[s[0]]!.str}\n${s[1]}条\n' +
            s[2].map((route) => Route.fromFullName(route).str).join('、'))
        .join('\n\n');
  }
}
