import 'dart:async';

import 'currency_data.dart';

class MockCurrencyRepository implements CurrencyRepository {

  Future<List<CurrencyData>> fetch() {
    return Future.value(kCurrencies);
  }

}

const kCurrencies = <CurrencyData>[
  CurrencyData(
      shortName: 'CHF',
      saleRate: 28.5000000,
      purchaseRate: 26.8000000
  ),
  CurrencyData(
      shortName: 'RUB',
      saleRate: 0.4250000,
      purchaseRate: 0.3920000
  ),
  CurrencyData(
      shortName: 'GBP',
      saleRate: 36.6000000,
      purchaseRate: 34.6000000
  ),
  CurrencyData(
      shortName: 'USD',
      saleRate: 28.3500000,
      purchaseRate: 28.0000000
  ),
  CurrencyData(
      shortName: 'EUR',
      saleRate: 32.3000000,
      purchaseRate: 31.7000000
  ),
  CurrencyData(
      shortName: 'PLZ',
      saleRate: 7.5500000,
      purchaseRate: 7.1000000
  )
];
