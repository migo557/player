import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_player/base/assets/fonts/app-fonts.dart';
import 'package:open_player/base/di/dependency_injection.dart';
import 'package:open_player/base/theme/themes.dart';

import '../../../../../logic/theme_cubit/theme_cubit.dart';
import '../../../../../logic/theme_cubit/theme_state.dart';

class ChangeThemePage extends StatelessWidget {
  const ChangeThemePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Change Theme"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          BlocBuilder<ThemeCubit, ThemeState>(
            builder: (context, state) {
              return Expanded(
                child: ListView.builder(
                  itemCount: locator<AppThemes>().flexThemes.length,
                  itemBuilder: (context, index) => ListTile(
                    visualDensity: VisualDensity.comfortable,
                    onTap: () {
                      // context.read<ThemeCubit>().changeFlexScheme(
                      //     flexScheme: locator<AppThemes>()
                      //         .flexThemes[index]
                      //         .flexScheme);
                      context.read<ThemeCubit>().changeFlexIndex(index);
                      Navigator.pop(context);
                    },
                    leading: Text("$index"),
                    selected: state.flexThemeListIndex == index,
                    selectedTileColor: Theme.of(context).focusColor,
                    title: Text(
                      locator<AppThemes>()
                          .flexThemes[index]
                          .title
                          .toUpperCase(),
                      style: const TextStyle(
                        fontFamily: AppFonts.poppins,
                      ),
                    ),
                    trailing: CircleAvatar(
                      backgroundColor: state.isDarkMode
                          ? locator<AppThemes>()
                              .flexThemes[index]
                              .flexColor
                              .dark
                              .primary
                          : locator<AppThemes>()
                              .flexThemes[index]
                              .flexColor
                              .light
                              .primary,
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
