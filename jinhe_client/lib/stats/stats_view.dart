import 'dart:math';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../utils/database.dart';
import 'duplicate_station/duplicate_station_view.dart';
import 'route_station/route_station_view.dart';
import 'route_time/route_time_view.dart';
import 'route_transfer/route_transfer_view.dart';
import 'route_type/route_type_view.dart';
import 'special_station/special_station_view.dart';
import 'station_link/station_link_view.dart';
import 'station_route/station_route_view.dart';
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
      body: GridView.extent(
        maxCrossAxisExtent: 512,
        childAspectRatio: pi,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        children: [
          ToolCard(
            FontAwesomeIcons.chartBar,
            '统计停靠路线',
            onTap: () => Get.to(() => StationRoutePage()),
          ),
          ToolCard(
            FontAwesomeIcons.chartBar,
            '统计特殊站台',
            onTap: () => Get.to(() => SpecialStationPage()),
          ),
          ToolCard(
            FontAwesomeIcons.chartBar,
            '统计路线类型',
            onTap: () => Get.to(() => RouteTypePage()),
          ),
          ToolCard(
            FontAwesomeIcons.chartBar,
            '查询重复站点',
            onTap: () => Get.to(() => DuplicateStationPage()),
          ),
          ToolCard(
            FontAwesomeIcons.chartBar,
            '查询线路换乘',
            onTap: () => Get.to(() => RouteTransferPage()),
          ),
          ToolCard(
            FontAwesomeIcons.chartBar,
            '统计站台连接',
            onTap: () => Get.to(() => StationLinkPage()),
          ),
          ToolCard(
            FontAwesomeIcons.chartBar,
            '统计路线站点',
            onTap: () => Get.to(() => RouteStationPage()),
          ),
          ToolCard(
            FontAwesomeIcons.chartBar,
            '统计运行时间',
            onTap: () => Get.to(() => RouteTimePage()),
          ),
        ],
      ),
    );
  }
}

class ToolCard extends StatelessWidget {
  const ToolCard(
    this.leading,
    this.title, {
    Key? key,
    this.onTap,
    this.onLongPress,
    this.enabled = true,
  }) : super(key: key);

  final IconData leading;
  final String title;
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
            leading: FaIcon(
              leading,
              color: theme.onBackground,
            ),
            title: Text(title),
            mouseCursor: MouseCursor.uncontrolled,
          ),
        ),
      ),
    );
  }
}
