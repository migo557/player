import 'package:flutter/material.dart';
import 'package:open_player/base/assets/images/app-images.dart';

class SongsPage extends StatelessWidget {
  const SongsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverList.builder(
      itemCount: _dummyList.length,
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListTile(
          visualDensity: VisualDensity.comfortable,
          leading: const CircleAvatar(
            backgroundImage: AssetImage(AppImages.defaultProfile),
          ),
          title: Text(_dummyList[index]["title"]),
          subtitle: Text(_dummyList[index]["artist"]),
          trailing:
              IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert)),
        ),
      ),
    );
  }
}

///--------- Dummy List -----------///
List<Map> _dummyList = const [
  {"title": "Aaj Bhi", "artist": "Vishal Mishra"},
  {"title": "Aaj Bhi 2", "artist": "Vishal Mishra"},
  {"title": "Aaj Ki Raat", "artist": "Madhubanti Bagchi"},
  {"title": "Alone", "artist": "Alan Walker"},
  {"title": "Bematlab", "artist": "Asim Azhar, Talha Anjum"},
  {"title": "Blue", "artist": "Billie Eilish"},
  {"title": "Crazy", "artist": "Daniela Andrade"},
  {"title": "Faded", "artist": "Alan Walker"},
  {"title": "In The End", "artist": "Jung Youth"},
  {"title": "Lily", "artist": "Emelie Hollow"},
  {"title": "Manjha", "artist": "Vishal Mishra"},
  {"title": "Shayad", "artist": "Arijit Singh"},
  {"title": "Video Games", "artist": "Lana Del Rey"},
  {"title": "Aaj Bhi", "artist": "Vishal Mishra"},
  {"title": "Aaj Bhi 2", "artist": "Vishal Mishra"},
  {"title": "Aaj Ki Raat", "artist": "Madhubanti Bagchi"},
  {"title": "Alone", "artist": "Alan Walker"},
  {"title": "Bematlab", "artist": "Asim Azhar, Talha Anjum"},
  {"title": "Blue", "artist": "Billie Eilish"},
  {"title": "Crazy", "artist": "Daniela Andrade"},
  {"title": "Faded", "artist": "Alan Walker"},
  {"title": "In The End", "artist": "Jung Youth"},
  {"title": "Lily", "artist": "Emelie Hollow"},
  {"title": "Manjha", "artist": "Vishal Mishra"},
  {"title": "Shayad", "artist": "Arijit Singh"},
  {"title": "Video Games", "artist": "Lana Del Rey"},
];
