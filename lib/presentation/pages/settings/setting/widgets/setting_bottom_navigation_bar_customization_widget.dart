import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:open_player/base/assets/fonts/styles.dart';
import 'package:open_player/logic/theme_cubit/theme_cubit.dart';
import 'package:open_player/logic/theme_cubit/theme_state.dart';
import 'package:open_player/presentation/common/widgets/texty.dart';

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
            style: TextStyle(
                fontSize: 13,
                fontFamily: AppFonts.poppins,
                fontWeight: FontWeight.bold),
          ),
          children: [
            //--------- Change Bottom Nav Background Color
            const SettingChangeBottomNavBarBgColorTileWidget(),

            const Texty(
              en: "Positions",
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
                  style: TextStyle(),
                ),
                Texty(
                  en: "Right",
                  style: TextStyle(),
                ),
                Texty(
                  en: "Top",
                  style: TextStyle(),
                ),
                Texty(
                  en: "Bottom",
                ),
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
                style: TextStyle(),
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
                        ? Colors.transparent
                        : Color(themeState.primaryColor),
                child: HugeIcon(
                    icon: HugeIcons.strokeRoundedNavigation01,
                    color: Theme.of(context).iconTheme.color!),
              ),
            ),
            const Gap(20),
            const Texty(
              en: "Size",
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
                  style: TextStyle(),
                ),
                Row(
                  children: [
                    ElevatedButton.icon(
                      onPressed: () {
                        context.read<ThemeCubit>().increaseBottomNavBarWidth();
                      },
                      label: const Texty(
                        en: "Increase",
                        style: TextStyle(),
                      ),
                      icon: const Icon(Icons.add),
                    ),
                    const Gap(10),
                    ElevatedButton.icon(
                      onPressed: () {
                        context.read<ThemeCubit>().decreaseBottomNavBarWidth();
                      },
                      label: const Texty(
                        en: "Decrease",
                        style: TextStyle(),
                      ),
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
                  style: TextStyle(),
                ),
                Row(
                  children: [
                    ElevatedButton.icon(
                      onPressed: () {
                        context.read<ThemeCubit>().increaseBottomNavBarHeight();
                      },
                      label: const Texty(
                        en: "Increase",
                        style: TextStyle(),
                      ),
                      icon: const Icon(Icons.add),
                    ),
                    const Gap(10),
                    ElevatedButton.icon(
                      onPressed: () {
                        context.read<ThemeCubit>().decreaseBottomNavBarHeight();
                      },
                      label: const Texty(
                        en: "Decrease",
                        style: TextStyle(),
                      ),
                      icon: const Icon(Icons.remove),
                    ),
                  ],
                ),
              ],
            ),
            const Gap(20),

            ///------------------- Transform ----------------//

            const Texty(
              en: "Transform",
              style: TextStyle(
                  fontFamily: AppFonts.poppins,
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            ),
            const Gap(20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Texty(
                    en: "Rotation",
                    style: TextStyle(),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CircleAvatar(
                        child: IconButton(
                          onPressed: () {
                            context
                                .read<ThemeCubit>()
                                .updateBottomNavigationBarRotationToLeft();
                          },
                          icon: const Icon(Icons.rotate_left),
                        ),
                      ),
                      const Gap(20),
                      CircleAvatar(
                        child: IconButton(
                          onPressed: () {
                            context
                                .read<ThemeCubit>()
                                .updateBottomNavigationBarRotationToRight();
                          },
                          icon: const Icon(Icons.rotate_right),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),

            const Gap(20),
            const Texty(
              en: "Reset To default",
              style: TextStyle(),
            ),
            const Gap(10),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      textStyle: const TextStyle(fontSize: 12),
                    ),
                    onPressed: () {
                      context
                          .read<ThemeCubit>()
                          .resetToDefaultBottomNavBarPosition();
                    },
                    label: const Texty(
                      en: "Position",
                      style: TextStyle(),
                    ),
                    icon: const Icon(HugeIcons.strokeRoundedNavigation01),
                  ),
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      textStyle: const TextStyle(fontSize: 12),
                    ),
                    onPressed: () {
                      context
                          .read<ThemeCubit>()
                          .resetToDefaultBottomNavBarHeightAndWidth();
                    },
                    label: const Texty(
                      en: "Size",
                      style: TextStyle(),
                    ),
                    icon: const Icon(HugeIcons.strokeRoundedResize01),
                  ),
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      textStyle: const TextStyle(fontSize: 12),
                    ),
                    onPressed: () {
                      context
                          .read<ThemeCubit>()
                          .resetToDefaultBottomNavBarRotation();
                    },
                    label: const Texty(
                      en: "Rotation",
                      style: TextStyle(),
                    ),
                    icon: const Icon(Icons.rotate_90_degrees_cw_sharp),
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
