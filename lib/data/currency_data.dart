import 'dart:async';
import 'package:flutter_currency/utils/Constants.dart';

class CurrencyData {
  final String shortName;
  final double saleRate;
  final double purchaseRate;

  const CurrencyData({this.shortName, this.saleRate, this.purchaseRate});

  CurrencyData.fromMap(Map<String, dynamic>  map) :
        shortName = map['currency'],
        saleRate = map['saleRate'],
        purchaseRate = map['purchaseRate'];

  CurrencyData.fromRow(Map<String, dynamic>  map) :
        shortName = map['name'],
        saleRate = map['sale'],
        purchaseRate = map['purchase'];

}

abstract class CurrencyRepository {
  Future<List<CurrencyData>> fetch();
  Future<List<CurrencyData>> getCurrenciesFromDB();
  Future saveCurrenciesToDB(List<CurrencyData> currencies);
}

class FetchDataException implements Exception {
  String _message;

  FetchDataException(this._message);

  String toString() {
    return Constants.EXCEPTION_TITLE + _message;
  }
}
