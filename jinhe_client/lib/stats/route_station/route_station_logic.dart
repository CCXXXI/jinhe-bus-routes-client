import 'package:get/get.dart';

import '../../home/query/query_logic.dart';
import '../../utils/web.dart';

class RouteStationLogic extends GetxController {
  final res = ''.obs;

  @override
  void onInit() {
    super.onInit();
    getRes();
  }

  void getRes() async {
    final List<dynamic> r = (await dio.get(Api.routesStations)).data;
    final buffer = StringBuffer();
    for (final i in r) {
      buffer.writeln(Route.fromFullName(i[0]).str + ': ${i[1]}');
    }
    res.value = buffer.toString();
  }
}
