import 'package:flutter_currency/data/currency_data.dart';
import 'package:flutter_currency/injection/dependency_injection.dart';
import 'package:flutter_currency/module/currencies/currency_presenter.dart';

class CalculatorPresenter {
  CurrencyListViewContract _view;
  CurrencyRepository _repository;

  CalculatorPresenter(this._view) {
    _repository = Injector().contactRepository;
  }

  void loadCurrencies() {
    assert(_view != null);
    _repository.getCurrenciesFromDB().then((currencies) => checkAvaliableData(currencies));
  }

  void checkAvaliableData(List<CurrencyData> currencies) {
    if (currencies.length != 0) {
      _view.onLoadCurrenciesComplete(currencies);
    } else {
      _repository
          .fetch()
          .then((currencies) => _view.onLoadCurrenciesComplete(currencies))
          .catchError((onError) {
        print(onError);
        _view.onLoadCurrenciesError(onError);
      });
    }
  }
}
