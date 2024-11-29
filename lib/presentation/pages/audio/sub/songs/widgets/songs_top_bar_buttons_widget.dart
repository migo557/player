import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:velocity_x/velocity_x.dart';

enum SongsFiltered { name, favorites, recents, hidden }

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
            "$songsLength songs"
                .text
                .size(5)
                .color(Theme.of(context).primaryColor)
                .make(),

            //----- Sorting Button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
              child: Row(
                children: SongsFiltered.values.map((filter) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: FilterChip(
                      labelStyle: TextStyle(fontSize: 10),
                      selected: selectedFilter.value == filter,
                      label: Text(filter.name.toUpperCase()),
                      onSelected: (selected) {
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
