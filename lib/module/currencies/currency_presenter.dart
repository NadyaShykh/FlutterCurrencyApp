import 'package:flutter_currency/storage/database_helper.dart';

import '../../data/currency_data.dart';
import '../../injection/dependency_injection.dart';

abstract class CurrencyListViewContract {
  void onLoadCurrenciesComplete(List<CurrencyData> items);
  void onLoadCurrenciesError();
}

class CurrencyListPresenter {
  CurrencyListViewContract _view;
  CurrencyRepository _repository;
  final dbHelper = DatabaseHelper.instance;
  String _todayDate = "${(DateTime.now().day-2).toString().padLeft(2,'0')}.${DateTime.now().month.toString().padLeft(2,'0')}.${DateTime.now().year.toString()}";

  CurrencyListPresenter(this._view){
    _repository = Injector().contactRepository;
  }

  void loadCurrencies(){
    assert(_view != null);

    _repository.fetch()
        .then((currencies) => _view.onLoadCurrenciesComplete(currencies))
        .catchError((onError) {
      print(onError);
      _view.onLoadCurrenciesError();
    });
  }

  Future saveCurrenciesToDB(List<CurrencyData> currencies) async {
    final allRows = await dbHelper.queryAllTodayRows(_todayDate);
    if (allRows.toList().length==0) {
      currencies.forEach((element) => insertCurrency(element));
    }
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

