import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:open_player/base/services/language/app_languages.dart';
import 'package:open_player/base/router/app_routes.dart';
import 'package:open_player/logic/greeting/greeting_cubit.dart';
import 'package:open_player/logic/language_cubit/language_cubit.dart';

class LanguagePage extends StatelessWidget {
  const LanguagePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              context.go(AppRoutes.initialRoute);
            },
            icon: const Icon(CupertinoIcons.back)),
        title: const Text("Select Language"),
      ),
      body: BlocBuilder<LanguageCubit, LanguageState>(
        builder: (context, state) {
          return ListView.separated(
              itemBuilder: (context, index) {
                final languageName =
                    AppLanguages.supportedLanguages[index]["name"].toString();
                final languageCode = AppLanguages.supportedLanguages[index]
                        ["code"]
                    .toString()
                    .toLowerCase();

                final SvgPicture countryFlag =
                    AppLanguages.supportedLanguages[index]["flag"];

                final currentLanguageCode = languageCode == state.languageCode;
                return ListTile(
                  onTap: () {
                    context.read<LanguageCubit>().changeLanguage(languageCode);
                    context
                        .read<GreetingCubit>()
                        .updateGreeting(languageCode: languageCode);

                    log(languageCode);
                    GoRouter.of(context).pop();
                  },
                  leading: countryFlag,
                  title: Text(
                    languageName,
                    style: TextStyle(
                        fontWeight: currentLanguageCode
                            ? FontWeight.w500
                            : FontWeight.normal),
                  ),
                  trailing: currentLanguageCode
                      ? const Icon(HugeIcons.strokeRoundedTick01)
                      : null,
                );
              },
              separatorBuilder: (context, index) => const Divider(),
              itemCount: AppLanguages.supportedLanguages.length);
        },
      ),
    );
  }
}
