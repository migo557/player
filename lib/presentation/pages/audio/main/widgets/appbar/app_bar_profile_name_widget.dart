import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_player/base/theme/app_textstyles.dart';

import '../../../../../../logic/user_data/user_data_cubit.dart';
import '../../../../../../logic/user_data/user_data_state.dart';

class AppBarProfileNameWidget extends StatelessWidget {
  const AppBarProfileNameWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserDataCubit, UserDataState>(
      builder: (context, state) {
        return Text(
          state.username,
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
          style: AppTextStyles.profileName1,
        );
      },
    );
  }
}
