import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../base/router/app_routes.dart';

class AudioPageAppBarSearchButtonWidget extends StatelessWidget {
  const AudioPageAppBarSearchButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      iconSize: 30,
      onPressed: () {
         GoRouter.of(context).push(AppRoutes.searchAudiosRoute);
      },
      icon: const Icon(Icons.search),
    );
  }
}
