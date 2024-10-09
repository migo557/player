import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../widgets/license_widget.dart';
import '../widgets/settings_list_tile_widget.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    final double mqWidth = MediaQuery.sizeOf(context).width;
    final double mqHeight = MediaQuery.sizeOf(context).height;
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0.05, vertical: 0.05),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ///?-------------------   TOP SETTING HEADING  -----------------------------///
              SizedBox(
                height: mqHeight* 0.1,
                width: double.infinity,
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    " Settings",
                    style: TextStyle(fontSize: 45, letterSpacing: 1),
                  ),
                ),
              ),

              ///!-------------------Theme SECTION-----------------------------///
              const Row(
                children: [
                  Text(
                    "  APPEARANCE ",
                    style: TextStyle(fontSize: 25, letterSpacing: 1),
                  ),
                  Icon(CupertinoIcons.color_filter)
                ],
              ),

              const SizedBox(
                height: 10,
              ),

              ///!-------------------Accent Color Switch Tile-----------------------------///
              ListTile(
                title: const Text("Accent Color"),
                trailing: CircleAvatar(
                  radius: 15,
                  backgroundColor: Theme.of(context).primaryColor,
                ),
                onTap: () {},
              ),

              ///!-------------------Dark Mode Switch Tile-----------------------------///
              SwitchListTile(
                  value: false,
                  onChanged: (value) {},
                  title: const Text("Dark Mode")),

              ///!-------------------Black Mode Switch Tile-----------------------------///
              Visibility(
                visible: true,
                child: SwitchListTile(
                    value: false,
                    onChanged: (value) {},
                    title: const Text("Black Mode")),
              ),

              SizedBox(height: mqHeight * 0.02),

              ///?-------------------GENERAL SECTION-----------------------------///
              const Text(
                "  GENERAL",
                style: TextStyle(fontSize: 30, letterSpacing: 1.5),
              ),

              SizedBox(height: mqHeight * 0.02),

              ///!-------------------Profile-----------------------------///
              SettingsListTileWidget(
                title: "Profile",
                iconData: Icons.person,
                onTap: () {},
              ),

              _divider(),

              ///!-------------------Equalizer-----------------------------///
              SettingsListTileWidget(
                title: "Equalizer",
                iconData: Icons.equalizer,
                onTap: () {},
              ),

              _divider(),

              ///!-------------------Feedback-----------------------------///
              SettingsListTileWidget(
                title: "Feedback",
                iconData: Icons.feedback,
                onTap: () async {},
              ),

              _divider(),

              ///!-------------------Privacy Policy-----------------------------///
              SettingsListTileWidget(
                title: "Privacy Policy",
                iconData: Icons.policy,
                onTap: () {},
              ),

              _divider(),

              ///!------------------- Licenses-----------------------------///
              const LicenseWidget(),

              _divider(),

              ///!-------------------About-----------------------------///
              SettingsListTileWidget(
                  title: "About", iconData: CupertinoIcons.info, onTap: () {}),

              SizedBox(height: mqHeight * 0.2),
            ],
          ),
        ),
      ),
    );
  }

  Divider _divider() {
    return const Divider();
  }
  ////////////////////!//////////////////////////////////////////////////
  ///?------------------------    M E T H O D S  --------------------///
  //!/////////////////////////////////////////////////////////////////////

  ///! -------     Equalizer On Tap

  ///!------------ Feedback On Tap
  // Future<void> _feedBackButtonOnTap() async {
  //   final Email sendEmail = Email(
  //     body: 'your feed back?',
  //     subject: 'LOFIII Feedback',
  //     recipients: ['furqanuddin@gmail.com'],
  //     isHTML: false,
  //   );

  //   await FlutterEmailSender.send(sendEmail);
  // }
}
