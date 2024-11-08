import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hugeicons/hugeicons.dart';

import '../../../../base/router/router.dart';

class VideoPageSliverAppBarWidget extends StatelessWidget {
  const VideoPageSliverAppBarWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      title: const Text("Videos"),
      floating: true,
      actions: [
        IconButton(
          onPressed: () {
            GoRouter.of(context).push(AppRoutes.searchVideosRoute);
          },
          icon: const Icon(Icons.search),
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(HugeIcons.strokeRoundedGridView),
        ),
        IconButton(
          onPressed: () {
            GoRouter.of(context).push(AppRoutes.viewDirectoryRoute);
          },
          icon: const Icon(HugeIcons.strokeRoundedFolderView),
        ),
      ],
    );
  }
}
