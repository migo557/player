import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:open_player/base/router/app_routes.dart';

class LanguagePageNextButtonWidget extends StatelessWidget {
  const LanguagePageNextButtonWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        context.pushReplacementNamed(AppRoutes.userProfileRoute);
      },
      child: const Text("Next"),
    );
  }
}
