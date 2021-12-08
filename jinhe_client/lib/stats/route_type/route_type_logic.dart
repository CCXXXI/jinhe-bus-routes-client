import 'package:get/get.dart';

import '../../utils/web.dart';

class RouteTypeLogic extends GetxController {
  final res = ''.obs;

  @override
  void onInit() {
    super.onInit();
    getRes();
  }

  void getRes() async {
    final Map<String, dynamic> r = (await dio.get(Api.routesTypes)).data;
    var buffer = '';
    r.forEach((key, value) => buffer += '$key: $value\n');
    res.value = buffer;
  }
}
