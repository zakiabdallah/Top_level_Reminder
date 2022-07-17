import 'package:flutter/cupertino.dart';
import 'package:tlr/l10n/L10n.dart';

class LocaleProvider with ChangeNotifier {
  Locale? _locale;
  Locale? get locale => _locale;

  void setLocale(Locale locale) {
    if (!L10n.all_locale.contains(locale)) return;
    _locale = locale;
    notifyListeners();
  }
}
