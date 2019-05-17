import 'dart:async';

import 'package:flutter_currency/utils/Constants.dart';

import 'currency_data.dart';

class MockCurrencyRepository implements CurrencyRepository {

  Future<List<CurrencyData>> fetch() {
    return Future.value(kCurrencies);
  }

  @override
  Future<List<CurrencyData>> getCurrenciesFromDB() {
    return Future.value(kCurrencies);
  }

  @override
  Future saveCurrenciesToDB(List<CurrencyData> currencies) {
    // TODO: implement saveCurrenciesToDB
    return null;
  }

}

const kCurrencies = <CurrencyData>[
  CurrencyData(
      shortName: Constants.USD_CURRENCY,
      saleRate: 28.3500000,
      purchaseRate: 28.0000000
  ),
];
