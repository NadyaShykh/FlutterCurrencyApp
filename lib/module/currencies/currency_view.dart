import 'package:flutter/material.dart';
import 'package:flutter_currency/utils/Constants.dart';
import 'package:flutter_currency/utils/Network.dart';
import 'package:flutter_currency/localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
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
        title: Text(Constants.CURRENCIES_TITLE),
      ),
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped, // new
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
            icon: new Icon(Icons.call_missed),
            title: new Text(Constants.COURSES_TAB_TITLE),
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.apps),
            title: new Text(Constants.CALCULATOR_TAB_TITLE),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.assessment),
            title: Text(Constants.STATISTIC_TAB_TITLE),
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
      _currencies = items;
      _isSearching = false;
    });
  }

  @override
  void onLoadCurrenciesError(onError) {
    _isSearching=false;
    setState(() {
    });
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text(Constants.ERROR_ALERT_TITLE),
          content: new Text(Constants.ERROR_ALERT_TEXT),
          actions: <Widget>[
            new FlatButton(
              child: new Text(Constants.ERROR_ALERT_BUTTON_CLOSE),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
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
      if (_currencies==null) {
        widget = new Container();
      } else {
        widget = ListView(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            children: _buildCurrencyList());
      }
    }
    return widget;
  }

  List<_CurrencyListItem> _buildCurrencyList() {
    return _currencies.map((currency) => _CurrencyListItem(currency)).toList();
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
                Text(currency.purchaseRate.toString() + " " + Constants.UAH_CURRENCY,
                    style: TextStyle(color: Colors.red)),
                Text(currency.saleRate.toString() + " " +Constants.UAH_CURRENCY,
                    style: TextStyle(color: Colors.green)),
              ],
            ),
            leading: ClipRRect(
              borderRadius: new BorderRadius.circular(8.0),
              child: Image.network(
                Network.IMAGE_FLAG_PATH_START +
                    currency.shortName.substring(0, 2) +
                    Network.IMAGE_FLAG_PATH_END,
                height: 100.0,
                width: 60.0,
              ),
            ));
}

// локалізація