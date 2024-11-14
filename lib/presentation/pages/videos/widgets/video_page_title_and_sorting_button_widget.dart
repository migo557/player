import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:open_player/base/assets/fonts/styles.dart';
import 'package:velocity_x/velocity_x.dart';

class VideoPageTitleAndSortingButtonWidget extends HookWidget {
  const VideoPageTitleAndSortingButtonWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final isAllVideos = useState(false);
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            //--------- Buttons Bar ------------//
            Expanded(
              child: AnimatedToggleSwitch.dual(
                first: true,
                second: false,
                current: isAllVideos.value,
                iconBuilder: (value) => isAllVideos.value
                    ? Icon(HugeIcons.strokeRoundedVideo01)
                    : Icon(Icons.favorite),
                customTextBuilder: (context, local, global) => global.current
                    ? "All Videos".text.fontFamily(AppFonts.poppins).make()
                    : "Favorites".text.fontFamily(AppFonts.poppins).make(),
                onChanged: (v) {
                  isAllVideos.value = !isAllVideos.value;
                },
              ),
            ),

            // Spacer(),

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
