import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class SongsTopBarButtonsWidget extends HookWidget {
  const SongsTopBarButtonsWidget({
    super.key,
    required this.songsLength,
    required this.valFunc,
    required this.defaultVal
  });

  final int songsLength;
  final String defaultVal;
  final Function(String val) valFunc;

  @override
  Widget build(BuildContext context) {
    final val = useState(defaultVal);
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
                onSelected: (value) {
                  val.value = value;
                  return valFunc(value);
                },
                child: Row(
                  children: [
                    Text("${val.value} "),
                    Icon(Icons.arrow_drop_down),
                  ],
                ),
                itemBuilder: (context) {
                  return [
                    PopupMenuItem(
                      value: "name",
                      child: Text("name"),
                    ),
                    PopupMenuItem(
                      value: "size",
                      child: Text("Size"),
                    ),
                    PopupMenuItem(
                      value: "date",
                      child: Text("Date Modified"),
                    ),
                    PopupMenuItem(
                      value: "type",
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
