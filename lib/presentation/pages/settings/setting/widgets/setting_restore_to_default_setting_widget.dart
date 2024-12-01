import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_player/base/assets/fonts/styles.dart';
import 'package:open_player/logic/theme_cubit/theme_cubit.dart';
import 'package:open_player/utils/custom_snackbars.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../../../logic/theme_cubit/theme_state.dart';

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
            title: "Restore to default setting"
                .text
                .fontFamily(AppFonts.poppins)
                .make(),
            trailing: const Icon(Icons.settings_backup_restore),
          ),
        );
      },
    );
  }
}
