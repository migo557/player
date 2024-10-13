import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_player/base/assets/fonts/app-fonts.dart';
import 'package:open_player/logic/theme_cubit/theme_cubit.dart';
import 'package:open_player/utils/snackbars/custom_snackbars.dart';

class SettingRestoreToDefaultSettingWidget extends StatelessWidget {
  const SettingRestoreToDefaultSettingWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, themeState) {
        return Visibility(
          visible: !themeState.defaultTheme,
          child: ListTile(
             dense: true,
            onTap: () {
              context.read<ThemeCubit>().restoreDefaultSetting();
              AppCustomSnackBars.normalSuccess(
                  "Restore to Default Setting Successfully");
            },
            title: const Text(
              "Restore to default setting",
              style: TextStyle(fontFamily: AppFonts.poppins),
            ),
            trailing: const Icon(Icons.settings_backup_restore),
          ),
        );
      },
    );
  }
}
