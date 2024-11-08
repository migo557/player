import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:open_player/utils/app_menu.dart';

class SongTileMoreButtonWidget extends StatelessWidget {
  const SongTileMoreButtonWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (details) {
        Offset position = details.globalPosition;
        AppMenuHelper.showPopMenuAtPosition(
            context: context,
            position: position,
            items: [
              _musicAddToFavorite(),
              _renameMusic(),
              _deleteMusic(),
              _musicSetAsRingtone(),
              _more(),
            ]);
      },
      child: const Padding(
        padding: EdgeInsets.all(8.0),
        child: Icon(HugeIcons.strokeRoundedMoreVerticalCircle01),
      ),
    );
  }
}

//----------------------------------------------------//
///-----------------  Widgets  --------------------///
///-------------------------------------------------///

///--------------- A D D  T O  F A V O R I T E
PopupMenuItem<dynamic> _musicAddToFavorite() {
  return PopupMenuItem(
    onTap: () {},
    child: const ListTile(
      title: Text(
        "Add to Favorite",
      ),
      trailing: Icon(HugeIcons.strokeRoundedFavourite),
    ),
  );
}

///--------------- R E N A M E
PopupMenuItem<dynamic> _renameMusic() {
  return PopupMenuItem(
    onTap: () {},
    child: const ListTile(
      title: Text(
        "Rename",
      ),
      trailing: Icon(Icons.text_snippet),
    ),
  );
}

///--------------- D E L E T E
PopupMenuItem<dynamic> _deleteMusic() {
  return PopupMenuItem(
    onTap: () {},
    child: const ListTile(
      title: Text(
        "Delete",
      ),
      trailing: Icon(Icons.delete),
    ),
  );
}

///--------------- S E T  A S  R I N G T O N E
PopupMenuItem<dynamic> _musicSetAsRingtone() {
  return PopupMenuItem(
    onTap: () {},
    child: const ListTile(
      title: Text(
        "Set as ringtone",
      ),
      trailing: Icon(Icons.call),
    ),
  );
}

///--------------- Show More
PopupMenuItem<dynamic> _more() {
  return PopupMenuItem(
    onTap: () {},
    child: const ListTile(
      title: Text(
        "Show More",
      ),
      trailing: Icon(HugeIcons.strokeRoundedMore),
    ),
  );
}
