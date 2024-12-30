import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:open_player/base/assets/fonts/styles.dart';
import 'package:open_player/base/assets/images/app_images.dart';
import 'package:open_player/data/models/album_model.dart';
import 'package:open_player/logic/audio_bloc/audios_bloc.dart';
import 'package:open_player/presentation/common/widgets/custom_back_button.dart';
import 'package:open_player/utils/extensions.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../../settings/user_profile/widgets/user_profile_preview.dart';
import '../../../../../common/widgets/audio_tile_widget.dart';

class AlbumPreviewPage extends StatelessWidget {
  const AlbumPreviewPage({super.key, required this.album, required this.state});
  final AlbumModel album;
  final AudiosSuccess state;
  @override
  Widget build(BuildContext context) {
    final scaffoldColor = Theme.of(context).scaffoldBackgroundColor;
    final textColor = Theme.of(context).brightness == Brightness.light
        ? Colors.black
        : Colors.white;
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _AppBar(
              album: album, scaffoldColor: scaffoldColor, textColor: textColor),

          //------------- Music List ------///
          SliverList.builder(
            addAutomaticKeepAlives: true,
            itemCount: album.songCount,
            itemBuilder: (context, index) {
              return AudioTileWidget(
                audios: album.songs,
                index: index,
                state: state,
              );
            },
          ),
        ],
      ),
    );
  }
}

//---------- APPBAR --------------//
class _AppBar extends StatelessWidget {
  const _AppBar({
    required this.album,
    required this.scaffoldColor,
    required this.textColor,
  });

  final AlbumModel album;
  final Color scaffoldColor;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = context.themeCubit.state.isDarkMode;

    return SliverAppBar(
      backgroundColor: Colors.transparent,
      automaticallyImplyLeading: false,
      expandedHeight: 300,
      floating: true,
      //------------- Album Background ----------//
      flexibleSpace: Container(
        height: 300,
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: album.thumbnail.isNotEmpty
                  ? MemoryImage(
                      album.thumbnail,
                    )
                  : AssetImage(AppImages.defaultProfile),
              fit: BoxFit.cover),
        ),
        child: [
          //------------- Bottom Gradient ----------//
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 300,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [
                  scaffoldColor,
                  scaffoldColor.withValues(alpha: 0.3),
                  scaffoldColor.withValues(alpha: 0.1),
                ],
              )),
            ),
          ),

          ///--------- Album Thumbnail & Title Row ----------///
          Align(
                  alignment: Alignment.bottomLeft,
                  child: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => UserProfilePreview(
                              bytes: album.thumbnail,
                            ),
                          ),
                        );
                      },
                      child: Container(
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          image: DecorationImage(
                            image: album.thumbnail.isNotEmpty
                                ? MemoryImage(
                                    album.thumbnail,
                                  )
                                : AssetImage(AppImages.defaultProfile),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    Gap(20),
                    [
                      //------ Album Name
                      album.name.text.xl3
                          .color(textColor)
                          .fontFamily(AppFonts.poppins)
                          .fontWeight(FontWeight.w500)
                          .make()
                          .scrollHorizontal(),

                      //-------- Artist Name
                      album.artist.text
                          .color(isDarkMode ? Colors.white60 : Colors.black54)
                          .make()
                          .pSymmetric(h: 12, v: 4)
                          .glassMorphic(
                              border: Border.all(
                                color: Colors.black26,
                              ),
                              circularRadius: 12),

                      Gap(3),

                      //----- Songs Length
                      "${album.songCount} songs"
                          .text
                          .color(Theme.of(context).primaryColor)
                          .make()
                          .pSymmetric(h: 12, v: 2)
                          .glassMorphic(
                              border: Border.all(color: Colors.black12))
                    ].column(
                      crossAlignment: CrossAxisAlignment.start,
                      alignment: MainAxisAlignment.center,
                      axisSize: MainAxisSize.min,
                    )
                  ]
                      .row(
                          crossAlignment: CrossAxisAlignment.center,
                          alignment: MainAxisAlignment.start,
                          axisSize: MainAxisSize.min)
                      .scrollHorizontal())
              .pOnly(bottom: 50, left: 12, right: 12),

          //-------- Back Button
          CustomBackButton().safeArea(),
        ].stack(),
      ),
    );
  }
}
