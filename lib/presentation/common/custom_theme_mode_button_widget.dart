import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../logic/audio_player_bloc/audio_player_bloc.dart';
import '../../logic/theme_cubit/theme_cubit.dart';
import '../../logic/theme_cubit/theme_state.dart';
import 'nothing_widget.dart';

class CustomThemeModeButtonWidget extends StatelessWidget {
  const CustomThemeModeButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.sizeOf(context);

    return BlocBuilder<AudioPlayerBloc, AudioPlayerState>(
      builder: (context, playerState) {
        return BlocSelector<ThemeCubit, ThemeState, bool>(
          selector: (state) => state.isDarkMode,
          builder: (context, isDark) {
            if (playerState is AudioPlayerSuccessState) return nothing;

            return SizedBox(
              width: mq.width * 0.18,
              height: mq.height * 0.045,
              child: GestureDetector(
                onTap: () => context.read<ThemeCubit>().toggleThemeMode(),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeInOut,
                  padding: EdgeInsets.all(3),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    gradient: isDark
                        ? LinearGradient(
                            colors: [Colors.grey[850]!, Colors.grey[900]!],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          )
                        : LinearGradient(
                            colors: [
                              Colors.blue[300]!,
                              Colors.purple[200]!,
                              Colors.pink[200]!,
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                    boxShadow: [
                      BoxShadow(
                        color: isDark
                            ? Colors.black.withOpacity(0.3)
                            : Colors.blue[300]!.withOpacity(0.5),
                        blurRadius: 8,
                        spreadRadius: 1,
                      ),
                      if (!isDark)
                        BoxShadow(
                          color: Colors.pink[200]!.withOpacity(0.3),
                          blurRadius: 12,
                          spreadRadius: 2,
                          offset: Offset(4, 4),
                        ),
                    ],
                  ),
                  child: Stack(
                    children: [
                      // Background elements for dark mode (stars)
                      ...List.generate(
                        5,
                        (index) => AnimatedPositioned(
                          duration: Duration(milliseconds: 500),
                          left: isDark ? index * 10.0 + 5 : -50,
                          top: index * 5.0 + 2,
                          child: AnimatedOpacity(
                            duration: Duration(milliseconds: 500),
                            opacity: isDark ? 0.7 : 0,
                            child: Icon(
                              Icons.star,
                              size: 8,
                              color: Colors.yellow[100],
                            ),
                          ),
                        ),
                      ),

                      // Background elements for light mode (clouds and sparkles)
                      ...List.generate(
                        3,
                        (index) => AnimatedPositioned(
                          duration: Duration(milliseconds: 500),
                          left: !isDark ? index * 15.0 + 5 : -50,
                          top: index * 7.0 + 2,
                          child: AnimatedOpacity(
                            duration: Duration(milliseconds: 500),
                            opacity: !isDark ? 0.9 : 0,
                            child: Icon(
                              Icons.cloud,
                              size: 12,
                              color: Colors.white.withOpacity(0.8),
                            ),
                          ),
                        ),
                      ),

                      // Sparkles for light mode
                      ...List.generate(
                        4,
                        (index) => AnimatedPositioned(
                          duration: Duration(milliseconds: 500),
                          left: !isDark ? index * 12.0 : -50,
                          top: (index % 2) * 15.0,
                          child: AnimatedOpacity(
                            duration: Duration(milliseconds: 500),
                            opacity: !isDark ? 0.8 : 0,
                            child: TweenAnimationBuilder(
                              tween: Tween<double>(begin: 0, end: 1),
                              duration: Duration(milliseconds: 1500),
                              builder: (context, double value, child) {
                                return Transform.rotate(
                                  angle: value * 2 * 3.14,
                                  child: Icon(
                                    Icons.auto_awesome,
                                    size: 10,
                                    color: Colors.yellow[100],
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ),

                      // Sliding toggle
                      AnimatedAlign(
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeInOut,
                        alignment: isDark
                            ? Alignment.centerRight
                            : Alignment.centerLeft,
                        child: Container(
                          width: mq.height * 0.035,
                          height: mq.height * 0.035,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: isDark
                                ? LinearGradient(
                                    colors: [
                                      Colors.grey[900]!,
                                      Colors.grey[800]!
                                    ],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  )
                                : LinearGradient(
                                    colors: [
                                      Colors.orange[300]!,
                                      Colors.yellow[400]!
                                    ],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  ),
                            boxShadow: [
                              BoxShadow(
                                color: isDark
                                    ? Colors.black38
                                    : Colors.orange.withOpacity(0.3),
                                blurRadius: 4,
                                spreadRadius: 1,
                              ),
                              if (!isDark)
                                BoxShadow(
                                  color: Colors.yellow[200]!.withOpacity(0.5),
                                  blurRadius: 8,
                                  spreadRadius: 2,
                                  offset: Offset(2, 2),
                                ),
                            ],
                          ),
                          child: AnimatedRotation(
                            duration: const Duration(milliseconds: 500),
                            turns: isDark ? 0.5 : 0,
                            child: Icon(
                              isDark ? Icons.dark_mode : Icons.wb_sunny_rounded,
                              color: isDark
                                  ? Colors.grey[300]
                                  : Colors.orange[800],
                              size: 16,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
