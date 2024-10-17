import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_player/base/assets/fonts/app-fonts.dart';
import 'package:open_player/logic/theme_cubit/theme_cubit.dart';
import 'package:open_player/utils/snackbars/custom_snackbars.dart';

import '../../../../../logic/theme_cubit/theme_state.dart';
import '../../../../common/texty.dart';

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
            title: const Texty(
              en: "Restore to default setting",
              ar: "استعادة الإعدادات الافتراضية",
              es: "Restaurar la configuración predeterminada",
              fr: "Restaurer les paramètres par défaut",
              hi: "डिफ़ॉल्ट सेटिंग पर पुनर्स्थापित करें",
              ur: "ڈیفالٹ سیٹنگ میں بحال کریں",
              zh: "恢复到默认设置",
              ps: "بشپړ ترتیبات ته راستنیدل",
              kr: "기본 설정으로 복원",
              ru: "Восстановить настройки по умолчанию",
              style: TextStyle(fontFamily: AppFonts.poppins),
            ),
            trailing: const Icon(Icons.settings_backup_restore),
          ),
        );
      },
    );
  }
}
