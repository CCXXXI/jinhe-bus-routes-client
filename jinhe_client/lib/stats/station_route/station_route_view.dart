import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/loading.dart';
import 'station_route_logic.dart';

class StationRoutePage extends StatelessWidget {
  StationRoutePage({Key? key}) : super(key: key);

  final logic = Get.put(StationRouteLogic());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('统计停靠路线'),
      ),
      body: ListView(
        children: [
          Obx(
            () => logic.res.isEmpty
                ? Loading()
                : Text(
                    logic.res.value,
                    textAlign: TextAlign.center,
                  ),
          ),
        ],
      ),
    );
  }
}
