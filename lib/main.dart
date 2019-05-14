import 'package:flutter/material.dart';
import 'package:flutter_currency/module/currencies/currency_view.dart';
import 'injection/dependency_injection.dart';

void main() {
  Injector.configure(Flavor.PRO);

  runApp(
      new MaterialApp(
          title: 'Currencier',
          theme: new ThemeData(
              primarySwatch: Colors.blue
          ),
          home: new CurrencyPage()
      )
  );
}