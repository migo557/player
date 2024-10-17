import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:open_player/logic/theme_cubit/theme_cubit.dart';
import 'package:open_player/presentation/common/texty.dart';

import '../../../../../logic/theme_cubit/theme_state.dart';

class SettingBlackModeSwitchListTileWidget extends StatelessWidget {
  const SettingBlackModeSwitchListTileWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        return Visibility(
          visible: state.isDarkMode,
          child: SwitchListTile(
              value: state.isBlackMode,
              onChanged: (value) {
                context.read<ThemeCubit>().toggleBlackMode();
              },
              title: const Row(
                children: [
                  Icon(
                    HugeIcons.strokeRoundedBlackHole,
                  ),
                  Gap(10),
                  Texty(
                      en: "Black Mode",
                      ar: "الوضع الأسود",
                      es: "Modo negro",
                      fr: "Mode noir",
                      hi: "ब्लैक मोड",
                      ur: "بلیک موڈ",
                      zh: "黑色模式",
                      ps: "تور موډ",
                      kr: "블랙 모드",
                      ru: "Чёрный режим"),
                ],
              )),
        );
      },
    );
  }
}
