import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import 'stats_logic.dart';

class StatsPage extends StatelessWidget {
  StatsPage({Key? key}) : super(key: key);

  final logic = Get.put(StatsLogic());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('分析查询'),
      ),
      body: const Placeholder(),
    );
  }
}

class ToolCard extends StatelessWidget {
  const ToolCard(
    this.leading,
    this.title,
    this.subtitle, {
    Key? key,
    this.onTap,
    this.onLongPress,
    this.enabled = true,
  }) : super(key: key);

  final IconData leading;
  final String title;
  final Widget subtitle;
  final void Function()? onTap;
  final void Function()? onLongPress;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: enabled ? onTap : null,
      onLongPress: enabled ? onLongPress : null,
      style: ElevatedButton.styleFrom(
        primary: context.theme.colorScheme.background,
        onPrimary: context.theme.colorScheme.onBackground,
        shadowColor: context.theme.colorScheme.onBackground,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 256),
          child: ListTile(
            leading: FaIcon(leading),
            title: Text(title),
            subtitle: subtitle,
            mouseCursor: MouseCursor.uncontrolled,
          ),
        ),
      ),
    );
  }
}
