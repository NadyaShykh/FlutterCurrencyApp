import 'package:flutter/material.dart';
import 'package:flutter_currency/utils/l10n/messages_all.dart';
import 'dart:async';
import 'package:intl/intl.dart';

class AppLocalizations {

    static Future<AppLocalizations> load(Locale locale) {
      final String name =
      locale.countryCode==null||locale.countryCode.isEmpty ? locale.languageCode : locale.toString();
      final String localeName = Intl.canonicalizedLocale(name);

      return initializeMessages(localeName).then((_) {
        Intl.defaultLocale = localeName;
        return AppLocalizations();
      });
  }

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  currenciesTitle() => Intl.message(
    'Currencies',
    name: "currenciesTitle",
    desc: "The application title",
  );

  coursesTabTitle() => Intl.message(
    'Cources',
    name: "coursesTabTitle",
  );

  calculatorTabTitle() => Intl.message(
    'Calculator',
    name: "calculatorTabTitle",
  );

  statisticTabTitle() => Intl.message(
    'Statistic',
    name: "statisticTabTitle",
  );

  errorAlertTitle() => Intl.message(
    'Error!',
    name: "errorAlertTitle",
  );

  errorAlertButtonClose() => Intl.message(
    'Close',
    name: "errorAlertButtonClose",
  );

  errorAlertText() => Intl.message(
    'Something went wrong...',
    name: "errorAlertText",
  );

  buyRadiobuttonTitle() => Intl.message(
    'Buy',
    name: "buyRadiobuttonTitle",
  );

  sellRadiobuttonTitle() => Intl.message(
    'Sell',
    name: "sellRadiobuttonTitle",
  );

  exceptionTitle() => Intl.message(
    'Exception: ',
    name: "exceptionTitle",
  );

  exceptionText() => Intl.message(
    'Error while getting data [StatusCode:',
    name: "exceptionText",
  );

  errorTitle() => Intl.message(
    'Error:',
    name: "errorTitle",
  );

  uaLang() => Intl.message(
    'UA',
    name: "uaLang",
  );

  enLang() => Intl.message(
    'EN',
    name: "enLang",
  );

  ruLang() => Intl.message(
    'RU',
    name: "ruLang",
  );
}

class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => ['en', 'ru', 'ua'].contains(locale.languageCode);

  @override
  Future<AppLocalizations> load(Locale locale) => AppLocalizations.load(locale);

  @override
  bool shouldReload(AppLocalizationsDelegate old) => false;
}