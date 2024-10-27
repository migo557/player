import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:open_player/base/theme/colors_palates.dart';
import 'package:open_player/presentation/pages/audio/main/ui/audio_page.dart';
import 'package:open_player/presentation/pages/audio/main/widgets/appbar/app_bar_theme_mode_button_widget.dart';
import 'package:open_player/presentation/pages/settings/setting/ui/setting_page.dart';
import 'package:open_player/presentation/pages/videos/ui/video_page.dart';

import '../../../../../logic/theme_cubit/theme_cubit.dart';
import '../../../../../logic/theme_cubit/theme_state.dart';

class ChangeThemePage extends StatefulWidget {
  const ChangeThemePage({super.key});

  @override
  State<ChangeThemePage> createState() => _ChangeThemePageState();
}

class _ChangeThemePageState extends State<ChangeThemePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Primary Material Color"),
        centerTitle: true,
        actions: const [AppBarThemeModeButtonWidget()],
      ),
      body: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, state) {
          final Size mq = MediaQuery.sizeOf(context);
          return Column(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(30),
                  decoration: BoxDecoration(
                      color: Color(state.primaryColor),
                      borderRadius: BorderRadius.circular(60)),
                  child: Stack(
                    children: [
                      Transform.rotate(
                          angle: -0.2,
                          child: Card(
                              child: _pages[pageIndex <= 1 ? 1 + 1 : 0])),
                      Transform.rotate(
                          angle: 0.2,
                          child: Card(
                              child: _pages[pageIndex<=1? 1+1:0])),
                      Card(child: _pages[pageIndex]),
                    ],
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: ElevatedButton(
                      onPressed: (){
                          setState(() {
                          if (pageIndex <=1 ) {
                            pageIndex++;
                          } else {
                            pageIndex = 0;
                          }
                        });
                      }, child: const Text("Change Page")),
                ),
              ),
              //---------- Colors Row --------------///
              SizedBox(
                height: 80,
                width: double.infinity,
                child: ListView.builder(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: AppColors.colorHexCodesList.length,
                    itemBuilder: (context, index) {
                      bool isSelected = state.primaryColorListIndex == index;
                      int primaryColor = AppColors.colorHexCodesList[index];

                      return Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: GestureDetector(
                          onTap: () {
                            context
                                .read<ThemeCubit>()
                                .changeprimaryColor(primaryColor);
                            context
                                .read<ThemeCubit>()
                                .changeprimaryColorListIndex(index);
                          },
                          child: CircleAvatar(
                            maxRadius: 25,
                            minRadius: 20,
                            backgroundColor:
                                Color(AppColors.colorHexCodesList[index]),
                            child: isSelected
                                ? const Icon(HugeIcons.strokeRoundedTick01)
                                : null,
                          ),
                        ),
                      );
                    }),
              ),
            ],
          );
        },
      ),
    );
  }

  int pageIndex = 0;


  final _pages = [
    AudioPage(),
    const VideosPage(),
    const SettingPage(),
  ];
}
