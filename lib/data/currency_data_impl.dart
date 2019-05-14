import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'currency_data.dart';

class PrivatBankRepository implements CurrencyRepository {

  String _kPrivatBankUrl = 'https://api.privatbank.ua/p24api/exchange_rates?json&date='
      +"${(DateTime.now().day-2).toString().padLeft(2,'0')}.${DateTime.now().month.toString().padLeft(2,'0')}.${DateTime.now().year.toString()}";
  final JsonDecoder _decoder = new JsonDecoder();
  Future<List<CurrencyData>> fetch() async {
    final response = await http.get(_kPrivatBankUrl);
    final jsonBody = response.body;
    final statusCode = response.statusCode;

    if(statusCode < 200 || statusCode >= 300 || jsonBody == null) {
      throw new FetchDataException("Error while getting contacts [StatusCode:$statusCode, Error:${response.reasonPhrase}]");
    }

    final contactsContainer = _decoder.convert(jsonBody);
    final List contactItems = contactsContainer['exchangeRate'];

    return contactItems.map( (contactRaw) => CurrencyData.fromMap(contactRaw) )
        .toList();
  }
}
