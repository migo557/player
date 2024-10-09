import 'package:flutter/material.dart';


import '../../../../../base/contents/app_contents.dart';
import 'settings_list_tile_widget.dart';

class LicenseWidget extends StatelessWidget {
  const LicenseWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SettingsListTileWidget(
      title: "License",
      iconData: Icons.description,
      onTap: () {


        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Licenses'),
            content: const SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'MIT License:\n',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    AppContents.mitLicenses,
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
