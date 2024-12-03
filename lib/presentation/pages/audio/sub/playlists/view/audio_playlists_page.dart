import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:open_player/base/assets/images/app_images.dart';
import 'package:velocity_x/velocity_x.dart';

class PlaylistsPage extends StatelessWidget {
  const PlaylistsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      floatingActionButton: const PlaylistFloatingButton(),
      body: CustomScrollView(
        slivers: [
          // Playlist Items
          SliverList.separated(
            itemCount: 10,
            itemBuilder: (context, index) => PlaylistTile(
              title: "Playlist $index",
              trackCount: "${index + 3} tracks",
              imageAsset: AppImages.defaultProfile,
            ),
            separatorBuilder: (context, index) => const Divider(
              height: 1,
              color: Colors.grey,
              indent: 80,
            ),
          ),
        ],
      ),
    );
  }
}

class PlaylistTile extends StatelessWidget {
  final String title;
  final String trackCount;
  final String imageAsset;

  const PlaylistTile({
    super.key,
    required this.title,
    required this.trackCount,
    required this.imageAsset,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      leading: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          image: DecorationImage(
            image: AssetImage(imageAsset),
            fit: BoxFit.cover,
          ),
        ),
      ),
      title: Text(
        title,
        style: const TextStyle(
            color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),
      ),
      subtitle: Text(
        trackCount,
        style: TextStyle(color: Colors.grey.shade500, fontSize: 14),
      ),
      trailing: IconButton(
        icon: Icon(HugeIcons.strokeRoundedCodeCircle,
            color: Colors.grey.shade500),
        onPressed: () {
          // TODO: Implement more options
        },
      ),
    );
  }
}

class PlaylistFloatingButton extends StatelessWidget {
  const PlaylistFloatingButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        // TODO: Implement create new playlist functionality
      },
      child: Icon(
        HugeIcons.strokeRoundedPlayListAdd,
      ),
    ).pOnly(bottom: 100, right: 10);
  }
}





