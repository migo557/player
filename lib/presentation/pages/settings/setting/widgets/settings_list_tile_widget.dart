// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:open_player/presentation/common/widgets/texty.dart';

class SettingsListTileWidget extends StatelessWidget {
  const SettingsListTileWidget({
    super.key,
    required this.iconData,
    required this.en,
    this.onTap,
    this.translation
  });

  final IconData iconData;
  final String en;
  final Map<String, String>? translation;

  final onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(iconData),
      title: Texty(
        en: en,
        translations: translation,
      ),
      onTap: onTap,
    );
  }
}
