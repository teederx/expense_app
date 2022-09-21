import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:expense_planner/models/transactions.dart';

class TransactionList extends StatelessWidget {
  const TransactionList({
    Key? key,
    required this.transactions,
    required this.delete,
  }) : super(key: key);

  final List<Transactions> transactions;
  final Function delete;

  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
        ? LayoutBuilder(builder: (context, constraints) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const Text('No Transactions Yet'),
                SizedBox(
                  height: constraints.maxHeight * 0.05,
                ),
                SizedBox(
                  height: constraints.maxHeight * 0.85,
                  child: Image.asset(
                    'assets/images/waiting.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            );
          })
        : ListView.builder(
            itemCount: transactions.length,
            itemBuilder: (context, index) {
              return Card(
                key: ValueKey(transactions[index].id),
                elevation: 5,
                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Theme.of(context).primaryColor,
                    radius: 30,
                    child: Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: FittedBox(
                        child: Text(
                          '₦${transactions[index].amount.toStringAsFixed(0)}',
                          style:
                              Theme.of(context).textTheme.titleLarge!.copyWith(
                                    color: Colors.white,
                                  ),
                        ),
                      ),
                    ),
                  ),
                  title: Text(
                    transactions[index].title,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  subtitle: Text(
                    //https://pub.dev/documentation/intl/latest/
                    DateFormat.MMMEd().format(transactions[index].date),
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  trailing: MediaQuery.of(context).size.width > 400
                      ? TextButton.icon(
                          onPressed: () => delete(transactions[index].id),
                          icon: const Icon(Icons.delete_outline_rounded),
                          label: const Text('Delete'),
                        )
                      : IconButton(
                          onPressed: () => delete(transactions[index].id),
                          icon: const Icon(Icons.delete_outline_rounded),
                        ),
                ),
              );
            },
          );
  }
}
