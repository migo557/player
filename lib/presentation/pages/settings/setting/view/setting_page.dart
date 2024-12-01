import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:open_player/presentation/pages/settings/setting/widgets/setting_appearance_section_widget.dart';
import 'package:open_player/presentation/pages/settings/setting/widgets/setting_top_setting_heading_widget.dart';
import 'package:velocity_x/velocity_x.dart';
import '../../../../../base/router/router.dart';
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
    final double mqHeight = MediaQuery.sizeOf(context).height;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0.05, vertical: 0.05),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ///?-------------------   TOP SETTING HEADING  -----------------------------///
            const SettingTopSettingHeadingWidget(),

            Gap(mqHeight * 0.02),

            ///!-------------------Theme SECTION-----------------------------///
            const SettingAppearanceSectionWidget(),

            ///?-------------------GENERAL SECTION-----------------------------///

            ExpansionTile(
              initiallyExpanded: true,
              title: const Text(
                 "GENERAL",
                style: TextStyle(fontSize: 20, letterSpacing: 1.5),
              ),
              children: [
                Gap(mqHeight * 0.02),

                ///!-------------------Profile-----------------------------///
                SettingsListTileWidget(
                  label: "Profile",
                  iconData: HugeIcons.strokeRoundedProfile02,
                  onTap: () {
                    GoRouter.of(context).push(AppRoutes.userProfileRoute);
                  },
                ),

                _divider(),

                ///!-------------------Language-----------------------------///
                SettingsListTileWidget(
                  label: "Language",
                  iconData: HugeIcons.strokeRoundedLanguageCircle,
                  onTap: () {
                    GoRouter.of(context).push(AppRoutes.languageRoute);
                  },
                ),

                _divider(),

                ///!-------------------Equalizer-----------------------------///
                SettingsListTileWidget(
                  label: "Equalizer",
                  iconData: Icons.equalizer,
                  onTap: () {
                    // context.push(AppRoutes.equalizerRoute);

                    // TODO: Implement
                    showCupertinoDialog(
                      context: context,
                      builder: (context) => CupertinoAlertDialog(
                        title:
                            const Text('Eqaualizer'),
                        content: const Text('This features is on way'),
                        actions: [
                          CupertinoDialogAction(
                            child: const Text('OK'),
                            onPressed: () => Navigator.pop(context),
                          ),
                        ],
                      ),
                    );
                  },
                ),

                _divider(),

                ///!-------------------Feedback-----------------------------///
                SettingsListTileWidget(
                  label: "Feedback",
                  iconData: Icons.feedback,
                  onTap: () {
                    _feedBackButtonOnTap();
                  },
                ),

                _divider(),

                ///!-------------------Privacy Policy-----------------------------///
                SettingsListTileWidget(
                  label: "Privacy Policy",
                  iconData: Icons.policy,
                  onTap: () {
                    context.push(AppRoutes.privacyPolicyRoute);
                  },
                ),

                _divider(),

                ///!------------------- Licenses-----------------------------///
                const LicenseWidget(),

                _divider(),

                ///!-------------------About-----------------------------///
                SettingsListTileWidget(
                  label: "About",
                  iconData: HugeIcons.strokeRoundedInformationDiamond,
                  onTap: () {
                    context.push(AppRoutes.aboutRoute);
                  },
                ),
              ],
            ),

            Gap(mqHeight * 0.2),
          ],
        ),
      ).scrollVertical(),
    );
  }

  Divider _divider() {
    return const Divider();
  }
  ////////////////////!//////////////////////////////////////////////////
  ///?------------------------    M E T H O D S  --------------------///
  //!/////////////////////////////////////////////////////////////////////

  // /!------------ Feedback On Tap
  Future<void> _feedBackButtonOnTap() async {
    // final Email sendEmail = Email(
    //   body: 'your feed back?',
    //   subject: 'Player Feedback',
    //   recipients: ['furqanuddin@programmer.net'],
    //   isHTML: false,
    // );

    // await FlutterEmailSender.send(sendEmail);
  }
}
