import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../logic/language_cubit/language_cubit.dart';

/// A widget that displays localized text based on the current language state.
///
/// The [Texty] widget takes localized strings for English, French, Urdu, Arabic, Hindi,
/// Spanish, and Chinese, allowing easy switching between languages in your app. It uses the
/// [LanguageCubit] to determine the current language and displays the appropriate translation.
/// If a translation for the current language is not provided, it defaults to English.
///
/// Example usage:
/// ```dart
/// Texty(
///   en: 'Hello',
///   fr: 'Bonjour',
///   ur: 'ہیلو',
/// )
/// ```
class Texty extends StatelessWidget {
  /// The text to display in English.
  final String en;

  /// The optional text to display in French. Defaults to [en] if null.
  final String? fr;

  /// The optional text to display in Urdu. Defaults to [en] if null.
  final String? ur;

  /// The optional text to display in Arabic. Defaults to [en] if null.
  final String? ar;

  /// The optional text to display in Hindi. Defaults to [en] if null.
  final String? hi;

  /// The optional text to display in Spanish. Defaults to [en] if null.
  final String? es;

  /// The optional text to display in Chinese. Defaults to [en] if null.
  final String? zh;

  final String? ps;

  final String? ru;

  final String? kr;



  /// The optional [TextStyle] to apply to the text.
  final TextStyle? style;

  final int? maxLines;

  final TextOverflow? textOverflow;

  final TextAlign? textAlign;

  final Color? selectionColor;

  final bool? softWrap;

  const Texty({
    super.key,
    required this.en, // Required English text
    this.fr, // Optional French text
    this.ur, // Optional Urdu text
    this.ar, // Optional Arabic text
    this.hi, // Optional Hindi text
    this.es, // Optional Spanish text
    this.zh, // Optional Chinese text
    this.ps,
    this.ru,
    this.kr,
    this.style, // Optional text style
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
        String text;

        // Determine the current language and select the appropriate text.
        switch (state.languageCode) {
          case 'fr':
            text = fr ??
                en; // Use French text if available, otherwise fallback to English
            break;
          case 'ur':
            text = ur ??
                en; // Use Urdu text if available, otherwise fallback to English
            break;
          case 'ar':
            text = ar ??
                en; // Use Arabic text if available, otherwise fallback to English
            break;
          case 'hi':
            text = hi ??
                en; // Use Hindi text if available, otherwise fallback to English
            break;
          case 'es':
            text = es ??
                en; // Use Spanish text if available, otherwise fallback to English
            break;
          case 'zh':
            text = zh ??
                en; // Use Chinese text if available, otherwise fallback to English

                 case 'ps':
            text = ps ??
                en; // Use Pashto text if available, otherwise fallback to English

                 case 'ru':
            text = ru ??
                en; // Use Russian text if available, otherwise fallback to English

                 case 'ko':
            text = kr ??
                en; // Use Korean text if available, otherwise fallback to English
            break;
          default:
            text = en; // Default to English if no match
            break;
        }

        // Return the Text widget with the selected string and optional styling
        return Text(
          text,
          maxLines: maxLines,
          overflow: textOverflow,
          textAlign: textAlign,
          selectionColor: selectionColor,
          softWrap: softWrap,
          style: style, // Apply the textStyle if provided
        );
      },
    );
  }
}
