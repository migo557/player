import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AudioSearchAppBarWidget extends StatelessWidget {
  const AudioSearchAppBarWidget({
    super.key,
    required this.query,
  });

  final ValueNotifier<String> query;

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.sizeOf(context);
    return SliverAppBar(
      floating: true,
      elevation: 0,
      shadowColor: Colors.transparent,
      backgroundColor: Colors.transparent,
      automaticallyImplyLeading: false,
      actions: [
        Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: mediaQuery.width * 0.03),
            child: Card(
              margin: EdgeInsets.zero,
              shadowColor: Theme.of(context).brightness == Brightness.dark
                  ? Colors.white
                  : null,
              elevation: 1,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(10)),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        context.pop();
                        query.value = "";
                      },
                      icon: const Icon(CupertinoIcons.back),
                    ),
                    Expanded(
                      child: TextField(
                        autofocus: true,
                        onChanged: (search) =>
                            query.value = search.toLowerCase(),
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: "Search audio",
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
