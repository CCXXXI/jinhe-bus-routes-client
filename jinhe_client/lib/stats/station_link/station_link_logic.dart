import 'package:get/get.dart';

import '../../utils/web.dart';

class StationLinkLogic extends GetxController {
  final res = ''.obs;

  @override
  void onInit() {
    super.onInit();
    getRes();
  }

  void getRes() async {
    final List<dynamic> r = (await dio.get(Api.stationsLinks)).data;
    final buffer = StringBuffer();
    for (final i in r) {
      buffer.writeln('${i[0]} → ${i[1]}: ${i[2]}条');
    }
    res.value = buffer.toString();
  }
}
