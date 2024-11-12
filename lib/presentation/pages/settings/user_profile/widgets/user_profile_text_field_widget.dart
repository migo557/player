import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:open_player/base/assets/fonts/styles.dart';
import 'package:open_player/logic/user_data/user_data_cubit.dart';
import 'package:open_player/logic/user_data/user_data_state.dart';

import '../../../../../base/db/hive_service.dart';

class UserProfileTextFieldWidget extends StatelessWidget {
  const UserProfileTextFieldWidget({
    super.key,
    required this.textEditingController,
  });

  final TextEditingController textEditingController;
  @override
  Widget build(BuildContext context) {
    bool isLogin =
        MyHiveBoxes.user.get(MyHiveKeys.userIsLoggedIn, defaultValue: false);
    final Size mq = MediaQuery.sizeOf(context);
    return Card(
      color: Colors.white.withOpacity(0.02),
      shadowColor: Colors.black38,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Container(
        width: mq.width * 0.85,
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.1),
            borderRadius: BorderRadius.circular(10)),
        child: BlocBuilder<UserDataCubit, UserDataState>(
          builder: (context, userState) {
            return TextField(
              controller: textEditingController,
              style: const TextStyle(
                color: Colors.white,
              ),
              onTapOutside: (_) {
                FocusManager.instance.primaryFocus!.unfocus();
              },
              decoration: InputDecoration(
                  prefixIcon: const Icon(
                    HugeIcons.strokeRoundedUser,
                    color: Colors.white,
                  ),
                  hintStyle: const TextStyle(
                      color: Colors.white24, fontFamily: AppFonts.poppins),
                  border: InputBorder.none,
                  hintText: isLogin ? userState.username : "Enter your name"),
            );
          },
        ),
      ),
    );
  }
}
