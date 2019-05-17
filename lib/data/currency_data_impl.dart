import 'dart:async';
import 'dart:convert';
import 'package:flutter_currency/storage/database_helper.dart';
import 'package:flutter_currency/utils/Network.dart';
import 'package:flutter_currency/utils/Constants.dart';
import 'package:http/http.dart' as http;

import 'currency_data.dart';

class PrivatBankRepository implements CurrencyRepository {

  String _todayDate =
      "${(DateTime.now().day - 2).toString().padLeft(2, '0')}.${DateTime.now().month.toString().padLeft(2, '0')}.${DateTime.now().year.toString()}";
  final JsonDecoder _decoder = new JsonDecoder();
  final dbHelper = DatabaseHelper.instance;

  Future<List<CurrencyData>> fetch() async {
    final response = await http.get(Network.PRIVATBANK_API_PATH+_todayDate);
    final jsonBody = response.body;
    final statusCode = response.statusCode;

    if(statusCode < 200 || statusCode >= 300 || jsonBody == null) {
      throw new FetchDataException(Constants.EXCEPTION_TEXT+statusCode.toString()+ ", "+Constants.ERROR_TITLE+response.reasonPhrase+"]");
    }

    final contactsContainer = _decoder.convert(jsonBody);
    final List contactItems = contactsContainer['exchangeRate'];

    return deleteEmptyData(contactItems.map((contactRaw) => CurrencyData.fromMap(contactRaw))
        .toList());
  }

  List<CurrencyData> deleteEmptyData(List<CurrencyData> list) {
    list.removeWhere((currency) => (currency.purchaseRate == null));
    return list;
  }

  Future<List<CurrencyData>> getCurrenciesFromDB() async {
    final allRows = await dbHelper.queryAllTodayRows(_todayDate);
    return deleteEmptyData(allRows.map((row) => CurrencyData.fromRow(row)).toList());
  }

  Future saveCurrenciesToDB(List<CurrencyData> currencies) async {
      currencies.forEach((element) => insertCurrency(element));
  }

  void insertCurrency(CurrencyData element) async{
    Map<String, dynamic> row = {
      DatabaseHelper.columnName : element.shortName,
      DatabaseHelper.columnDate  : _todayDate,
      DatabaseHelper.columnSale  : element.saleRate,
      DatabaseHelper.columnPurchase  : element.purchaseRate
    };
    final id = await dbHelper.insert(row);
    print('inserted row id: $id');
  }


}
