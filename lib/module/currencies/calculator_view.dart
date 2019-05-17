import 'package:flutter/material.dart';
import 'package:flutter_currency/data/currency_data.dart';
import 'package:flutter_currency/utils/Constants.dart';
import 'package:flutter_currency/utils/Network.dart';
import 'calculator_presenter.dart';
import 'currency_presenter.dart';

class CalculatorPage extends StatefulWidget {
  CalculatorPage({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _CalculatorPageState();
  }
}

class _CalculatorPageState extends State<CalculatorPage>
    implements CurrencyListViewContract {
  int _radioValue = 0;
  CalculatorPresenter _presenter;
  List<CurrencyData> _currencies;
  bool _isSearching;
  String _dropdownValue;
  TextEditingController _controller = TextEditingController(text: '');
  String _txt = '';
  double _currentPrice = 0.0;

  _CalculatorPageState() {
    _presenter = CalculatorPresenter(this);
  }

  @override
  void initState() {
    super.initState();
    _isSearching = true;
    _presenter.loadCurrencies();
    _dropdownValue = Constants.USD_CURRENCY;
    _controller.addListener(onChange);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void onLoadCurrenciesComplete(List<CurrencyData> items) {
    setState(() {
      _currencies = items;
      _isSearching = false;
      _currentPrice = getCurrencyPrice();
    });
  }

  @override
  void onLoadCurrenciesError(onError) {
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

  void _handleRadioValueChange(int value) {
    setState(() {
      _radioValue = value;
      _currentPrice=getCurrencyPrice();
      updatePaySum();
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isSearching) {
      var widget;
      widget = Center(
          child: Padding(
              padding: EdgeInsets.only(left: 16.0, right: 16.0),
              child: CircularProgressIndicator()));
      return widget;
    } else {
      return new Scaffold(
              resizeToAvoidBottomPadding: false,
              body: new Container(
                padding: EdgeInsets.all(8.0),
                child: new Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    new Padding(
                      padding: new EdgeInsets.all(8.0),
                    ),
                    new Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        new Radio(
                          value: 0,
                          groupValue: _radioValue,
                          onChanged: _handleRadioValueChange,
                        ),
                        new Text(
                          Constants.BUY_RADIOBUTTON_TITLE,
                          style: new TextStyle(fontSize: 16.0),
                        ),
                        new Radio(
                          value: 1,
                          groupValue: _radioValue,
                          onChanged: _handleRadioValueChange,
                        ),
                        new Text(
                          Constants.SELL_RADIOBUTTON_TITLE,
                          style: new TextStyle(
                            fontSize: 16.0,
                          ),
                        ),
                      ],
                    ),
                    DropdownButton<String>(
                      value: _dropdownValue,
                      onChanged: (String newValue) {
                        setState(() {
                          _dropdownValue = newValue;
                          _currentPrice = getCurrencyPrice();
                          updatePaySum();
                        });
                      },
                      items: _currencies.map<DropdownMenuItem<String>>((currency) {
                        return DropdownMenuItem<String>(
                          value: currency.shortName,
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Image.network(
                                  Network.IMAGE_FLAG_PATH_START +
                                      currency.shortName.substring(0, 2) +
                                      Network.IMAGE_FLAG_PATH_END,
                                ),
                                SizedBox(width: 10),
                                Text(
                                  _radioValue==0?currency.shortName+" - "+currency.saleRate.toString():currency.shortName+" - "+currency.purchaseRate.toString(),
                                )
                              ]),
                        );
                      }).toList(),
                    ),
                    Container(
                        child: TextFormField(
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.number,
                          controller: _controller,
                          //validator: validateNumeric,
                          //autovalidate: true
                        ),
                        padding: EdgeInsets.fromLTRB(90.0, 0, 90, 10)),
                    new Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          new Image.network(
                            Network.UAH_IMAGE_FLAG_PATH,
                            width: 50,
                          ),
                          SizedBox(width: 10),
                          new Text(
                            Constants.UAH_CURRENCY,
                            style: new TextStyle(fontSize: 16.0),
                          ),
                          SizedBox(width: 10),
                        ]),
                    Text(
                      _txt,
                      style: new TextStyle(fontSize: 16.0),
                    ),
                    new Padding(
                      padding: new EdgeInsets.all(10.0),
                    ),
                  ],
                ),
              ));
    }
  }

  void onChange() {
    setState(() {
      updatePaySum();
    });
    _controller.selection = new TextSelection(baseOffset: _controller.text.length, extentOffset: _controller.text.length);
  }

  double getCurrencyPrice() {
    CurrencyData data=_currencies.where((currency) => (currency.shortName.contains(_dropdownValue))).toList().elementAt(0);
    return _radioValue==0?data.saleRate*100:data.purchaseRate*100;
  }

  void updatePaySum() {
    if (_controller.text.isEmpty) {
      _txt = '';
    } else {
      _txt = ((_currentPrice*double.parse(_controller.text)).round()/100).toString();
    }
  }
}

