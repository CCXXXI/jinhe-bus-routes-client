import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'route_station_logic.dart';

class RouteStationPage extends StatelessWidget {
  RouteStationPage({Key? key}) : super(key: key);

  final logic = Get.put(RouteStationLogic());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('统计路线站点'),
      ),
      body: const Placeholder(),
    );
  }
}
