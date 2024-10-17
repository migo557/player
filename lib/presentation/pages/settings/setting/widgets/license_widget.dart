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
      iconData: Icons.description,
      onTap: () {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Licenses'),
            content: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
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
                    
                    textAlign: TextAlign.start,
                    style: const TextStyle(fontSize: 16),
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
                child: const Text('More Licenses'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Close'),
              ),
            ],
          ),
        );
      },
    );
  }
}
