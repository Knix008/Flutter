import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show SynchronousFuture;

class CustomLocalizations {
  CustomLocalizations(this.locale);
  final Locale locale;

  static CustomLocalizations? of(BuildContext context) {
    return Localizations.of<CustomLocalizations>(context, CustomLocalizations);
  }

  static final Map<String, Map<String, String>> _resources = {
    'en': {'title': 'Demo', 'message': 'Hello World'},
    'es': {'title': 'Manifestación', 'message': 'Hola Mundo',},
  };
  String? get title {
    return _resources[locale.languageCode]!['title'];
  }

  String? get message {
    return _resources[locale.languageCode]!['message'];
  }
}

class CustomLocalizationsDelegate extends
LocalizationsDelegate<CustomLocalizations> {
  const CustomLocalizationsDelegate();
  @override
  bool isSupported(Locale locale) => ['en', 'es'].contains(locale.languageCode);
  @override
  Future<CustomLocalizations> load(Locale locale) {
    return SynchronousFuture<CustomLocalizations>(CustomLocalizations(locale));
  }
  @override bool shouldReload(CustomLocalizationsDelegate old) => false;
}