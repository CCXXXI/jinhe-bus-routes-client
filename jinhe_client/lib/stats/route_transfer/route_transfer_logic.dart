import 'package:get/get.dart';

import '../../home/query/query_logic.dart';
import '../../utils/web.dart';

class RouteTransferLogic extends GetxController {
  final logic = Get.find<QueryLogic>();
  late final List<Data> dataList;
  final busy = false.obs;
  Data? data;
  final valid = false.obs;
  final res = ''.obs;

  @override
  void onInit() {
    dataList = logic.dataList.whereType<Route>().toList();
    super.onInit();
  }

  void updateData(Data? data) {
    this.data = data;
    valid.value = data is Route;
  }

  void query() async {
    busy.value = true;
    res.value = '';

    final List<dynamic> firstR =
        (await dio.get(Api.routeFirst((data as Route).fullName))).data;
    for (final f in firstR) {
      final List<dynamic> transR = (await dio.get(Api.stationFirst(f[0]))).data;
      final trans = transR.map((e) => e[0]).toSet()
        ..remove((data as Route).fullName);
      if (trans.isNotEmpty) {
        final buffer = StringBuffer();
        buffer.writeln(logic.stationMap[f[0]]!.str);
        buffer.writeln(trans.map((e) => Route.fromFullName(e).str).join('、'));
        buffer.writeln();
        res.value += buffer.toString();
      }
    }
    if (res.isEmpty) res.value = '无可换乘线路';

    busy.value = false;
  }
}
