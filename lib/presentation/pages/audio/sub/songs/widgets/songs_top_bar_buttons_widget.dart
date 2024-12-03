import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:open_player/presentation/common/widgets/custom_filter_chip.dart';
import 'package:velocity_x/velocity_x.dart';

enum SongsFiltered { all, favorites, recents, hidden }

// Extension to provide custom display names
extension SongsFilterExtension on SongsFiltered {
  String get displayName {
    switch (this) {
      case SongsFiltered.all:
        return 'All';
      case SongsFiltered.recents:
        return 'Recently Added';
      case SongsFiltered.favorites:
        return 'Favorites';
      case SongsFiltered.hidden:
        return 'Hidden';
    }
  }
}

class SongsTopBarButtonsWidget extends HookWidget {
  const SongsTopBarButtonsWidget(
      {super.key, required this.songsLength, required this.selectedFilter});

  final int songsLength;

  final ValueNotifier<SongsFiltered> selectedFilter;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 1),
        child: Row(
          children: [
            //-----Songs Length
            // "$songsLength songs"
            //     .text
            //     .size(5)
            //     .color(Theme.of(context).primaryColor)
            //     .make(),

            //----- Sorting Button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
              child: Row(
                children: SongsFiltered.values.map((filter) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: CustomFilterChip(
                      isSelected: selectedFilter.value == filter,
                      label: filter.displayName.toUpperCase(),
                      onSelected: () {
                        selectedFilter.value = filter;
                      },
                    ),
                  );
                }).toList(),
              ).scrollHorizontal(),
            ),
          ],
        ).scrollHorizontal(),
      ),
    );
  }
}
