import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = MessageLookup();

final _keepAnalysisHappy = Intl.defaultLocale;

typedef MessageIfAbsent(String message_str, List args);

class MessageLookup extends MessageLookupByLibrary {
  get localeName => 'en';

  final messages = _notInlinedMessages(_notInlinedMessages);
  static _notInlinedMessages(_) => {
    "currenciesTitle" : MessageLookupByLibrary.simpleMessage("Currencies"),
    "coursesTabTitle" : MessageLookupByLibrary.simpleMessage("Cources"),
    "calculatorTabTitle" : MessageLookupByLibrary.simpleMessage("Calculator"),
    "statisticTabTitle" : MessageLookupByLibrary.simpleMessage("Statistic"),
    "errorAlertTitle" : MessageLookupByLibrary.simpleMessage("Error!"),
    "errorAlertButtonClose" : MessageLookupByLibrary.simpleMessage("Close"),
    "errorAlertText" : MessageLookupByLibrary.simpleMessage("Something went wrong..."),
    "buyRadiobuttonTitle" : MessageLookupByLibrary.simpleMessage("Buy"),
    "sellRadiobuttonTitle" : MessageLookupByLibrary.simpleMessage("Sell"),
    "exceptionTitle" : MessageLookupByLibrary.simpleMessage("Exception: "),
    "exceptionText" : MessageLookupByLibrary.simpleMessage("Error while getting data [StatusCode:"),
    "errorTitle" : MessageLookupByLibrary.simpleMessage("Error:"),
    "uaLang" : MessageLookupByLibrary.simpleMessage("UA"),
    "enLang" : MessageLookupByLibrary.simpleMessage("EN"),
    "ruLang" : MessageLookupByLibrary.simpleMessage("RU")
  };
}