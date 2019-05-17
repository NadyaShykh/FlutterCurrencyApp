import 'package:flutter/material.dart';
import 'package:flutter_currency/storage/database_helper.dart';
import 'package:flutter_currency/utils/Constants.dart';


class StatisticPage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return _StatisticPageState();
  }

}

class _StatisticPageState extends State<StatisticPage> {

  final dbHelper = DatabaseHelper.instance;
  int _radioValue = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            /*RaisedButton(
              child: Text('insert', style: TextStyle(fontSize: 20),),
              onPressed: () {_insert();},
            ),
            RaisedButton(
              child: Text('query', style: TextStyle(fontSize: 20),),
              onPressed: () {_query();},
            ),
            RaisedButton(
              child: Text('update', style: TextStyle(fontSize: 20),),
              onPressed: () {_update();},
            ),
            RaisedButton(
              child: Text('delete', style: TextStyle(fontSize: 20),),
              onPressed: () {_delete();},
            ),
            RaisedButton(
              child: Text('query Today', style: TextStyle(fontSize: 20),),
              onPressed: () {_queryToday();},
            ),*/
            new Padding(
              padding: new EdgeInsets.all(20.0),
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
                  Constants.EN_LANG,
                  style: new TextStyle(fontSize: 16.0),
                ),
                new Radio(
                  value: 1,
                  groupValue: _radioValue,
                  onChanged: _handleRadioValueChange,
                ),
                new Text(
                  Constants.UA_LANG,
                  style: new TextStyle(
                    fontSize: 16.0,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

// Button onPressed methods

  void _handleRadioValueChange(int value) {
    setState(() {
      _radioValue = value;
    });
  }

  void _insert() async {
    Map<String, dynamic> row = {
      DatabaseHelper.columnName : 'USD',
      DatabaseHelper.columnDate  : '11.05.2019',
      DatabaseHelper.columnSale  : 24.5,
      DatabaseHelper.columnPurchase  : 22.8
    };
    final id = await dbHelper.insert(row);
    print('inserted row id: $id');
  }

  void _query() async {
    final allRows = await dbHelper.queryAllRows();
    print('query all rows:');
    allRows.forEach((row) => print(row));
  }

  void _queryToday() async {
    final allRows = await dbHelper.queryAllTodayRows('09.05.2019');
    print('query today rows:');
    allRows.forEach((row) => print(row));
  }

  void _update() async {
    Map<String, dynamic> row = {
      DatabaseHelper.columnId   : 1,
      DatabaseHelper.columnName : 'USD',
      DatabaseHelper.columnDate  : '12.05.2019',
      DatabaseHelper.columnSale  : 4.11,
      DatabaseHelper.columnPurchase  : 22.4
    };
    final rowsAffected = await dbHelper.update(row);
    print('updated $rowsAffected row(s)');
  }

  void _delete() async {
    final id = await dbHelper.queryRowCount();
    final rowsDeleted = await dbHelper.delete(id);
    print('deleted $rowsDeleted row(s): row $id');
  }
}
