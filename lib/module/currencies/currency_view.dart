import 'package:flutter/material.dart';
import '../../data/currency_data.dart';
import 'currency_presenter.dart';
import 'calculator_view.dart';
import 'statistic_view.dart';

class CurrencyPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _CurrencyPageState();
  }
}

class _CurrencyPageState extends State<CurrencyPage> {

  int _currentIndex = 0;
  final List<Widget> _children = [
    CurrencyList(),
    CalculatorPage(),
    StatisticPage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Currencies"),
      ),
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped, // new
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
            icon: new Icon(Icons.call_missed),
            title: new Text('Cources'),
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.apps),
            title: new Text('Calculator'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.assessment),
            title: Text('Statistic'),
          )
        ],
      ),
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}

class CurrencyList extends StatefulWidget {
  CurrencyList({Key key}) : super(key: key);

  @override
  _CurrencyListState createState() => _CurrencyListState();
}

class _CurrencyListState extends State<CurrencyList>
    implements CurrencyListViewContract {
  CurrencyListPresenter _presenter;

  List<CurrencyData> _currencies;

  bool _isSearching;

  _CurrencyListState() {
    _presenter = CurrencyListPresenter(this);
  }

  @override
  void initState() {
    super.initState();
    _isSearching = true;
    _presenter.loadCurrencies();
  }

  @override
  void onLoadCurrenciesComplete(List<CurrencyData> items) {
    setState(() {
      _currencies = deleteEmptyData(items.sublist(3));
      _presenter.saveCurrenciesToDB(_currencies);
      _isSearching = false;
    });
  }

  @override
  void onLoadCurrenciesError() {
    // TODO: implement onLoadCurrenciesError
  }

  @override
  Widget build(BuildContext context) {
    var widget;

    if (_isSearching) {
      widget = Center(
          child: Padding(
              padding: EdgeInsets.only(left: 16.0, right: 16.0),
              child: CircularProgressIndicator()));
    } else {
      widget = ListView(
          padding: EdgeInsets.symmetric(vertical: 8.0),
          children: _buildCurrencyList());
    }

    return widget;
  }

  List<_CurrencyListItem> _buildCurrencyList() {
    return _currencies.map((currency) => _CurrencyListItem(currency)).toList();
  }

  List<CurrencyData> deleteEmptyData(List<CurrencyData> list) {
    list.removeWhere((currency) => (currency.purchaseRate == null));
    return list;
  }
}

///
///  List Item
///

class _CurrencyListItem extends ListTile {
  _CurrencyListItem(CurrencyData currency)
      : super(
      title: Text(currency.shortName,
          style: TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(currency.purchaseRate.toString() + " UAH",
              style: TextStyle(color: Colors.red)),
          Text(currency.saleRate.toString() + " UAH",
              style: TextStyle(color: Colors.green)),
        ],
      ),
      leading: ClipRRect(
        borderRadius: new BorderRadius.circular(8.0),
        child: Image.network(
          'https://countryflags.io/' +
              currency.shortName.substring(0, 2) +
              '/shiny/64.png',
          height: 100.0,
          width: 60.0,
        ),
      ));
}

