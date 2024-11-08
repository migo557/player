import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../logic/language_cubit/language_cubit.dart';

/// A widget that displays localized text based on the current language state.
///
/// The [Texty] widget takes localized strings for various languages through a map,
/// allowing easy switching between them in your app. It uses the [LanguageCubit] to
/// determine the current language and displays the appropriate translation. If a
/// translation for the current language is not provided, it defaults to English.
///
/// Example usage:
/// ```dart
/// Texty(
///   en: 'Hello',
///   translations: {
///     'fr': 'Bonjour',
///     'ur': 'ہیلو',
///   },
/// )
/// ```
class Texty extends StatelessWidget {
  final String en; // Required English text
  final Map<String, String>?
      translations; // Map for translations in various languages

  final TextStyle? style; // Optional text style
  final int? maxLines;
  final TextOverflow? textOverflow;
  final TextAlign? textAlign;
  final Color? selectionColor;
  final bool? softWrap;

  const Texty({
    super.key,
    required this.en,
     this.translations,
    this.style,
    this.maxLines,
    this.textAlign,
    this.textOverflow,
    this.selectionColor,
    this.softWrap,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LanguageCubit, LanguageState>(
      builder: (context, state) {
        // Get the translated text or fall back to English if not found
        String text = translations?[state.languageCode] ?? en;

        // Return the Text widget with the selected string and optional styling
        return Text(
          text,
          maxLines: maxLines,
          overflow: textOverflow,
          textAlign: textAlign,
          selectionColor: selectionColor,
          softWrap: softWrap,
          style: style,
        );
      },
    );
  }
}
