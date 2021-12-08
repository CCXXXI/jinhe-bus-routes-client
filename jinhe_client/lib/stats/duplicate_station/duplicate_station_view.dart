import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'duplicate_station_logic.dart';

class DuplicateStationPage extends StatelessWidget {
  DuplicateStationPage({Key? key}) : super(key: key);

  final logic = Get.put(DuplicateStationLogic());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('查询重复站点'),
      ),
      body: const Placeholder(),
    );
  }
}
