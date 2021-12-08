import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'route_transfer_logic.dart';

class RouteTransferPage extends StatelessWidget {
  RouteTransferPage({Key? key}) : super(key: key);

  final logic = Get.put(RouteTransferLogic());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('查询线路换乘'),
      ),
      body: const Placeholder(),
    );
  }
}
