import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:open_player/logic/audio_page_tab_bar_cubit/audio_page_tab_bar_cubit.dart';
import '../../../../../../logic/language_cubit/language_cubit.dart';

class AudioPageTabBarWidget extends StatelessWidget {
  const AudioPageTabBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final double mqHeight = MediaQuery.of(context).size.height;

    return SliverAppBar(
      toolbarHeight: mqHeight * 0.062,
      pinned: true,
      actions: [
        Expanded(
          child: BlocBuilder<LanguageCubit, LanguageState>(
            builder: (context, lanState) {
              final String lanCode = lanState.languageCode;

              return TabBar(
              
                onTap: (value) {
                  context
                      .read<AudioPageTabBarCubit>()
                      .changeIndex(tabIndex: value);
                },
                tabs: [
                  Tab(
                    text: _getTabText(lanCode, "Songs", "گانے", "गाने", "أغاني",
                        " canciones", "Chansons", "Сборники", "لعبات"),
                    icon: const Icon(HugeIcons.strokeRoundedMusicNoteSquare02),
                  ),
                  Tab(
                    text: _getTabText(lanCode, "Artists", "فنکار", "कलाकार",
                        "فنانون", "Artistas", "Artistes", "Исполнители", "예술가"),
                    icon: const Icon(HugeIcons.strokeRoundedMusicNoteSquare01),
                  ),
                  Tab(
                    text: _getTabText(lanCode, "Albums", "البم", "एल्बम",
                        "ألبومات", "Álbumes", "Albums", "Альбомы", "앨범"),
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
                        "재생 목록"),
                    icon: const Icon(HugeIcons.strokeRoundedPlayList),
                  ),
                  Tab(
                    text: _getTabText(lanCode, "Folders", "فولڈر", "फोल्डर",
                        "مجلدات", "Carpetas", "Dossiers", "Папки", "폴더"),
                    icon: const Icon(HugeIcons.strokeRoundedFolder01),
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }

  String _getTabText(
      String langCode,
      String enText,
      String urText,
      String hiText,
      String arText,
      String esText,
      String frText,
      String ruText,
      String krText) {
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
      default:
        return enText;
    }
  }
}
