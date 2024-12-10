import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:open_player/presentation/common/widgets/custom_filter_chip.dart';

enum VideoFilter { all, recentlyAdded, favorites, hidden }

// Extension to provide custom display names
extension VideoFilterExtension on VideoFilter {
  String get displayName {
    switch (this) {
      case VideoFilter.all:
        return 'All';
      case VideoFilter.recentlyAdded:
        return 'Recently Added';
      case VideoFilter.favorites:
        return 'Favorites';
      case VideoFilter.hidden:
        return 'Hidden';
    }
  }
}

class VideoPageTitleAndSortingButtonWidget extends HookWidget {
  const VideoPageTitleAndSortingButtonWidget({
    super.key,
    required this.selectedFilter,
  });

  final ValueNotifier<VideoFilter> selectedFilter;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: VideoFilter.values.map((filter) {
              final isSelected = selectedFilter.value == filter;
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: CustomFilterChip(
                  label: filter.displayName,
                  isSelected: isSelected ,
                  onSelected: () {
                    selectedFilter.value = filter;
                  },
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
