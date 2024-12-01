import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_player/logic/theme_cubit/theme_cubit.dart';
import 'package:open_player/presentation/common/widgets/custom_theme_mode_button_widget.dart';


class SettingThemeModeSwitchButtonWidget extends StatelessWidget {
  const SettingThemeModeSwitchButtonWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
  return ListTile(
      onTap: () {
        context.read<ThemeCubit>().toggleThemeMode();
      },
      title: const Text(
        "Theme Mode",
      ),
      trailing: CustomThemeModeButtonWidget(),
    );
  }
}
