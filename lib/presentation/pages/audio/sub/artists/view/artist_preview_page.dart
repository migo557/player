import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:open_player/base/assets/fonts/styles.dart';
import 'package:open_player/data/models/artist_model.dart';
import 'package:open_player/logic/audio_bloc/audios_bloc.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../../../../base/assets/images/app_images.dart';
import '../../../../../common/widgets/custom_back_button.dart';
import '../../../../../common/widgets/audio_tile_widget.dart';

class ArtistPreviewPage extends StatelessWidget {
  const ArtistPreviewPage(
      {super.key, required this.artist, required this.state});

  final ArtistModel artist;
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
              artist: artist,
              scaffoldColor: scaffoldColor,
              textColor: textColor),

          //------------- Music List ------///
          SliverList.builder(
            addAutomaticKeepAlives: true,
            itemCount: artist.songCount,
            itemBuilder: (context, index) {
              return AudioTileWidget(
                audios: artist.songs,
                index: index,
                state: state,
              );
            },
          ),

          //-------- Bottom Space -----//
          SliverPadding(
            padding: EdgeInsets.only(bottom: 200),
          ),
        ],
      ),
    );
  }
}

//------------ AppBar --------------//
class _AppBar extends StatelessWidget {
  const _AppBar({
    required this.artist,
    required this.scaffoldColor,
    required this.textColor,
  });

  final ArtistModel artist;
  final Color scaffoldColor;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Colors.transparent,
      expandedHeight: 300,
      floating: true,
      flexibleSpace: Container(
        height: 300,
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: artist.picture != null
                  ? FileImage(
                      File(artist.picture!.file.path),
                    )
                  : AssetImage(AppImages.defaultProfile),
              fit: BoxFit.cover),
        ),
        child: [
          //------------- Album Background ----------//
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
                  scaffoldColor.withOpacity(0.6),
                  scaffoldColor.withOpacity(0.1),
                ],
              )),
            ),
          ),

          ///--------- Album Thumbnail & Title Row ----------///

          [
            Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                image: DecorationImage(
                  image: artist.picture != null
                      ? FileImage(
                          File(artist.picture!.file.path),
                        )
                      : AssetImage(AppImages.defaultProfile),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Gap(20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                artist.name.text.xl3
                    .color(textColor)
                    .fontFamily(AppFonts.poppins)
                    .fontWeight(FontWeight.w500)
                    .make(),
                "${artist.songCount} songs"
                    .text
                    .color(textColor.withOpacity(0.5))
                    .make()
              ],
            ).centered()
          ].row().p12().positioned(bottom: 50),

          //-------- Back Button
          CustomBackButton().safeArea(),
        ].stack(),
      ),
    );
  }
}
