import 'package:flutter/material.dart';
import 'package:open_player/presentation/pages/initial/widgets/bottom-navbar/bottom_nav_bar_button_widget.dart';

class CustomBottomNavBarWidget extends StatelessWidget {
  const CustomBottomNavBarWidget({super.key, required this.index});

  final int index;

  @override
  Widget build(BuildContext context) {
    final double mqWidth = MediaQuery.sizeOf(context).width;
    final double mqHeight = MediaQuery.sizeOf(context).height;

    return Positioned(
      //------Margin Bottom is  5% of Screen Height  --------//
      bottom: mqHeight * 0.05,
      //------Margin Left is  10% of Screen Width  --------//
      left: mqWidth * 0.1,
      //------Margin Right is  10% of Screen Width  --------//
      right: mqWidth * 0.1,
      child: SizedBox(
          //---Height is 5% of Screen Height -----///
          height: mqHeight * 0.05,
          //---Width is 80% of Screen Width -----///
          width: mqWidth * 0.8,
          // color: Colors.blue,

          //---------------- Buttons ---------------//
          child: Row(
            children: [
              //--- Audio Button ---//
              BottomNavBarButtonWidget(
                icon: Icons.music_note,
                isSelected: index == 0,
                onPressed: () {},
              ),

             //--- Video Button ---//
              BottomNavBarButtonWidget(
                icon: Icons.video_collection,
                isSelected: index == 1,
                onPressed: () {},
              ),

              //--- Settings Button ---//
              BottomNavBarButtonWidget(
                icon: Icons.settings,
                isSelected: index == 2,
                onPressed: () {},
              ),
            ],
          )),
    );
  }
}
