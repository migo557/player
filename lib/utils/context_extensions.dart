

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../logic/language_cubit/language_cubit.dart';

extension LanguageCubitExtension on BuildContext {
  LanguageCubit get languageCubit => read<LanguageCubit>();
}
