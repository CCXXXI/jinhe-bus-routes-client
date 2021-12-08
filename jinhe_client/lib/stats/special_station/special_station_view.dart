import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/loading.dart';
import 'special_station_logic.dart';

class SpecialStationPage extends StatelessWidget {
  SpecialStationPage({Key? key}) : super(key: key);

  final logic = Get.put(SpecialStationLogic());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('统计特殊站台'),
      ),
      body: Center(
        child: Obx(
          () => logic.res.isEmpty
              ? Loading()
              : Text(
                  logic.res.value,
                  textAlign: TextAlign.center,
                ),
        ),
      ),
    );
  }
}
