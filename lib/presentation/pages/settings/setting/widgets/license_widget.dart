import 'package:flutter/material.dart';

import '../../../../../base/contents/app_contents.dart';
import '../../../../common/texty.dart';
import 'settings_list_tile_widget.dart';

class LicenseWidget extends StatelessWidget {
  const LicenseWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SettingsListTileWidget(
      en: "License",
      ar: "ترخيص",
      es: "Licencia",
      fr: "Licence",
      hi: "लाइसेंस",
      ur: "لائسنس",
      zh: "许可证",
      kr: "라이센스",
      ps: "جواز",
      ru: "Лицензия",
      iconData: Icons.description,
      onTap: () {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Texty(
                en: "Licenses",
                ar: "التراخيص",
                es: "Licencias",
                fr: "Licences",
                hi: "लाइसेंस",
                ur: "لائسنس",
                zh: "许可证",
                kr: "라이센스",
                ps: "جوازونه",
                ru: "Лицензии"),
            content: const SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'MIT License:\n',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Texty(
                    en: AppContents.mitLicensesEn,
                    ur: AppContents.mitLicensesUr,
                    ar: AppContents.mitLicensesAr,
                    es: AppContents.mitLicensesEs,
                    fr: AppContents.mitLicensesFr,
                    hi: AppContents.mitLicensesHi,
                    kr: AppContents.mitLicensesKr,
                    ps: AppContents.mitLicensesPs,
                    ru: AppContents.mitLicensesRu,
                    zh: AppContents.mitLicensesZh,
                    textAlign: TextAlign.start,
                    style: TextStyle(fontSize: 16),
                  ),
                  // Add more licenses as needed
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (p0) => const AboutDialog(
                            applicationVersion: "1.0",
                          ));
                },
                child: const Texty(
                  en: "More Licenses",
                  ar: "مزيد من التراخيص",
                  es: "Más Licencias",
                  fr: "Plus de Licences",
                  hi: "अधिक लाइसेंस",
                  ur: "مزید لائسنس",
                  zh: "更多许可证",
                  kr: "추가 라이선스",
                  ps: "نور جوازات",
                  ru: "Больше лицензий",
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Texty(
                  en: "Close",
                  ar: "إغلاق",
                  es: "Cerrar",
                  fr: "Fermer",
                  hi: "बंद करें",
                  ur: "بند کریں",
                  zh: "关闭",
                  kr: "닫기",
                  ps: "بنده",
                  ru: "Закрыть",
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
