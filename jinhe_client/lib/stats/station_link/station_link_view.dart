import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'station_link_logic.dart';

class StationLinkPage extends StatelessWidget {
  StationLinkPage({Key? key}) : super(key: key);

  final logic = Get.put(StationLinkLogic());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('统计站台连接'),
      ),
      body: const Placeholder(),
    );
  }
}
