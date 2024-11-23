import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:open_player/base/router/router.dart';


class AudioPageAppBarSearchButtonWidget extends StatelessWidget {
  const AudioPageAppBarSearchButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: IconButton(
        iconSize: 35,
        onPressed: () {
           context.push(AppRoutes.searchAudiosRoute);
        },
        icon: const Icon(Icons.search),
      ),
    );
  }
}
