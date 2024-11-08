import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:open_player/logic/theme_cubit/theme_cubit.dart';
import 'package:open_player/presentation/common/widgets/texty.dart';

import '../../../../../logic/theme_cubit/theme_state.dart';

class SettingContrastLevelWidget extends StatelessWidget {
  const SettingContrastLevelWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, themeState) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Row(
            children: [
              const Icon(HugeIcons.strokeRoundedEye),
              const Gap(10),
              const Texty(
                en: "Contrast Level",
       
              ),
              Expanded(
                child: Slider(
                  value: themeState.contrastLevel,
                  max: 1.0,
                  min: -1.0,
                  onChanged: (value) {
                    context.read<ThemeCubit>().changeContrastLevel(value);
                  },
                ),
              ),
              Text(themeState.contrastLevel
                  .toString()
                  .replaceRange(3, null, ""))
            ],
          ),
        );
      },
    );
  }
}
