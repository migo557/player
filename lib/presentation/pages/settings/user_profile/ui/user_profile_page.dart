import 'package:color_log/color_log.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:open_player/base/assets/fonts/app_fonts.dart';
import 'package:open_player/presentation/pages/settings/user_profile/widgets/user_profile_background_blur_image_widget.dart';
import 'package:open_player/presentation/pages/settings/user_profile/widgets/user_profile_circle_avatar_widget.dart';
import 'package:open_player/presentation/pages/settings/user_profile/widgets/user_profile_text_field_widget.dart';
import '../../../../../logic/user_data/user_data_cubit.dart';

class UserProfilePage extends StatefulWidget {
  const UserProfilePage({super.key});

  @override
  State<UserProfilePage> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  late TextEditingController usernameController;
  XFile? tempImage;

  @override
  void initState() {
    usernameController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    usernameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size mq = MediaQuery.sizeOf(context);
    return Scaffold(
      body: Stack(
        children: [
          //---------- Background Image -----------///
          const UserProfileBackgroundBlurImageWidget(),

          Align(
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                //-------- Circular  Profile Avatar --------------///
                UserProfileCircleAvatarWidget(
                  tempImage: tempImage,
                  //-------- Change Image Button Clicked ------------//
                  changeButtonOnPressed: () async {
                       clog.debug("Change Profile Picture Button is clicked!");
                    final imagePicker = ImagePicker();

                    XFile? pickedImage = await imagePicker.pickImage(
                        source: ImageSource.gallery);

                    tempImage = pickedImage;
                    setState(() {});
                  },
                ),
                const Gap(40),
                //-------- Text Field --------------///
                UserProfileTextFieldWidget(
                  textEditingController: usernameController,
                ),
                const Gap(10),
                //-------------------- Save Button-------------------///
                ElevatedButton(
                  onPressed: () {
                    clog.debug("Save Profile Button is clicked!");
                    context
                        .read<UserDataCubit>()
                        .updateProfilePicture(tempImage?.path);
                    context
                        .read<UserDataCubit>()
                        .updateUsername(usernameController.text);
                    context.pop();
                  },
                  style: ElevatedButton.styleFrom(
                      fixedSize: Size(
                    mq.width * 0.95,
                    45,
                  )),
                  child: const Text(
                    "Save",
                    style: TextStyle(
                      fontFamily: AppFonts.poppins,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),

          //-------------- BackButton ------------///
          Positioned(
            left: mq.width * 0.05,
            top: mq.height * 0.02,
            child: SafeArea(
              child: CircleAvatar(
                child: IconButton(
                  onPressed: () {
                    GoRouter.of(context).pop();
                  },
                  icon: const Icon(
                    CupertinoIcons.back,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
  //-------- Change Image Button Clicked ------------//
  // _changeImgButtonClicked() async {
  //   final imagePicker = ImagePicker();

  //   XFile? pickedImage =
  //       await imagePicker.pickImage(source: ImageSource.gallery);

  //   tempImage = pickedImage;
  //   setState(() {});
  // }

  //-------- Save Button Clicked ------------//
  // _saveButtonClicked() {
  //   context.read<UserDataCubit>().updateProfilePicture(tempImage?.path);
  //   context.read<UserDataCubit>().updateUsername(usernameController.text);
  //   context.pop();
  // }
}
