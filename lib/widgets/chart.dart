import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../widgets/chart_bar.dart';
import '../models/transaction.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;

  Chart(this.recentTransactions);

  List<Map<String, Object>> get groupedTransactionValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(
        Duration(days: index),
      );
      var totalSpendings = 0.0;
      for (index = 0; index < recentTransactions.length; index++) {
        if (recentTransactions[index].date.day == weekDay.day &&
            recentTransactions[index].date.month == weekDay.month &&
            recentTransactions[index].date.year == weekDay.year) {
          totalSpendings += recentTransactions[index].amount;
        }
      }
      return {
        'day': DateFormat.E().format(weekDay),
        'amount': totalSpendings
      };
    });
  }

  double get maxSpendings {
    return groupedTransactionValues.fold(0.0, (sum, item) {
      return sum + item['amount'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Container(
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupedTransactionValues.map((data) {
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBar(
                  data['day'],
                  data['amount'],
                  maxSpendings == 0.0
                      ? 0.0
                      : (data['amount'] as double) / maxSpendings),
            );
          }).toList(),
        ),
      ),
    );
  }
}
