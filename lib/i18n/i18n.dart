import "package:i18n_extension/i18n_extension.dart";
extension Localization on String {
  String get i18n => localize(this, t);
  static var t = Translations("en_us") +
      {
        "en_us": "Hello, how are you?",
        "ar_ar": "Olá, como vai você?",
      } +
      {
        "en_us": "Hello",
        "ar_ar": "Olá",
      } +
      {
        "en_us": "Goodbye",
        "ar_ar": "Adeus",
      };
}