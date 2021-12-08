import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../settings/settings_view.dart';
import '../utils/database.dart';
import '../utils/string.dart';
import '../utils/web.dart';
import 'home_logic.dart';
import 'query/query_view.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  final logic = Get.put(HomeLogic());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(e * pi),
          child: SvgPicture.asset(
            'assets/images/icon.svg',
            color: theme.onPrimary,
          ),
        ),
        title: const Text(appName),
        actions: [
          if (GetPlatform.isWeb)
            Padding(
              padding: const EdgeInsets.all(pi * e),
              child: ElevatedButton(
                onPressed: Url.latest.launch,
                child: Text('下载App'.s),
              ),
            ),
          IconButton(
            onPressed: () => Get.to(() => SettingsPage()),
            icon: const FaIcon(FontAwesomeIcons.cog),
          ),
        ],
      ),
      body: QueryWidget(),
    );
  }
}
