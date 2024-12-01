import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:open_player/logic/theme_cubit/theme_cubit.dart';
import 'package:open_player/utils/extensions.dart';


class SettingToggleDefaultThemeSwitchListTileWidget extends StatelessWidget {
  const SettingToggleDefaultThemeSwitchListTileWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final state = context.themeCubit.state;
    return SwitchListTile(
      value: !state.defaultTheme,
      onChanged: (value) {
        context.read<ThemeCubit>().toggleDefaultTheme();
      },
      title: Row(
        children: [
          HugeIcon(
              icon: HugeIcons.strokeRoundedColors,
              color: Theme.of(context).iconTheme.color!),
          const Gap(10),
          const Text(
            "Custom Themes",
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
