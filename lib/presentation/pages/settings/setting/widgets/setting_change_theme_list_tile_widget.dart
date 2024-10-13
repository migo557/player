import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_player/presentation/pages/settings/change-theme/ui/change-theme-page.dart';

import '../../../../../logic/theme_cubit/theme_cubit.dart';

class SettingChangeThemeSwitchListTileWidget extends StatelessWidget {
  const SettingChangeThemeSwitchListTileWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        return Visibility(
          visible: !state.defaultTheme,
          child: ListTile(
            leading: const Icon(Icons.color_lens),
            title: const Text("Change Theme"),
            trailing: CircleAvatar(
              radius: 15,
              backgroundColor: Theme.of(context).primaryColor,
            ),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ChangeThemePage(),
                  ));
            },
          ),
        );
      },
    );
  }
}
