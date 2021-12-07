import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'query_logic.dart';

class QueryWidget extends StatelessWidget {
  QueryWidget({Key? key}) : super(key: key);

  final logic = Get.put(QueryLogic());

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
