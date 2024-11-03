import 'package:flutter/material.dart';
import 'package:open_player/base/strings/app_contents.dart';
import 'package:open_player/presentation/common/texty.dart';

class UserProfilePageDisclaimerMessageWidget extends StatelessWidget {
  const UserProfilePageDisclaimerMessageWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final Size mq = MediaQuery.sizeOf(context);
    return SizedBox(
      width: mq.width * 0.85,
      child: const Texty(
        en: AppContents.disclaimerMessageEn,
        style: TextStyle(color: Colors.white60, fontSize: 13),
      ),
    );
  }
}
