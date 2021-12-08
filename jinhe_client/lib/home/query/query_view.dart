import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
          child: Column(
            children: [
              Obx(
                () => Text(
                  logic.basicInfo.value,
                  textAlign: TextAlign.center,
                ),
              ),
              Expanded(
                child: Obx(() {
                  if (logic.th.isEmpty || logic.table.isEmpty) {
                    return const SizedBox();
                  } else {
                    return DataTable2(
                      columnSpacing: 0,
                      minWidth: logic.th.length * 64,
                      dataRowHeight: 32,
                      columns: [
                        for (final d in logic.th)
                          if (d is Station)
                            DataColumn(label: CopyButton(d.zh, d.str))
                          else
                            DataColumn(label: CopyButton(d.str, d.str)),
                      ],
                      rows: [
                        for (final row in logic.table)
                          DataRow(
                            cells: [
                              for (final cell in row)
                                DataCell(Center(child: Text(cell))),
                            ],
                          ),
                      ],
                    );
                  }
                }),
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

class CopyButton extends StatelessWidget {
  final String text, data;

  const CopyButton(this.text, this.data, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 512,
      height: 512,
      child: OutlinedButton(
        onPressed: () {
          Clipboard.setData(ClipboardData(text: data));
          Get.snackbar('已复制', data);
        },
        child: Text(text, textAlign: TextAlign.center),
        style: OutlinedButton.styleFrom(padding: const EdgeInsets.all(0)),
      ),
    );
  }
}
