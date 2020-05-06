import 'package:flutter/material.dart';
import 'models/transaction.dart';
import 'widgets/chart.dart';
import 'widgets/new_transaction.dart';
import 'widgets/transaction_list.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Home Expenses',
      home: MyHomePage(),
      theme: ThemeData(fontFamily: 'Quicksand'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _userTransactions = [];

  List<Transaction> get _recentTransactions {
    return _userTransactions.where((transaction) {
      return transaction.date.isAfter(DateTime.now().subtract(
        Duration(days: 7),
      ));
    }).toList();
  }

  void _newTransaction(
      String titleInput, double amountInput, DateTime chosenDate) {
    final newTransaction = Transaction(
      title: titleInput,
      amount: amountInput,
      date: chosenDate,
      id: DateTime.now().toString(),
    );

    setState(() {
      _userTransactions.add(newTransaction);
    });
  }

  void _deleteTransaction(String id) {
    setState(() {
      _userTransactions.removeWhere((transaction) => transaction.id == id);
    });
  }

  void _startNewTransaction(BuildContext context) => showModalBottomSheet(
      context: context,
      builder: (_) {
        return GestureDetector(
          child: NewTransaction(_newTransaction),
          onTap: null,
          behavior: HitTestBehavior.opaque,
        );
      });

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      title: Text(
        'Home Expenses',
        style: TextStyle(fontFamily: 'OpenSans'),
      ),
      flexibleSpace: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: <Color>[Colors.deepOrange, Colors.deepPurple])),
      ),
      actions: <Widget>[
        IconButton(
            icon: Icon(Icons.add_circle),
            onPressed: () => _startNewTransaction(context))
      ],
    );

    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
                height: (MediaQuery.of(context).size.width -
                        appBar.preferredSize.height -
                        MediaQuery.of(context).padding.top) *
                    0.4,
                child: Chart(_userTransactions)),
            Container(
                height: (MediaQuery.of(context).size.width -
                        appBar.preferredSize.height -
                        MediaQuery.of(context).padding.top) *
                    0.6,
                child: TransactionList(_userTransactions, _deleteTransaction)),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _startNewTransaction(context),
      ),
    );
  }
}
