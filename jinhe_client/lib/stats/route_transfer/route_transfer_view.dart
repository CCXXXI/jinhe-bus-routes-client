import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../home/query/query_view.dart';
import '../../utils/loading.dart';
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
      body: Center(
        child: ListView(
          children: [
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 800),
              child: Row(
                children: [
                  Expanded(
                    child: MyAutocomplete(logic.dataList, logic.updateData),
                  ),
                  const SizedBox(width: 42),
                  SizedBox(
                    width: 128,
                    height: 128,
                    child: Obx(
                      () => logic.busy.isTrue
                          ? Loading()
                          : ElevatedButton(
                              onPressed:
                                  logic.valid.isTrue ? logic.query : null,
                              child: const Text('查线路换乘'),
                            ),
                    ),
                  ),
                ],
              ),
            ),
            Obx(
              () => Text(
                logic.res.value,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
