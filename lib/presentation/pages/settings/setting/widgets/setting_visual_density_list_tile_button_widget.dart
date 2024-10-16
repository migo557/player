import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_player/logic/theme_cubit/theme_cubit.dart';

import '../../../../../logic/theme_cubit/theme_state.dart';

class SettingVisualDensityListTileButtonWidget extends StatelessWidget {
  const SettingVisualDensityListTileButtonWidget({
    super.key,
    required this.label,
    required this.visualDensity,
  });
 final String label;
 final VisualDensity visualDensity;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, themeState) {
        return Expanded(
          child: ListTile(
             dense: true,
            selected: themeState.visualDensity == visualDensity,
            title: Center(child: Text(label)),
            onTap: () {
              context.read<ThemeCubit>().changeVisualDensity(visualDensity);
            },
          ),
        );
      },
    );
  }
}
