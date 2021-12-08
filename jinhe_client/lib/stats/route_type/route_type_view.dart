import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'route_type_logic.dart';

class RouteTypePage extends StatelessWidget {
  RouteTypePage({Key? key}) : super(key: key);

  final logic = Get.put(RouteTypeLogic());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('统计路线类型'),
      ),
      body: const Placeholder(),
    );
  }
}
