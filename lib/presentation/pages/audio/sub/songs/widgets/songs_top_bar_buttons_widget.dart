import 'package:flutter/material.dart';

class SongsTopBarButtonsWidget extends StatelessWidget {
  const SongsTopBarButtonsWidget({
    super.key,
    required this.songsLength,
  });

  final int songsLength;

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.sizeOf(context);
    return SizedBox(
      height: mq.height * 0.05,
      width: mq.width,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 3),
          child: Row(
            children: [
              //-----Songs Length
              Text(
                "${songsLength - 1} songs",
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
      ),
    );
  }
}
