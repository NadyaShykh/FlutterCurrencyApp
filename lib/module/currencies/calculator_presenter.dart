import 'package:flutter_currency/data/currency_data.dart';
import 'package:flutter_currency/injection/dependency_injection.dart';
import 'package:flutter_currency/module/currencies/currency_presenter.dart';
import 'package:flutter_currency/storage/database_helper.dart';

class CalculatorPresenter {
  CurrencyListViewContract _view;
  CurrencyRepository _repository;
  final dbHelper = DatabaseHelper.instance;

  String _todayDate = "${(DateTime.now().day-2).toString().padLeft(2,'0')}.${DateTime.now().month.toString().padLeft(2,'0')}.${DateTime.now().year.toString()}";

  CalculatorPresenter(this._view) {
    _repository = Injector().contactRepository;
  }

  Future loadCurrencies() async {
    assert(_view != null);

    final allRows = await dbHelper.queryAllTodayRows(_todayDate);
    if (allRows.toList().length != 0) {
      _view.onLoadCurrenciesComplete(allRows.map((row)=> CurrencyData.fromRow(row)).toList());
    } else {
      _repository.fetch()
          .then((currencies) => _view.onLoadCurrenciesComplete(currencies))
          .catchError((onError) {
        print(onError);
        _view.onLoadCurrenciesError();
      });
    }
  }

}