import 'package:flutter/cupertino.dart';

import '../../../../common/texty.dart';

class SettingTopSettingHeadingWidget extends StatelessWidget {
  const SettingTopSettingHeadingWidget({
    super.key,
  });


  @override
  Widget build(BuildContext context) {
     final double mqHeight = MediaQuery.sizeOf(context).height;
    return SizedBox(
      height: mqHeight * 0.15,
      width: double.infinity,
      child: const Padding(
        padding: EdgeInsets.only(left: 10, right: 10, top: 45 ,),
        child: Texty(
        en: "Settings",
  ar: "الإعدادات",
  es: "Configuración",
  fr: "Paramètres",
  hi: "सेटिंग्स",
  ur: "ترتیبات",
  zh: "设置",
  ps: "تنظیمات",
  kr: "설정",
  ru: "Настройки",

          style: TextStyle(fontSize: 40, letterSpacing: 1),
        ),
      ),
    );
  }
}
