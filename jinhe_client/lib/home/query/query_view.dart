import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'query_logic.dart';

class QueryWidget extends StatelessWidget {
  QueryWidget({Key? key}) : super(key: key);

  final logic = Get.put(QueryLogic());

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 800),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    MyAutocomplete(logic, logic.updateData0),
                    MyAutocomplete(logic, logic.updateData1),
                  ],
                ),
              ),
              const SizedBox(width: 42),
              SizedBox(
                width: 128,
                height: 128,
                child: ElevatedButton(
                  onPressed: logic.search,
                  child: Obx(
                    () => Text(logic.searchText.value),
                  ),
                ),
              ),
            ],
          ),
        ),
        const Expanded(
          child: Placeholder(),
        ),
      ],
    );
  }
}

class MyAutocomplete extends StatelessWidget {
  final QueryLogic logic;
  final void Function(Data) onSelected;

  const MyAutocomplete(this.logic, this.onSelected, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Autocomplete<Data>(
      displayStringForOption: (e) => e.str,
      optionsBuilder: (t) => logic.dataList.where(
        (e) => e.str.toLowerCase().contains(t.text.toLowerCase()),
      ),
      onSelected: onSelected,
    );
  }
}
