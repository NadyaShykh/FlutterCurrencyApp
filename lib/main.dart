import 'package:flutter/material.dart';
import 'package:flutter_currency/localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_currency/module/currencies/currency_view.dart';
import 'injection/dependency_injection.dart';

void main() {
  Injector.configure(Flavor.PRO);

  runApp(
      new MaterialApp(
          debugShowCheckedModeBanner: false,
          onGenerateTitle: (BuildContext context) =>
              AppLocalizations.of(context).currenciesTitle(),
          localizationsDelegates: [
            const AppLocalizationsDelegate(),
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          supportedLocales: [
            const Locale('en'),
            const Locale('ru'),
            const Locale('ua'),
          ],
          title: 'Flutter Demo',
          theme: new ThemeData(
              primarySwatch: Colors.blue
          ),
          home: new CurrencyPage()
      )
  );
}

//zapys vybranoi ovy u shared preferences