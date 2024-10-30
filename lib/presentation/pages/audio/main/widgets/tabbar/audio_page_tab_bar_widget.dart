import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:open_player/logic/audio_page_tab_bar_cubit/audio_page_tab_bar_cubit.dart';
import '../../../../../../logic/audio_player_bloc/audio_player_bloc.dart';
import '../../../../../../logic/language_cubit/language_cubit.dart';

class AudioPageTabBarWidget extends StatelessWidget {
  const AudioPageTabBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final double mqHeight = MediaQuery.sizeOf(context).height;

    return BlocSelector<AudioPlayerBloc, AudioPlayerState,
        AudioPlayerSuccessState?>(
      selector: (state) {
        return state is AudioPlayerSuccessState ? state : null;
      },
      builder: (context, state) {
        return SliverAppBar(
          toolbarHeight: mqHeight * 0.067,
          automaticallyImplyLeading: false,
          pinned: true,
          primary: state != null ? false : true,
          actions: [
            Expanded(
              child: BlocSelector<LanguageCubit, LanguageState, String>(
                selector: (state) => state.languageCode,
                builder: (context, state) {
                  final String lanCode = state;

                  return TabBar(
                    onTap: (value) {
                      context
                          .read<AudioPageTabBarCubit>()
                          .changeIndex(tabIndex: value);
                    },
                    tabs: [
                      Tab(
                        text: _getTabText(
                            lanCode,
                            "Songs",
                            "گانے",
                            "गाने",
                            "أغاني",
                            "canciones",
                            "Chansons",
                            "Сборники",
                            "لعبات",
                            "歌曲"),
                        icon: const Icon(
                            HugeIcons.strokeRoundedMusicNoteSquare02),
                      ),
                      Tab(
                        text: _getTabText(
                            lanCode,
                            "Artists",
                            "فنکار",
                            "कलाकार",
                            "فنانون",
                            "Artistas",
                            "Artistes",
                            "Исполнители",
                            "예술가",
                            "艺术家"),
                        icon: const Icon(
                            HugeIcons.strokeRoundedMusicNoteSquare01),
                      ),
                      Tab(
                        text: _getTabText(
                            lanCode,
                            "Albums",
                            "البم",
                            "एल्बम",
                            "ألبومات",
                            "Álbumes",
                            "Albums",
                            "Альбомы",
                            "앨범",
                            "专辑"),
                        icon: const Icon(Icons.album),
                      ),
                      Tab(
                        text: _getTabText(
                            lanCode,
                            "Playlists",
                            "پلے لسٹ",
                            "प्लेलिस्ट",
                            "قوائم التشغيل",
                            "Listas de reproducción",
                            "Playlists",
                            "Плейлисты",
                            "재생 목록",
                            "播放列表"),
                        icon: const Icon(HugeIcons.strokeRoundedPlayList),
                      ),
                      Tab(
                        text: _getTabText(
                            lanCode,
                            "Folders",
                            "فولڈر",
                            "फोल्डर",
                            "مجلدات",
                            "Carpetas",
                            "Dossiers",
                            "Папки",
                            "폴더",
                            "文件夹"),
                        icon: const Icon(HugeIcons.strokeRoundedFolder01),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }

  String _getTabText(
    String langCode,
    String enText, // English
    String urText, // Urdu
    String hiText, // Hindi
    String arText, // Arabic
    String esText, // Spanish
    String frText, // French
    String ruText, // Russian
    String krText, // Korean
    String zhText, // Chinese
  ) {
    switch (langCode) {
      case 'ur':
        return urText;
      case 'hi':
        return hiText;
      case 'ar':
        return arText;
      case 'es':
        return esText;
      case 'fr':
        return frText;
      case 'ru':
        return ruText;
      case 'ko':
        return krText;
      case "zh":
        return zhText;
      default:
        return enText;
    }
  }
}
