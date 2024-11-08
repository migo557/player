import 'package:flutter/material.dart';

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
          //-----Videos Length
            Text(
              "All Videos",
              style: Theme.of(context).textTheme.titleSmall,
            ),
            Spacer(),

            //----- Sorting Button
            PopupMenuButton(
              child: Row(
                children: [
                  Text("name "),
                  Icon(Icons.arrow_drop_down),
                ],
              ),
              itemBuilder: (context) {
                return [
                  PopupMenuItem(
                    child: Text("name"),
                  ),
                  PopupMenuItem(
                    child: Text("Size"),
                  ),
                  PopupMenuItem(
                    child: Text("Date Modified"),
                  ),
                  PopupMenuItem(
                    child: Text("Type"),
                  ),
                ];
              },
            ),
         ],
       ),
     ),
            );
  }
}
