import 'package:flutter_currency/storage/database_helper.dart';

import '../../data/currency_data.dart';
import '../../injection/dependency_injection.dart';

abstract class CurrencyListViewContract {
  void onLoadCurrenciesComplete(List<CurrencyData> items);
  void onLoadCurrenciesError(onError);
}

class CurrencyListPresenter {
  CurrencyListViewContract _view;
  CurrencyRepository _repository;
  final dbHelper = DatabaseHelper.instance;

  CurrencyListPresenter(this._view){
    _repository = Injector().contactRepository;
  }

  Future loadCurrencies() async {
    assert(_view != null);
    _repository.getCurrenciesFromDB().then((currencies) => checkAvaliableData(currencies));
  }

  void checkAvaliableData(List<CurrencyData> currencies) {
    if (currencies.length != 0) {
      _view.onLoadCurrenciesComplete(currencies);

    } else {
      _repository
          .fetch()
          .then((currencies) => saveCurrenciesToDB(currencies))
          .catchError((onError) {
        print(onError);
        _view.onLoadCurrenciesError(onError);
      });
    }
  }

  void saveCurrenciesToDB(List<CurrencyData> currencies) {
    _repository.saveCurrenciesToDB(currencies);
    _view.onLoadCurrenciesComplete(currencies);
  }

}

