import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:open_player/base/db/hive/hive.dart';
import '../language_cubit/language_cubit.dart';

part 'greeting_state.dart';

/// A [Cubit] that manages the application's greeting state.
///
/// This cubit updates the greeting based on the current time of day
/// and adapts the greeting based on the selected language from
/// [LanguageCubit].
class GreetingCubit extends Cubit<GreetingState> {
  late LanguageCubit languageCubit; // Holds a reference to LanguageCubit

  /// Creates a [GreetingCubit] with the specified [languageCubit].
  GreetingCubit({required this.languageCubit})
      : super(GreetingState.initial()) {
    updateGreeting(
        languageCode: MyHiveBoxes.languageBox.get(MyHiveKeys.defaultLanguage) ??
            "Hello!"); // Initialize the greeting when the cubit is created
  }

  /// Updates the greeting based on the current time of day.
  void updateGreeting({required String languageCode}) {
    final hour = DateTime.now().hour; // Get the current hour
    String greeting;

    // Determine the appropriate greeting based on the current hour
    if (hour < 12) {
      greeting = _getLocalizedGreeting(
          languageCode: languageCode,
          "Good Morning",
          "Bonjour",
          "صباح الخير",
          "صبح بخیر",
          "गुड मॉर्निंग",
          "Buenos Días",
          "早上好",
          "سهار مو پخير", // Pashto
          "Доброе утро", // Russian
          "좋은 아침입니다"); // Korean
    } else if (hour < 17) {
      greeting = _getLocalizedGreeting(
          languageCode: languageCode,
          "Good Afternoon",
          "Bon Après-midi",
          "مساء الخير",
          "دوپہر بخیر",
          "गुड आफ्टरनून",
          "Buenas Tardes",
          "下午好",
          "مازیګر مو پخير", // Pashto
          "Добрый день", // Russian
          "좋은 오후입니다"); // Korean
    } else if (hour < 21) {
      greeting = _getLocalizedGreeting(
          languageCode: languageCode,
          "Good Evening",
          "Bonsoir",
          "مساء الخير",
          "شام بخیر",
          "गुड ईवनिंग",
          "Buenas Noches",
          "晚上好",
          "ماښام مو پخير", // Pashto
          "Добрый вечер", // Russian
          "좋은 저녁입니다"); // Korean
    } else {
      greeting = _getLocalizedGreeting(
          languageCode: languageCode,
          "Good Night",
          "Bonne Nuit",
          "تصبح على خير",
          "شب بخیر",
          "शुभ रात्रि",
          "Buenas Noches",
          "晚安",
          "شپه مو پخير", // Pashto
          "Спокойной ночи", // Russian
          "안녕하세요"); // Korean
    }

    emit(state.copyWith(greeting: greeting)); // Emit the new greeting state
  }

  /// Returns a localized greeting based on the provided greetings for different times.
  String _getLocalizedGreeting(String en, String fr, String ar, String ur,
      String hi, String es, String zh, String ps, String ru, String kr,
      {required String languageCode}) {
    // Customize the greeting based on the current language
    switch (languageCode) {
      case 'fr':
        return fr; // French greeting
      case 'ar':
        return ar; // Arabic greeting
      case 'ur':
        return ur; // Urdu greeting
      case 'hi':
        return hi; // Hindi greeting
      case 'es':
        return es; // Spanish greeting
      case 'zh':
        return zh; // Chinese greeting
      case 'ps':
        return ps; // Pashto greeting
      case 'ru':
        return ru; // Russian greeting
      case 'ko':
        return kr; // Korean greeting
      default:
        return en; // Default greeting in English
    }
  }
}
