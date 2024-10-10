import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:open_player/presentation/pages/settings/setting/widgets/setting_black_mode_switch_list_tile_widget.dart';
import 'package:open_player/presentation/pages/settings/setting/widgets/setting_change_theme_list_tile_widget.dart';
import 'package:open_player/presentation/pages/settings/setting/widgets/setting_dark_mode_button_widget.dart';
import 'package:open_player/presentation/pages/settings/setting/widgets/setting_material3_switch_list_tile_widget.dart';
import 'package:open_player/presentation/pages/settings/setting/widgets/setting_toggle_default_theme_switch_list_tile_widget.dart';
import '../../../../../logic/theme_cubit/theme_cubit.dart';
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
                height: mqHeight * 0.1,
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
              Row(
                children: [
                  const Text(
                    "  APPEARANCE ",
                    style: TextStyle(fontSize: 25, letterSpacing: 1),
                  ),
                  Icon(
                    CupertinoIcons.color_filter,
                    color: Theme.of(context).primaryColor,
                  )
                ],
              ),

              const Gap(
                10,
              ),

              ///!-------------------Default Theme Switch Tile-----------------------------///
              const SettingToggleDefaultThemeSwitchListTileWidget(),

              //!-------------------Change Theme Switch Tile-----------------------------///
              const SettingChangeThemeSwitchListTileWidget(),

              //!-------------------- Use Material Switch Tile -------------------------//
              const SettingMaterial3SwitchListTileWidget(),

              //!-------------------Dark Mode Switch Tile-----------------------------///
              const SettingDarkModeButtonWidget(),

              //!-------------------Black Mode Switch Tile-----------------------------///
              const SettingBlackModeSwitchListTileWidget(),

              Gap(mqHeight * 0.02),

              ///?-------------------GENERAL SECTION-----------------------------///
              const Text(
                "  GENERAL",
                style: TextStyle(fontSize: 30, letterSpacing: 1.5),
              ),

              Gap(mqHeight * 0.02),

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

              Gap(mqHeight * 0.2),
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
