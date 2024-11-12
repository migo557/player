import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_player/logic/theme_cubit/theme_cubit.dart';
import 'package:open_player/presentation/common/widgets/texty.dart';
import 'package:open_player/presentation/common/widgets/custom_theme_mode_button_widget.dart';

import '../../../../../logic/theme_cubit/theme_state.dart';

class SettingThemeModeSwitchButtonWidget extends StatelessWidget {
  const SettingThemeModeSwitchButtonWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        return ListTile(
          onTap: () {
            context.read<ThemeCubit>().toggleThemeMode();
          },
          title: const Texty(
            en: "Theme Mode",
          ),
          trailing: CustomThemeModeButtonWidget(),
        );
      },
    );
  }
}
