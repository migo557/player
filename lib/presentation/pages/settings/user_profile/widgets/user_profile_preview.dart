import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:open_player/base/assets/images/app_images.dart';
import 'package:velocity_x/velocity_x.dart';

class UserProfilePreview extends StatelessWidget {
  const UserProfilePreview({super.key, required this.file});
  final File? file;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        title: IconButton(
            onPressed: () {
              context.pop();
            },
            icon: Icon(CupertinoIcons.back)),
      ),
      body: VxZoom(
        twoTouchOnly: true,
        child: Center(
          child: file != null
              ? Image.file(file!)
              : Image.asset(AppImages.defaultProfile),
        ),
      ),
    );
  }
}
