import 'package:flutter/material.dart';

import '../widgets/new_transaction.dart';
import '../widgets/transaction_list.dart';
import '../models/transaction.dart';

class UserTransactions extends StatefulWidget {
  @override
  _UserTransactionsState createState() => _UserTransactionsState();
}

class _UserTransactionsState extends State<UserTransactions> {
  final List<Transaction> _userTransactions = [
    Transaction(
        id: 't1', title: 'New Shoes', amount: 49.99, date: DateTime.now()),
    Transaction(
        id: 't2', title: 'New Toys', amount: 99.99, date: DateTime.now())
  ];

  void _newTransaction(String titleInput, double amountInput) {
    final newTransaction = Transaction(
      title: titleInput,
      amount: amountInput,
      date: DateTime.now(),
      id: DateTime.now().toString(),
    );

    setState(() {
      _userTransactions.add(newTransaction);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[NewTransaction(_newTransaction), TransactionList(_userTransactions)],
    );
  }
}
