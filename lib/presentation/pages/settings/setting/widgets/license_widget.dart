import 'package:flutter/material.dart';
import 'package:open_player/base/strings/app_strings.dart';
import '../../../../../base/strings/app_disclaimer_licenses_strings.dart';
import '../../../../common/widgets/texty.dart';
import 'settings_list_tile_widget.dart';

class LicenseWidget extends StatelessWidget {
  const LicenseWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SettingsListTileWidget(
      en: "License",
      iconData: Icons.description,
      onTap: () {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Texty(
              en: "Licenses",
              style: TextStyle(),
            ),
            content: const SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'MIT License:\n',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Texty(
                    en: AppDisclaimerAndLicensesStrings.mitLicensesEn,
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
                            applicationVersion: AppStrings.appVersion,
                          ));
                },
                child: const Texty(
                  en: "More Licenses",
                  style: TextStyle(),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Texty(
                  en: "Close",
                  style: TextStyle(),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
