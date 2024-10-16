import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:open_player/base/assets/fonts/app-fonts.dart';
import 'package:open_player/presentation/pages/settings/setting/widgets/setting_change_app_bar_color_background_tile_widget.dart';
import 'package:open_player/presentation/pages/settings/setting/widgets/setting_change_bottom_nav_bar_bg_color_tile_widget.dart';
import 'package:open_player/presentation/pages/settings/setting/widgets/setting_change_scaffold_color_tile_widget.dart';
import 'package:open_player/presentation/pages/settings/setting/widgets/setting_contrast_level_widget.dart';
import 'package:open_player/presentation/pages/settings/setting/widgets/setting_visual_density_widget.dart';

import '../../../../../logic/theme_cubit/theme_cubit.dart';
import '../../../../../logic/theme_cubit/theme_state.dart';

class SettingVisualCustomizationWidget extends StatelessWidget {
  const SettingVisualCustomizationWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final Size mqSize = MediaQuery.sizeOf(context);

    return ExpansionTile(
      title: const Text(
        "Visual Customization",
        style: TextStyle(
            fontSize: 13,
            fontFamily: AppFonts.poppins,
            fontWeight: FontWeight.bold),
      ),
      children: [
        //--------- Contrast Level
        const SettingContrastLevelWidget(),

        ///--------- Visual Density
        const SettingVisualDensityWidget(),

        //----------- Bottom Navigation Bar Position
        BlocBuilder<ThemeCubit, ThemeState>(
          builder: (context, themeState) {
            return ExpansionTile(
              title: const Text("Bottom Navigation Bar Setting"),
              children: [
                const Text(
                  "Positions",
                  style: TextStyle(
                      fontFamily: AppFonts.poppins,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
                const Gap(20),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text("Left "),
                    Text("Right"),
                    Text("Top"),
                    Text("Bottom"),
                  ],
                ),
                const Gap(20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                      iconSize: 45,
                      onPressed: () {
                        context
                            .read<ThemeCubit>()
                            .changeBottomNavBarPositionLeft();
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
                        context
                            .read<ThemeCubit>()
                            .changeBottomNavBarPositionTop();
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
                const Text(
                    "Hold the circle and move it vertically or horizontally "),
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
                      context
                          .read<ThemeCubit>()
                          .changeBottomNavBarPositionRight();
                    } else {
                      context
                          .read<ThemeCubit>()
                          .changeBottomNavBarPositionLeft();
                    }
                  },
                  onVerticalDragUpdate: (d) {
                    log("On Vertical Drag update : ${d.delta.dy}");
                    final dy = d.delta.dy;

                    if (dy > 0) {
                      context
                          .read<ThemeCubit>()
                          .changeBottomNavBarPositionBottom();
                    } else {
                      context
                          .read<ThemeCubit>()
                          .changeBottomNavBarPositionTop();
                    }
                  },
                  child: CircleAvatar(
                    radius: themeState.isHoldBottomNavBarCirclePositionButton
                        ? 50
                        : 30,
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
                const Text(
                  "Size",
                  style: TextStyle(
                      fontFamily: AppFonts.poppins,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
                const Gap(20),

                ///----------- Width
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Text(
                      "Width",
                    ),
                    Row(
                      children: [
                        ElevatedButton.icon(
                          onPressed: () {
                            context
                                .read<ThemeCubit>()
                                .increaseBottomNavBarWidth();
                          },
                          label: const Text("Increase"),
                          icon: const Icon(Icons.add),
                        ),
                        const Gap(10),
                        ElevatedButton.icon(
                          onPressed: () {
                            context
                                .read<ThemeCubit>()
                                .decreaseBottomNavBarWidth();
                          },
                          label: const Text("Decrease"),
                          icon: const Icon(Icons.remove),
                        ),
                      ],
                    ),
                  ],
                ),
                const Gap(10),

                ///----------- Height
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Text(
                      "Height",
                    ),
                    Row(
                      children: [
                        ElevatedButton.icon(
                          onPressed: () {
                            context
                                .read<ThemeCubit>()
                                .increaseBottomNavBarHeight();
                          },
                          label: const Text("Increase"),
                          icon: const Icon(Icons.add),
                        ),
                        const Gap(10),
                        ElevatedButton.icon(
                          onPressed: () {
                            context
                                .read<ThemeCubit>()
                                .decreaseBottomNavBarHeight();
                          },
                          label: const Text("Decrease"),
                          icon: const Icon(Icons.remove),
                        ),
                      ],
                    ),
                  ],
                ),

                const Gap(20),

                const Text("Reset To default"),
                  const Gap(10),

                Row(
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
                      label: const Text("Positon "),
                      icon: const Icon(HugeIcons.strokeRoundedNavigation01),
                    ),
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                          fixedSize: Size(mqSize.width * 0.45, 30),
                          textStyle: const TextStyle(fontSize: 12)),
                      onPressed: () {
                        context
                            .read<ThemeCubit>()
                            .resetToDefaultBottomNavBarHeightAndWidth();
                      },
                      label: const Text(
                        "Size",
                      ),
                      icon: const Icon(
                        HugeIcons.strokeRoundedResize01,
                      ),
                    ),
                  ],
                ),
                const Gap(20),
              ],
            );
          },
        ),

        //--------- Change Scaffold Color
        const SettingChangeScaffoldColorTileWidget(),

        //--------- Change App Bar Color
        const SettingChangeAppBarColorBackgroundTileWidget(),

        //--------- Change Bottom Nav Background Color
        const SettingChangeBottomNavBarBgColorTileWidget(),
      ],
    );
  }
}
