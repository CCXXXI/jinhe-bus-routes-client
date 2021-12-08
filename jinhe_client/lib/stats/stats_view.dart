import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'stats_logic.dart';

class StatsPage extends StatelessWidget {
  StatsPage({Key? key}) : super(key: key);

  final logic = Get.put(StatsLogic());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('统计'),
      ),
      body: const Placeholder(),
    );
  }
}
