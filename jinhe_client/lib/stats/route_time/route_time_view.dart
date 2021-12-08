import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'route_time_logic.dart';

class RouteTimePage extends StatelessWidget {
  RouteTimePage({Key? key}) : super(key: key);

  final logic = Get.put(RouteTimeLogic());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('统计运行时间'),
      ),
      body: const Placeholder(),
    );
  }
}
