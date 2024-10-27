import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:open_player/base/assets/fonts/app_fonts.dart';
import 'package:open_player/base/assets/images/app-images.dart';
import 'package:open_player/logic/audio_player_bloc/audio_player_bloc.dart';
import 'package:open_player/logic/now_playing_media_cubit/now_playing_media_cubit.dart';

import '../../../../../../base/router/app_routes.dart';
import '../../../../../../logic/audio_bloc/audios_bloc.dart';
import '../../../../../../logic/theme_cubit/theme_cubit.dart';
import '../../../../../../logic/theme_cubit/theme_state.dart';

class SongsPage extends StatelessWidget {
  const SongsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, themeState) {
        return BlocBuilder<AudiosBloc, AudiosState>(
          builder: (context, audioState) {
            if (audioState is AudiosSuccess) {
              int songsLength = audioState.songs.length;

              return SliverList.builder(
                itemCount: songsLength,
                addAutomaticKeepAlives: true,
                itemBuilder: (context, index) {
                  String songTitle = audioState.songs[index].title;
                  final pathList = audioState.songs
                      .map(
                        (e) => e.path,
                      )
                      .toList();
                  return GestureDetector(
                    onTap: () {
                      context
                          .read<AudioPlayerBloc>()
                          .add(AudioPlayerInitializeEvent(pathList: pathList,initialMediaIndex: index));
                      context.read<NowPlayingMediaCubit>().init(audioList: audioState.songs);
                      context.push(AppRoutes.audioPlayerRoute,);
                    },
                    child: Card(
                      color: themeState.isDarkMode
                          ? Theme.of(context).colorScheme.onPrimaryContainer
                          : Theme.of(context).colorScheme.onPrimaryContainer,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      child: Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10)),
                        child: Row(
                          children: [
                            //------ Profile Image -----//
                            Card(
                              child: Container(
                                width: 70,
                                height: 70,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  image: const DecorationImage(
                                    image: AssetImage(
                                      AppImages.defaultProfile,
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                            const Gap(10),

                            ///------------ Title & Artists -----------///
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  //---Title
                                  Text(
                                    songTitle,
                                    maxLines: 1,
                                    overflow: TextOverflow.clip,
                                    style: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500),
                                  ),

                                  //----Artist
                                  Text(
                                    "Artists $index",
                                    overflow: TextOverflow.clip,
                                    style: const TextStyle(
                                        fontSize: 11,
                                        fontFamily: AppFonts.poppins,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey),
                                  ),
                                ],
                              ),
                            ),

                            // const Spacer(),

                            //-------- More Button
                            IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                  HugeIcons.strokeRoundedMoreVerticalCircle01),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            } else if (audioState is AudiosLoading) {
              return const SliverToBoxAdapter(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            } else if (audioState is AudiosFailure) {
              return SliverToBoxAdapter(
                child: Center(
                  child: Text(audioState.message),
                ),
              );
            } else if (audioState is AudiosInitial) {
              return const SliverToBoxAdapter(
                child: Center(
                  child: Text("Initializing ..."),
                ),
              );
            } else {
              return const SliverToBoxAdapter(
                child: Center(
                  child: Text("Something went wrong"),
                ),
              );
            }
          },
        );
      },
    );
  }
}
