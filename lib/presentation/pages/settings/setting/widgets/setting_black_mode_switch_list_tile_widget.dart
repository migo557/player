import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_player/logic/theme_cubit/theme_cubit.dart';

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
              title: const Text("Black Mode")),
        );
      },
    );
  }
}
