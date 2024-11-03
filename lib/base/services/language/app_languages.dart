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
      "name": "Burmese",
      "language": "ဗမာ",
      "code": "my",
      "flag": _svgFlag("mm")
    },
    {
      "name": "Czech",
      "language": "Čeština",
      "code": "cs",
      "flag": _svgFlag("cz")
    },
    {
      "name": "Chinese (Mandarin)",
      "language": "中文",
      "code": "zh",
      "flag": _svgFlag("cn")
    },
    {
      "name": "Danish",
      "language": "Dansk",
      "code": "da",
      "flag": _svgFlag("dk")
    },
    {
      "name": "Dutch",
      "language": "Nederlands",
      "code": "nl",
      "flag": _svgFlag("nl")
    },
    {
      "name": "Filipino",
      "language": "Filipino",
      "code": "fil",
      "flag": _svgFlag("ph")
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
      "name": "Greek",
      "language": "Ελληνικά",
      "code": "el",
      "flag": _svgFlag("gr")
    },
    {
      "name": "Gujarati",
      "language": "ગુજરાતી",
      "code": "gu",
      "flag": _svgFlag("in")
    },
    {
      "name": "Hausa",
      "language": "Hausa",
      "code": "ha",
      "flag": _svgFlag("ng")
    },
    {
      "name": "Hebrew",
      "language": "עברית",
      "code": "he",
      "flag": _svgFlag("il")
    },
    {
      "name": "Hungarian",
      "language": "Magyar",
      "code": "hu",
      "flag": _svgFlag("hu")
    },
    {
      "name": "Indonesian",
      "language": "Bahasa Indonesia",
      "code": "id",
      "flag": _svgFlag("id")
    },
    {
      "name": "Persian",
      "language": "فارسی",
      "code": "fa",
      "flag": _svgFlag("ir")
    },
    {
      "name": "Polish",
      "language": "Polski",
      "code": "pl",
      "flag": _svgFlag("pl")
    },
    {
      "name": "Portuguese (PT)",
      "language": "Português",
      "code": "pt",
      "flag": _svgFlag("pt")
    },
    {
      "name": "Punjabi",
      "language": "ਪੰਜਾਬੀ",
      "code": "pa",
      "flag": _svgFlag("pk")
    },
    {
      "name": "Italian",
      "language": "Italiano",
      "code": "it",
      "flag": _svgFlag("it")
    },
    {
      "name": "Japanese",
      "language": "日本語",
      "code": "ja",
      "flag": _svgFlag("jp")
    },
    {"name": "Korean", "language": "한국어", "code": "ko", "flag": _svgFlag("kr")},
    {
      "name": "Malay",
      "language": "Bahasa Melayu",
      "code": "ms",
      "flag": _svgFlag("my")
    },
    {
      "name": "Norwegian",
      "language": "Norsk",
      "code": "no",
      "flag": _svgFlag("no")
    },
    {
      "name": "Russian",
      "language": "Русский",
      "code": "ru",
      "flag": _svgFlag("ru")
    },
    {
      "name": "Romanian",
      "language": "Română",
      "code": "ro",
      "flag": _svgFlag("ro")
    },
    {
      "name": "Sinhala",
      "language": "සිංහල",
      "code": "si",
      "flag": _svgFlag("lk")
    },
    {
      "name": "Spanish",
      "language": "Español",
      "code": "es",
      "flag": _svgFlag("es")
    },
    {
      "name": "Swahili",
      "language": "Kiswahili",
      "code": "sw",
      "flag": _svgFlag("ke")
    },
    {
      "name": "Swedish",
      "language": "Svenska",
      "code": "sv",
      "flag": _svgFlag("se")
    },
    {
      "name": "Tamil",
      "language": "தமிழ்",
      "code": "ta",
      "flag": _svgFlag("in")
    },
    {
      "name": "Telugu",
      "language": "తెలుగు",
      "code": "te",
      "flag": _svgFlag("in")
    },
    {"name": "Thai", "language": "ไทย", "code": "th", "flag": _svgFlag("th")},
    {
      "name": "Turkish",
      "language": "Türkçe",
      "code": "tr",
      "flag": _svgFlag("tr")
    },
    {
      "name": "Ukrainian",
      "language": "Українська",
      "code": "uk",
      "flag": _svgFlag("ua")
    },
    {
      "name": "Vietnamese",
      "language": "Tiếng Việt",
      "code": "vi",
      "flag": _svgFlag("vn")
    },
    {
      "name": "Finnish",
      "language": "Suomi",
      "code": "fi",
      "flag": _svgFlag("fi")
    },
    {
      "name": "Malayalam",
      "language": "മലയാളം",
      "code": "ml",
      "flag": _svgFlag("in")
    },
    {
      "name": "Slovak",
      "language": "Slovenčina",
      "code": "sk",
      "flag": _svgFlag("sk")
    },
    {
      "name": "Catalan",
      "language": "Català",
      "code": "ca",
      "flag": _svgFlag("es")
    },
    {
      "name": "Serbian",
      "language": "Српски",
      "code": "sr",
      "flag": _svgFlag("rs")
    },
    {
      "name": "Croatian",
      "language": "Hrvatski",
      "code": "hr",
      "flag": _svgFlag("hr")
    },
    {
      "name": "Lithuanian",
      "language": "Lietuvių",
      "code": "lt",
      "flag": _svgFlag("lt")
    },
    {
      "name": "Slovenian",
      "language": "Slovenščina",
      "code": "sl",
      "flag": _svgFlag("si")
    },
    {
      "name": "Icelandic",
      "language": "Íslenska",
      "code": "is",
      "flag": _svgFlag("is")
    },
    {
      "name": "Basque",
      "language": "Euskara",
      "code": "eu",
      "flag": _svgFlag("es")
    },
    {
      "name": "Galician",
      "language": "Galego",
      "code": "gl",
      "flag": _svgFlag("es")
    },
    {
      "name": "Macedonian",
      "language": "Македонски",
      "code": "mk",
      "flag": _svgFlag("mk")
    },
    {
      "name": "Nepali",
      "language": "नेपाली",
      "code": "ne",
      "flag": _svgFlag("np")
    },
    {
      "name": "Khmer",
      "language": "ភាសាខ្មែរ",
      "code": "km",
      "flag": _svgFlag("kh")
    },
    {
      "name": "Amharic",
      "language": "አማርኛ",
      "code": "am",
      "flag": _svgFlag("et")
    },
    {
      "name": "Yoruba",
      "language": "Yorùbá",
      "code": "yo",
      "flag": _svgFlag("ng")
    },
    {
      "name": "Tajik",
      "language": "Тоҷикӣ",
      "code": "tg",
      "flag": _svgFlag("tj")
    },
    {
      "name": "Hmong",
      "language": "Hmoob",
      "code": "hmn",
      "flag": _svgFlag("la")
    },
    {
      "name": "Fijian",
      "language": "Na Vosa Vakaviti",
      "code": "fj",
      "flag": _svgFlag("fj")
    },
    {
      "name": "Sundanese",
      "language": "Basa Sunda",
      "code": "su",
      "flag": _svgFlag("id")
    },
    {
      "name": "Tatar",
      "language": "Татарча",
      "code": "tt",
      "flag": _svgFlag("ru")
    },
    {
      "name": "Mongolian",
      "language": "Монгол хэл",
      "code": "mn",
      "flag": _svgFlag("mn")
    },
    {
      "name": "Maltese",
      "language": "Malti",
      "code": "mt",
      "flag": _svgFlag("mt")
    },
    {
      "name": "Malagasy",
      "language": "Malagasy",
      "code": "mg",
      "flag": _svgFlag("mg")
    },
    {
      "name": "Wolof",
      "language": "Wolof",
      "code": "wo",
      "flag": _svgFlag("sn")
    },
    {
      "name": "Quechua",
      "language": "Runa Simi",
      "code": "qu",
      "flag": _svgFlag("pe")
    },
    {
      "name": "Xhosa",
      "language": "isiXhosa",
      "code": "xh",
      "flag": _svgFlag("za")
    },
    {
      "name": "Zulu",
      "language": "isiZulu",
      "code": "zu",
      "flag": _svgFlag("za")
    },
    {
      "name": "Armenian",
      "language": "Հայերեն",
      "code": "hy",
      "flag": _svgFlag("am")
    },
    {
      "name": "Bashkir",
      "language": "Башкир теле",
      "code": "ba",
      "flag": _svgFlag("ru")
    },
    {
      "name": "Breton",
      "language": "Brezhoneg",
      "code": "br",
      "flag": _svgFlag("fr")
    },
    {
      "name": "Sami",
      "language": "Sámegiella",
      "code": "se",
      "flag": _svgFlag("no")
    },
    {"name": "Twi", "language": "Twi", "code": "tw", "flag": _svgFlag("gh")},
    {
      "name": "Corsican",
      "language": "Corsu",
      "code": "co",
      "flag": _svgFlag("fr")
    },
    {
      "name": "Scottish Gaelic",
      "language": "Gàidhlig",
      "code": "gd",
      "flag": _svgFlag("gb")
    },
  ];

  static SvgPicture _svgFlag(String countryCode) => SvgPicture.asset(
      height: 20, width: 30, "assets/svgs/flags/$countryCode.svg");
}
