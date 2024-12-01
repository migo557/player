import 'package:flutter_svg/svg.dart';

class AppLanguages {
  static List<Map<String, dynamic>> supportedLanguages = [
    {
      "name": "English (US)",
      "language": "English",
      "code": "en",
      "flag": _svgFlag("us")
    },
    {
      "name": "Urdu (PK)",
      "language": "اردو",
      "code": "ur",
      "flag": _svgFlag("pk")
    },
    {
      "name": "Hindi",
      "language": "हिन्दी",
      "code": "hi",
      "flag": _svgFlag("in")
    },
    {
      "name": "Pashto",
      "language": "پښتو",
      "code": "ps",
      "flag": _svgFlag("af")
    },
    {
      "name": "Arabic",
      "language": "العربية",
      "code": "ar",
      "flag": _svgFlag("arab")
    },
    {
      "name": "Bengali",
      "language": "বাংলা",
      "code": "bn",
      "flag": _svgFlag("bd")
    },
    {
      "name": "Chinese (Mandarin)",
      "language": "中文",
      "code": "zh",
      "flag": _svgFlag("cn")
    },
    {
      "name": "French",
      "language": "Français",
      "code": "fr",
      "flag": _svgFlag("fr")
    },
    {
      "name": "German",
      "language": "Deutsch",
      "code": "de",
      "flag": _svgFlag("de")
    },
    {
      "name": "Japanese",
      "language": "日本語",
      "code": "ja",
      "flag": _svgFlag("jp")
    },
    {"name": "Korean", "language": "한국어", "code": "ko", "flag": _svgFlag("kr")},
    {
      "name": "Russian",
      "language": "Русский",
      "code": "ru",
      "flag": _svgFlag("ru")
    },
    {
      "name": "Spanish",
      "language": "Español",
      "code": "es",
      "flag": _svgFlag("es")
    },
    {
      "name": "Turkish",
      "language": "Türkçe",
      "code": "tr",
      "flag": _svgFlag("tr")
    },
  ];

  static SvgPicture _svgFlag(String countryCode) => SvgPicture.asset(
      height: 20, width: 30, "assets/svgs/flags/$countryCode.svg");
}
