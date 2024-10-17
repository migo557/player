// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:open_player/presentation/common/texty.dart';

class SettingsListTileWidget extends StatelessWidget {
  const SettingsListTileWidget({
    super.key,
    required this.iconData,
    required this.en,
    this.ar,
    this.es,
    this.fr,
    this.hi,
    this.ur,
    this.zh,
    this.ps,
    this.kr,
    this.ru,
    this.onTap,
  });

  final IconData iconData;
  final String en;
  final String? ur;
  final String? ar;
  final String? fr;
  final String? hi;
  final String? zh;
  final String? es;
  final String? ps;
  final String? ru;
  final String? kr;



  final onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(iconData),
      title: Texty(en: en,
      
      ar: ar,
      es: es,
      fr: fr,
      hi: hi,
      ur: ur,
      zh: zh,
      ps: ps,
      ru: ru,
      kr: kr,
      ),
      onTap: onTap,
    );
  }
}
