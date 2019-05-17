import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = MessageLookup();

final _keepAnalysisHappy = Intl.defaultLocale;

typedef MessageIfAbsent(String message_str, List args);

class MessageLookup extends MessageLookupByLibrary {
  get localeName => 'ru';

  final messages = _notInlinedMessages(_notInlinedMessages);
  static _notInlinedMessages(_) => {
    "currenciesTitle" : MessageLookupByLibrary.simpleMessage("Валюты"),
    "coursesTabTitle" : MessageLookupByLibrary.simpleMessage("Курсы"),
    "calculatorTabTitle" : MessageLookupByLibrary.simpleMessage("Калькулятор"),
    "statisticTabTitle" : MessageLookupByLibrary.simpleMessage("Статистика"),
    "errorAlertTitle" : MessageLookupByLibrary.simpleMessage("Ошибка!"),
    "errorAlertButtonClose" : MessageLookupByLibrary.simpleMessage("Закрыть"),
    "errorAlertText" : MessageLookupByLibrary.simpleMessage("Что-то пошло не так..."),
    "buyRadiobuttonTitle" : MessageLookupByLibrary.simpleMessage("Купить"),
    "sellRadiobuttonTitle" : MessageLookupByLibrary.simpleMessage("Продать"),
    "exceptionTitle" : MessageLookupByLibrary.simpleMessage("Исключение: "),
    "exceptionText" : MessageLookupByLibrary.simpleMessage("Ошибка получения данных [Статускод:"),
    "errorTitle" : MessageLookupByLibrary.simpleMessage("Ошибка:"),
    "uaLang" : MessageLookupByLibrary.simpleMessage("укр"),
    "enLang" : MessageLookupByLibrary.simpleMessage("анг"),
    "ruLang" : MessageLookupByLibrary.simpleMessage("рус")
  };
}