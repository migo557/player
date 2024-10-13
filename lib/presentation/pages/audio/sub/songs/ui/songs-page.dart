import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:open_player/base/assets/fonts/app-fonts.dart';
import 'package:open_player/base/assets/images/app-images.dart';

class SongsPage extends StatelessWidget {
  const SongsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Size mq = MediaQuery.sizeOf(context);
    return SliverList.builder(
      itemCount: _dummyList.length,
      itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: SizedBox(
            height: mq.height * 0.076,
            width: mq.width,
            child: Row(
              children: [
                //----- Music Icon
                const CircleAvatar(
                  backgroundImage: AssetImage(AppImages.defaultProfile),
                  radius: 25,
                ),
                const Gap(10),

                ///-------- Music Bubble
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      // color: Colors.blue,
                      boxShadow: const [
                        BoxShadow(
                            blurRadius: 1,
                            spreadRadius: 2,
                            blurStyle: BlurStyle.outer)
                      ],
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Stack(
                      children: [
                        //------------ Music Cover
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              image: const DecorationImage(
                                  fit: BoxFit.cover,
                                  image: AssetImage(AppImages.defaultProfile),
                                  opacity: 0.25)),
                        ),

                        //---------- Music Data
                        Row(
                          children: [
                            const Gap(20),

                            ///--------- Music Title & Artist
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(_dummyList[index]["title"], style:  const TextStyle(
                                  fontFamily: AppFonts.poppins,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16
                                ),),
                                Text(_dummyList[index]["artist"],
                              style:  const TextStyle(
                                fontSize: 11,
                                ),),
                              ],
                            ),
                            const Spacer(),

                            ///--------- More Icon Button
                            IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.more_vert),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )),
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
