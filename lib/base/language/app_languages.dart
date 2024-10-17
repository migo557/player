import 'package:flutter_svg/svg.dart';

class AppLanguages {
  static List<Map<String, dynamic>> supportedLanguages = [
    {
      "name": "English (US)",
      "language": "English",
      "code": "en",
      "flag":
          SvgPicture.asset(height: 20, width: 30, "assets/svgs/flags/us.svg"),
    },
    {
      "name": "Urdu (PK)",
      "language": "اردو",
      "code": "ur",
      "flag":
          SvgPicture.asset(height: 20, width: 30, "assets/svgs/flags/pk.svg"),
    },
    {
      "name": "Hindi",
      "language": "हिन्दी",
      "code": "hi",
      "flag":
          SvgPicture.asset(height: 20, width: 30, "assets/svgs/flags/in.svg"),
    },
    {
      "name": "Arabic",
      "language": "العربية",
      "code": "ar",
      "flag":
          SvgPicture.asset(height: 20, width: 30, "assets/svgs/flags/arab.svg"),
    },
    {
      "name": "French",
      "language": "Français",
      "code": "fr",
      "flag":
          SvgPicture.asset(height: 20, width: 30, "assets/svgs/flags/fr.svg"),
    },
    {
      "name": "Spanish",
      "language": "Español",
      "code": "es",
      "flag":
          SvgPicture.asset(height: 20, width: 30, "assets/svgs/flags/es.svg"),
    },
    {
      "name": "Chinese",
      "language": "中文",
      "code": "zh",
      "flag":
          SvgPicture.asset(height: 20, width: 30, "assets/svgs/flags/cn.svg"),
    },
    {
      "name": "Pashto",
      "language": "پښتو",
      "code": "ps",
      "flag":
          SvgPicture.asset(height: 20, width: 30, "assets/svgs/flags/af.svg"),
    },
    {
      "name": "Russian",
      "language": "Русский",
      "code": "ru",
      "flag":
          SvgPicture.asset(height: 20, width: 30, "assets/svgs/flags/ru.svg"),
    },
    {
      "name": "Korean",
      "language": "한국어",
      "code": "ko",
      "flag":
          SvgPicture.asset(height: 20, width: 30, "assets/svgs/flags/kr.svg"),
    },
  ];
}
