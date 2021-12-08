import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/loading.dart';
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
                child: Obx(
                  () => logic.busy.isTrue
                      ? Loading()
                      : ElevatedButton(
                          onPressed: logic.searchText.value == '搜'
                              ? null
                              : logic.search,
                          child: Text(logic.searchText.value),
                        ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView(
            children: [
              Obx(
                () => Text(
                  logic.basicInfo.value,
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class MyAutocomplete extends StatelessWidget {
  final QueryLogic logic;
  final void Function(Data?) onSelected;

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
      optionsMaxHeight: Get.height,
      fieldViewBuilder: fieldViewBuilder,
    );
  }

  Widget fieldViewBuilder(
      BuildContext context,
      TextEditingController controller,
      FocusNode focusNode,
      void Function() onFieldSubmitted) {
    return TextFormField(
      controller: controller,
      focusNode: focusNode,
      onFieldSubmitted: (String value) => onFieldSubmitted(),
      decoration: InputDecoration(
        suffixIcon: IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () {
            controller.clear();
            onSelected(null);
          },
        ),
      ),
    );
  }
}
