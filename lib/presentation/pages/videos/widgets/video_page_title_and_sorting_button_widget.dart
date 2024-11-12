import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
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
            //--------- Buttons Bar ------------//
            Expanded(
              child: OverflowBar(
                alignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Text("All Videos"),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    child: ElevatedButton.icon(
                      onPressed: () {},
                      icon: Icon(HugeIcons.strokeRoundedFavourite),
                      label: Text("Favorites"),
                    ),
                  ),
                ],
              ),
            ),
            // Spacer(),

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
