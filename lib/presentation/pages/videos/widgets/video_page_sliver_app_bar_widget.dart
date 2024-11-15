import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../../base/router/router.dart';

class VideoPageSliverAppBarWidget extends StatelessWidget {
  const VideoPageSliverAppBarWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      title: "Videos".text.make(),
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
