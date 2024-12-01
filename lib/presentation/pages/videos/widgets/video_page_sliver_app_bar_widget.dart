import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:open_player/base/strings/app_strings.dart';
import 'package:open_player/utils/extensions.dart';
import 'package:velocity_x/velocity_x.dart';
import '../../../../base/router/router.dart';

class VideoPageSliverAppBarWidget extends StatelessWidget {
  const VideoPageSliverAppBarWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    //------ Language Code Extension --- Defined in extension on BuildContext"
    final String lc = context.languageCubit.state.languageCode;
    return SliverAppBar(
      title: AppStrings.videos[lc]!.text.make(),
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
