import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

class VideoPageTitleAndSortingButtonWidget extends StatelessWidget {
  const VideoPageTitleAndSortingButtonWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
     child: Padding(
       padding: const EdgeInsets.all(12.0),
       child: Row(
         mainAxisAlignment: MainAxisAlignment.spaceBetween,
         children: [
           const Text("All Videos"),
           IconButton(onPressed: () {}, icon: const Icon(HugeIcons.strokeRoundedSortingAZ02))
         ],
       ),
     ),
            );
  }
}
