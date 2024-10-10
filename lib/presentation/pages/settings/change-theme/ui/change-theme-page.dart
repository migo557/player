import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_player/base/assets/fonts/app-fonts.dart';
import 'package:open_player/base/theme/themes.dart';

import '../../../../../logic/theme_cubit/theme_cubit.dart';

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
                  itemCount: AppThemes.flexThemes.length,
                  itemBuilder: (context, index) => ListTile(
                    visualDensity: VisualDensity.comfortable,
                    onTap: () {
                      context.read<ThemeCubit>().changeFlexScheme(
                          flexScheme: AppThemes.flexThemes[index].flexScheme);
                      context.read<ThemeCubit>().changeFlexIndex(index);
                      Navigator.pop(context);
                    },
                    leading: Text("$index"),
                    selected: state.flexIndex == index,
                    selectedTileColor: Theme.of(context).focusColor,
                    title: Text(
                      AppThemes.flexThemes[index].title.toUpperCase(),
                      style: const TextStyle(
                        fontFamily: AppFonts.poppins,
                      ),
                    ),
                    trailing: CircleAvatar(
                      backgroundColor: state.isDarkMode
                          ? AppThemes.flexThemes[index].flexColor.dark.primary
                          : AppThemes.flexThemes[index].flexColor.light.primary,
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
