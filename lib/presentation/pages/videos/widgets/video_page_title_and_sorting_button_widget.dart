import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:velocity_x/velocity_x.dart';

enum VideoFilter { all, favorites }

class VideoPageTitleAndSortingButtonWidget extends HookWidget {
  const VideoPageTitleAndSortingButtonWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final selectedFilter = useState(VideoFilter.all);
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: VideoFilter.values.map((filter) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: FilterChip(
                      selected: selectedFilter.value == filter,
                      label: Text(filter.name.toUpperCase()),
                      onSelected: (selected) {
                        selectedFilter.value = filter;
                      },
                    ),
                  );
                }).toList(),
              ),
            ).expand(),

            //----- Filter Button
            IconButton(
              onPressed: () {},
              icon: Icon(HugeIcons.strokeRoundedFilter),
            ),
          ],
        ),
      ),
    );
  }
}
