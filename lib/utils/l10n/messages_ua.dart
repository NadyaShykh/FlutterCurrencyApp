import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = MessageLookup();

final _keepAnalysisHappy = Intl.defaultLocale;

typedef MessageIfAbsent(String message_str, List args);

class MessageLookup extends MessageLookupByLibrary {
  get localeName => 'ua';

  final messages = _notInlinedMessages(_notInlinedMessages);
  static _notInlinedMessages(_) => {
    "currenciesTitle" : MessageLookupByLibrary.simpleMessage("Валюти"),
    "coursesTabTitle" : MessageLookupByLibrary.simpleMessage("Курси"),
    "calculatorTabTitle" : MessageLookupByLibrary.simpleMessage("Калькулятор"),
    "statisticTabTitle" : MessageLookupByLibrary.simpleMessage("Статистика"),
    "errorAlertTitle" : MessageLookupByLibrary.simpleMessage("Помилка!"),
    "errorAlertButtonClose" : MessageLookupByLibrary.simpleMessage("Закрити"),
    "errorAlertText" : MessageLookupByLibrary.simpleMessage("Щось пішло не так..."),
    "buyRadiobuttonTitle" : MessageLookupByLibrary.simpleMessage("Купити"),
    "sellRadiobuttonTitle" : MessageLookupByLibrary.simpleMessage("Продати"),
    "exceptionTitle" : MessageLookupByLibrary.simpleMessage("Виняток: "),
    "exceptionText" : MessageLookupByLibrary.simpleMessage("Помилка отримання даних [Статускод:"),
    "errorTitle" : MessageLookupByLibrary.simpleMessage("Помилка:"),
    "uaLang" : MessageLookupByLibrary.simpleMessage("укр"),
    "enLang" : MessageLookupByLibrary.simpleMessage("анг"),
    "ruLang" : MessageLookupByLibrary.simpleMessage("рос")
  };
}