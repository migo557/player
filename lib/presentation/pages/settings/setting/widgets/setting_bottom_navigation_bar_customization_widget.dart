import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:open_player/base/assets/fonts/app-fonts.dart';
import 'package:open_player/logic/theme_cubit/theme_cubit.dart';
import 'package:open_player/logic/theme_cubit/theme_state.dart';
import 'package:open_player/presentation/common/texty.dart';

import 'setting_change_bottom_nav_bar_bg_color_tile_widget.dart';

class SettingBottomNavigationBarCustomizationWidget extends StatelessWidget {
  const SettingBottomNavigationBarCustomizationWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final mqSize = MediaQuery.sizeOf(context);
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, themeState) {
        return ExpansionTile(
          title: const Texty(
              en: "Bottom Navigation Bar",
              ar: "شريط التنقل السفلي",
              es: "Barra de navegación inferior",
              fr: "Barre de navigation inférieure",
              hi: "नीचे नेविगेशन बार",
              kr: "하단 내비게이션 바",
              ps: "د لاندې نیویگیشن بار",
              ru: "Нижняя навигационная панель",
              ur: "نیچے نیویگیشن بار",
              zh: "底部导航栏"),
          children: [
            //--------- Change Bottom Nav Background Color
            const SettingChangeBottomNavBarBgColorTileWidget(),

            const Texty(
              en: "Positions",
              ar: "المواقع",
              es: "Posiciones",
              fr: "Positions",
              hi: "पोजीशन्स",
              kr: "위치",
              ps: "موقعیتونه",
              ru: "Позиции",
              ur: "پوزیشنیں",
              zh: "位置",
              style: TextStyle(
                  fontFamily: AppFonts.poppins,
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            ),
            const Gap(20),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Texty(
                    en: "Left",
                    ar: "يسار",
                    es: "Izquierda",
                    fr: "Gauche",
                    hi: "बाएं",
                    kr: "왼쪽",
                    ps: "چپ",
                    ru: "Слева",
                    ur: "بائیں",
                    zh: "左"),
                Texty(
                    en: "Right",
                    ar: "يمين",
                    es: "Derecha",
                    fr: "Droite",
                    hi: "दाएं",
                    kr: "오른쪽",
                    ps: "ښي",
                    ru: "Справа",
                    ur: "دائیں",
                    zh: "右"),
                Texty(
                    en: "Top",
                    ar: "أعلى",
                    es: "Arriba",
                    fr: "Haut",
                    hi: "ऊपर",
                    kr: "상단",
                    ps: "پورته",
                    ru: "Вверх",
                    ur: "اوپر",
                    zh: "顶部"),
                Texty(
                    en: "Bottom",
                    ar: "أسفل",
                    es: "Abajo",
                    fr: "Bas",
                    hi: "नीचे",
                    kr: "하단",
                    ps: "لاندې",
                    ru: "Вниз",
                    ur: "نیچے",
                    zh: "底部"),
              ],
            ),
            const Gap(20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  iconSize: 45,
                  onPressed: () {
                    context.read<ThemeCubit>().changeBottomNavBarPositionLeft();
                  },
                  icon: const Icon(
                    CupertinoIcons.arrow_left_circle,
                  ),
                ),
                IconButton(
                  iconSize: 45,
                  onPressed: () {
                    context
                        .read<ThemeCubit>()
                        .changeBottomNavBarPositionRight();
                  },
                  icon: const Icon(CupertinoIcons.arrow_right_circle),
                ),
                IconButton(
                  iconSize: 45,
                  onPressed: () {
                    context.read<ThemeCubit>().changeBottomNavBarPositionTop();
                  },
                  icon: const Icon(
                    CupertinoIcons.arrow_up_circle,
                  ),
                ),
                IconButton(
                  iconSize: 45,
                  onPressed: () {
                    context
                        .read<ThemeCubit>()
                        .changeBottomNavBarPositionBottom();
                  },
                  icon: const Icon(
                    CupertinoIcons.arrow_down_circle,
                  ),
                ),
              ],
            ),
            const Gap(10),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Texty(
                  en: "Hold the circle slightly and move it vertically or horizontally",
                  ar: "أمسك الدائرة برفق وانقلها عموديًا أو أفقيًا",
                  es: "Sostén ligeramente el círculo y muévelo vertical u horizontalmente",
                  fr: "Tenez légèrement le cercle et déplacez-le verticalement ou horizontalement",
                  hi: "गेंद को हल्का सा पकड़ें और इसे ऊर्ध्वाधर या क्षैतिज रूप से खिसकाएँ",
                  kr: "원을 살짝 잡고 수직 또는 수평으로 이동하세요",
                  ps: "د دایرې په نرمو سره نیولو او عمودی یا افقی حرکت کولو",
                  ru: "Держите круг слегка и перемещайте его вертикально или горизонтально",
                  ur: "گولے کو ہلکا سا پکڑیں اور اسے عمودی یا افقی طور پر حرکت دیں",
                  zh: "轻轻握住圆圈并垂直或水平移动",
                  textAlign: TextAlign.center,
                  ),
            ),
            const Gap(10),
            GestureDetector(
              onHorizontalDragStart: (d) {
                context
                    .read<ThemeCubit>()
                    .enableHoldBottomNavBarCirclePositionButton();
              },
              onHorizontalDragEnd: (d) {
                context
                    .read<ThemeCubit>()
                    .disableHoldBottomNavBarCirclePositionButton();
              },
              onVerticalDragStart: (d) {
                context
                    .read<ThemeCubit>()
                    .enableHoldBottomNavBarCirclePositionButton();
              },
              onVerticalDragEnd: (d) {
                context
                    .read<ThemeCubit>()
                    .disableHoldBottomNavBarCirclePositionButton();
              },
              onHorizontalDragUpdate: (d) {
                log("On Horizontal Drag update : ${d.delta.dx}");

                final dx = d.delta.dx;

                if (dx > 0) {
                  context.read<ThemeCubit>().changeBottomNavBarPositionRight();
                } else {
                  context.read<ThemeCubit>().changeBottomNavBarPositionLeft();
                }
              },
              onVerticalDragUpdate: (d) {
                log("On Vertical Drag update : ${d.delta.dy}");
                final dy = d.delta.dy;

                if (dy > 0) {
                  context.read<ThemeCubit>().changeBottomNavBarPositionBottom();
                } else {
                  context.read<ThemeCubit>().changeBottomNavBarPositionTop();
                }
              },
              child: CircleAvatar(
                radius:
                    themeState.isHoldBottomNavBarCirclePositionButton ? 50 : 30,
                backgroundColor:
                    themeState.isHoldBottomNavBarCirclePositionButton
                        ? Theme.of(context).indicatorColor
                        : Theme.of(context).primaryColor,
                child: HugeIcon(
                    icon: HugeIcons.strokeRoundedNavigation01,
                    color: Theme.of(context).iconTheme.color!),
              ),
            ),
            const Gap(20),
            const Texty(
              en: "Size",
              ar: "الحجم",
              es: "Tamaño",
              fr: "Taille",
              hi: "आकार",
              kr: "크기",
              ps: "اندازه",
              ru: "Размер",
              ur: "سائز",
              style: TextStyle(
                  fontFamily: AppFonts.poppins,
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            ),
            const Gap(20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Texty(
                  en: "Width",
                  ar: "عرض",
                  es: "Ancho",
                  fr: "Largeur",
                  hi: "चौड़ाई",
                  kr: "너비",
                  ps: "عرض",
                  ru: "Ширина",
                  ur: "چوڑائی",
                ),
                Row(
                  children: [
                    ElevatedButton.icon(
                      onPressed: () {
                        context.read<ThemeCubit>().increaseBottomNavBarWidth();
                      },
                      label: const Texty(
                          en: "Increase",
                          ar: "زيادة",
                          es: "Aumentar",
                          fr: "Augmenter",
                          hi: "बढ़ाना",
                          kr: "늘리기",
                          ps: "زیاتول",
                          ru: "Увеличить",
                          ur: "بڑھانا",
                          zh: "增加"),
                      icon: const Icon(Icons.add),
                    ),
                    const Gap(10),
                    ElevatedButton.icon(
                      onPressed: () {
                        context.read<ThemeCubit>().decreaseBottomNavBarWidth();
                      },
                      label: const Texty(
                          en: "Decrease",
                          ar: "تقليل",
                          es: "Disminuir",
                          fr: "Diminuer",
                          hi: "घटाना",
                          kr: "줄이기",
                          ps: "کموالی",
                          ru: "Уменьшить",
                          ur: "کم کرنا",
                          zh: "减少"),
                      icon: const Icon(Icons.remove),
                    ),
                  ],
                ),
              ],
            ),
            const Gap(10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Texty(
                  en: "Height",
                  ar: "ارتفاع",
                  es: "Altura",
                  fr: "Hauteur",
                  hi: "ऊँचाई",
                  kr: "높이",
                  ps: "لوړوالی",
                  ru: "Высота",
                  ur: "اونچائی",
                ),
                Row(
                  children: [
                    ElevatedButton.icon(
                      onPressed: () {
                        context.read<ThemeCubit>().increaseBottomNavBarHeight();
                      },
                      label: const Texty(
                          en: "Increase",
                          ar: "زيادة",
                          es: "Aumentar",
                          fr: "Augmenter",
                          hi: "बढ़ाना",
                          kr: "늘리기",
                          ps: "زیاتول",
                          ru: "Увеличить",
                          ur: "بڑھانا",
                          zh: "增加"),
                      icon: const Icon(Icons.add),
                    ),
                    const Gap(10),
                    ElevatedButton.icon(
                      onPressed: () {
                        context.read<ThemeCubit>().decreaseBottomNavBarHeight();
                      },
                      label: const Texty(
                          en: "Decrease",
                          ar: "تقليل",
                          es: "Disminuir",
                          fr: "Diminuer",
                          hi: "घटाना",
                          kr: "줄이기",
                          ps: "کموالی",
                          ru: "Уменьшить",
                          ur: "کم کرنا",
                          zh: "减少"),
                      icon: const Icon(Icons.remove),
                    ),
                  ],
                ),
              ],
            ),
            const Gap(20),
            const Texty(
              en: "Reset To default",
              ar: "إعادة تعيين إلى الافتراضي",
              es: "Restablecer a predeterminado",
              fr: "Réinitialiser par défaut",
              hi: "डिफ़ॉल्ट पर रीसेट करें",
              kr: "기본값으로 재설정",
              ps: "برگشت تر_DEFAULT",
              ru: "Сбросить по умолчанию",
              ur: "ڈیفالٹ پر ری سیٹ کریں",
            ),
            const Gap(10),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      fixedSize: Size(mqSize.width * 0.45, 30),
                      textStyle: const TextStyle(fontSize: 12),
                    ),
                    onPressed: () {
                      context
                          .read<ThemeCubit>()
                          .resetToDefaultBottomNavBarPosition();
                    },
                    label: const Texty(
                      en: "Position",
                      ar: "موقع",
                      es: "Posición",
                      fr: "Position",
                      hi: "पोजीशन",
                      kr: "위치",
                      ps: "موقعیت",
                      ru: "Позиция",
                      ur: "پوزیشن",
                      zh: "位置",
                    ),
                    icon: const Icon(HugeIcons.strokeRoundedNavigation01),
                  ),
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      fixedSize: Size(mqSize.width * 0.45, 30),
                      textStyle: const TextStyle(fontSize: 12),
                    ),
                    onPressed: () {
                      context
                          .read<ThemeCubit>()
                          .resetToDefaultBottomNavBarHeightAndWidth();
                    },
                    label: const Texty(
                      en: "Size",
                      ar: "حجم",
                      es: "Tamaño",
                      fr: "Taille",
                      hi: "आकार",
                      kr: "크기",
                      ps: "اندازه",
                      ru: "Размер",
                      ur: "سائز",
                      zh: "大小",
                    ),
                    icon: const Icon(HugeIcons.strokeRoundedResize01),
                  ),
                ],
              ),
            ),

            const Gap(20),
          ],
        );
      },
    );
  }
}
