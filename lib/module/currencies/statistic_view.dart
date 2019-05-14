import 'package:flutter/material.dart';
import 'package:flutter_currency/storage/database_helper.dart';


class StatisticPage extends StatelessWidget {

  // reference to our single class that manages the database
  final dbHelper = DatabaseHelper.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
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
            ),
          ],
        ),
      ),
    );
  }

// Button onPressed methods

  void _insert() async {
    // row to insert
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
    // row to update
    Map<String, dynamic> row = {
      DatabaseHelper.columnId   : 1,
      DatabaseHelper.columnName : 'USD',
      DatabaseHelper.columnDate  : '10.05.2019',
      DatabaseHelper.columnSale  : 24.4,
      DatabaseHelper.columnPurchase  : 22.4
    };
    final rowsAffected = await dbHelper.update(row);
    print('updated $rowsAffected row(s)');
  }

  void _delete() async {
    // Assuming that the number of rows is the id for the last row.
    final id = await dbHelper.queryRowCount();
    final rowsDeleted = await dbHelper.delete(id);
    print('deleted $rowsDeleted row(s): row $id');
  }
}

