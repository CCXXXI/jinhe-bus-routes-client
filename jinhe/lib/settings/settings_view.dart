import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../utils/database.dart';
import '../utils/loading.dart';
import '../utils/string.dart';
import '../utils/web.dart';
import 'settings_logic.dart';

class SettingsPage extends StatelessWidget {
  SettingsPage({Key? key}) : super(key: key);

  final logic = Get.put(SettingsLogic());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('设置'),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 800),
          child: ListView(
            children: [
              SettingsGroup(
                title: '主题',
                children: [
                  ColorPickerSettingsTile(
                    settingKey: 'theme.color.primary',
                    title: '主题色',
                    defaultValue: theme.primary,
                    onChange: logic.primaryOnChanged,
                  ),
                  ColorPickerSettingsTile(
                    settingKey: 'theme.color.secondary',
                    title: '辅助色A'.s,
                    defaultValue: theme.secondary,
                    onChange: logic.secondaryOnChanged,
                  ),
                  ColorPickerSettingsTile(
                    settingKey: 'theme.color.surface',
                    title: '辅助色B'.s,
                    defaultValue: theme.surface,
                    onChange: logic.surfaceOnChanged,
                  ),
                  ColorPickerSettingsTile(
                    settingKey: 'theme.color.background',
                    title: '背景色',
                    defaultValue: theme.background,
                    onChange: logic.backgroundOnChanged,
                  ),
                ],
              ),
              SettingsGroup(
                  title: '关于',
                  children: ListTile.divideTiles(
                    context: context,
                    tiles: [
                      ListTile(
                        title: const Text('当前版本'),
                        trailing: const Text(version),
                        onTap: Url.version(version).launch,
                      ),
                      Obx(() => ListTile(
                            title: const Text('最新版本'),
                            trailing: logic.latestVer.value == null
                                ? Loading()
                                : logic.latestVer.value!.isEmpty
                                    ? IconButton(
                                        onPressed: logic.updateVerInfo,
                                        icon:
                                            const FaIcon(FontAwesomeIcons.redo),
                                      )
                                    : Badge(
                                        child: Text(logic.latestVer.value!),
                                        badgeContent: FaIcon(
                                          logic.updateAvailable
                                              ? FontAwesomeIcons.exclamation
                                              : FontAwesomeIcons.check,
                                          size: 16,
                                        ),
                                        badgeColor: logic.updateAvailable
                                            ? Colors.orange
                                            : Colors.green,
                                        position: BadgePosition.topStart(
                                            top: -4, start: -32),
                                      ),
                            onTap: Url.latest.launch,
                          )),
                      ListTile(
                        title: const Text('反馈'),
                        trailing: FaIcon(
                          FontAwesomeIcons.github,
                          color: theme.onBackground,
                        ),
                        onTap: Url.issues.launch,
                      ),
                      AboutListTile(
                        applicationIcon: SvgPicture.asset(
                          'assets/images/icon.svg',
                          color: theme.onBackground,
                          width: 42,
                        ),
                        applicationLegalese: license,
                        applicationVersion: release,
                        child: const Text('许可协议'),
                      ),
                    ],
                  ).toList()),
            ],
          ),
        ),
      ),
    );
  }
}
