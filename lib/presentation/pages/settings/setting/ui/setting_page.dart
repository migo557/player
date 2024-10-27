import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:open_player/base/router/app_routes.dart';
import 'package:open_player/presentation/common/texty.dart';
import 'package:open_player/presentation/pages/settings/setting/widgets/setting_appearance_section_widget.dart';
import 'package:open_player/presentation/pages/settings/setting/widgets/setting_top_setting_heading_widget.dart';
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
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
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
                title: const Texty(
                  en: "GENERAL",
                  ar: "عام",
                  es: "GENERAL",
                  fr: "GÉNÉRAL",
                  hi: "सामान्य",
                  ur: "عام",
                  zh: "一般",
                  ps: "عمومي",
                  kr: "일반",
                  ru: "ОБЩИЙ",
                  style: TextStyle(fontSize: 20, letterSpacing: 1.5),
                ),
                children: [
                  Gap(mqHeight * 0.02),

                  ///!-------------------Profile-----------------------------///
                  SettingsListTileWidget(
                    en: "Profile",
                    ar: "ملف",
                    es: "Perfil",
                    fr: "Profil",
                    hi: "प्रोफ़ाइल",
                    ur: "پروفائل",
                    zh: "个人资料",
                    ps: "پروفایل",
                    kr: "프로필",
                    ru: "Профиль",
                    iconData: HugeIcons.strokeRoundedProfile02,
                    onTap: () {
                      GoRouter.of(context).push(AppRoutes.userProfileRoute);
                    },
                  ),

                  _divider(),

                  ///!-------------------Language-----------------------------///
                  SettingsListTileWidget(
                    en: "Language",
                    ar: "لغة",
                    es: "Idioma",
                    fr: "Langue",
                    hi: "भाषा",
                    ur: "زبان",
                    zh: "语言",
                    ps: "ژبه",
                    kr: "언어",
                    ru: "Язык",
                    iconData: HugeIcons.strokeRoundedLanguageCircle,
                    onTap: () {
                      GoRouter.of(context).push(AppRoutes.languageRoute);
                    },
                  ),

                  _divider(),

                  ///!-------------------Equalizer-----------------------------///
                  SettingsListTileWidget(
                    en: "Equalizer",
                    ar: "موازن",
                    es: "Ecualizador",
                    fr: "Égaliseur",
                    hi: "इक्वलाइज़र",
                    ur: "ایکولائزر",
                    zh: "均衡器",
                    ps: "برابري",
                    kr: "이퀄라이저",
                    ru: "Эквалайзер",
                    iconData: Icons.equalizer,
                    onTap: () {
                      context.push(AppRoutes.audioPlayerRoute);
                    },
                  ),

                  _divider(),

                  ///!-------------------Feedback-----------------------------///
                  SettingsListTileWidget(
                    en: "Feedback",
                    ar: "ملاحظات",
                    es: "Comentarios",
                    fr: "Retour d'information",
                    hi: "प्रतिपुष्टि",
                    ur: "تجاویز",
                    zh: "反馈",
                    ps: "تبصره",
                    kr: "피드백",
                    ru: "Обратная связь",
                    iconData: Icons.feedback,
                    onTap: () {},
                  ),

                  _divider(),

                  ///!-------------------Privacy Policy-----------------------------///
                  SettingsListTileWidget(
                    en: "Privacy Policy",
                    ar: "سياسة الخصوصية",
                    es: "Política de privacidad",
                    fr: "Politique de confidentialité",
                    hi: "गोपनीयता नीति",
                    ur: "رازداری کی پالیسی",
                    zh: "隐私政策",
                    ps: "د محرمیت پالیسي",
                    kr: "개인정보 처리방침",
                    ru: "Политика конфиденциальности",
                    iconData: Icons.policy,
                    onTap: () {},
                  ),

                  _divider(),

                  ///!------------------- Licenses-----------------------------///
                  const LicenseWidget(),

                  _divider(),

                  ///!-------------------About-----------------------------///
                  SettingsListTileWidget(
                      en: "About",
                      ar: "حول",
                      es: "Acerca de",
                      fr: "À propos",
                      hi: "के बारे में",
                      ur: "کے بارے میں",
                      zh: "关于",
                      ps: "په اړه",
                      kr: "정보",
                      ru: "О программе",
                      iconData: HugeIcons.strokeRoundedInformationDiamond,
                      onTap: () {}),
                ],
              ),

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
