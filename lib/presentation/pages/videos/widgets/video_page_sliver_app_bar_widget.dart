import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:open_player/base/strings/app_strings.dart';
import 'package:open_player/logic/language_cubit/language_cubit.dart';
import 'package:open_player/utils/context_extensions.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../../base/router/router.dart';

class VideoPageSliverAppBarWidget extends StatelessWidget {
  const VideoPageSliverAppBarWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
     final String lnCode = context.languageCubit.state.languageCode;
    return SliverAppBar(
      title: AppStrings.videos[lnCode]!.text.make(),
      floating: true,
      actions: [
        IconButton(
          onPressed: () {
            GoRouter.of(context).push(AppRoutes.searchVideosRoute);
          },
          icon: const Icon(Icons.search),
        ),
      ],
    );
  }
}
