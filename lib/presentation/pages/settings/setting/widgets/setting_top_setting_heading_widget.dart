import 'package:flutter/cupertino.dart';
import 'package:open_player/base/strings/app_strings.dart';
import 'package:open_player/utils/extensions.dart';

class SettingTopSettingHeadingWidget extends StatelessWidget {
  const SettingTopSettingHeadingWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    //-- Language Code
    final String lc = context.languageCubit.state.languageCode;
    final double mqHeight = MediaQuery.sizeOf(context).height;
    return SizedBox(
      height: mqHeight * 0.15,
      width: double.infinity,
      child: Padding(
        padding: EdgeInsets.only(
          left: 10,
          right: 10,
          top: 45,
        ),
        child: Text(
          AppStrings.settings[lc]!,
          style: TextStyle(fontSize: 40, letterSpacing: 1),
        ),
      ),
    );
  }
}
