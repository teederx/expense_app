import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:expense_planner/widgets/chart_data/chart.dart';
import 'package:expense_planner/widgets/transactions_data/new_transaction.dart';
import 'package:expense_planner/widgets/transactions_data/transaction_list.dart';
import 'package:expense_planner/models/transactions.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with WidgetsBindingObserver{
  final List<Transactions> _transactions = [
    Transactions(
      id: 't1',
      title: 'New Shoes',
      amount: 1500,
      date: DateTime.now(),
    ),
    Transactions(
      id: 't2',
      title: 'Weekly Groceries',
      amount: 2000,
      date: DateTime.now(),
    ),
  ];

  bool _showChart = false;

  //if you are interested in the app lifecycle, then add observer...
  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  //Observer...
  @override
  void didChangeAppLifecycleState (AppLifecycleState state){

  }

  //To stop LifecycleState listener when state is not needed anymore...
  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  List<Transactions> get _recentTransactions {
    return _transactions.where((tx) {
      return tx.date.isAfter(DateTime.now().subtract(const Duration(days: 7)));
    }).toList();
  }

  void _addNewTransactions(String title, double amount, DateTime date) {
    final newTransaction = Transactions(
      id: DateTime.now().toString(),
      title: title,
      amount: amount,
      date: date,
    );
    setState(() {
      _transactions.add(newTransaction);
    });
  }

  //Get the id of the delete button and check if it matches the id of the card
  //then delete the card...
  void _deleteTransaction(String id) {
    return setState(() {
      _transactions.removeWhere((element) => element.id == id);
    });
  }

  void _showAddNewTransaction(BuildContext context) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return NewTransaction(
          onPressed: _addNewTransactions,
        );
      },
    );
  }

  List<Widget> _buildLandscapeContent(
      Size size, PreferredSizeWidget appBar, var statusBar, transactionsList) {
    return [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Show Chart',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          Switch.adaptive(
            value: _showChart,
            onChanged: (value) {
              setState(() {
                _showChart = value;
              });
            },
            activeColor: Theme.of(context).primaryColor,
          ),
        ],
      ),
      _showChart
          ? SizedBox(
              height:
                  (size.height - appBar.preferredSize.height - statusBar) * 0.7,
              child: Chart(recentTransactions: _recentTransactions),
            )
          : transactionsList
    ];
  }

  List<Widget> _buildPortraitContent(
      Size size, PreferredSizeWidget appBar, var statusBar, transactionsList) {
    return [
      SizedBox(
        height: (size.height - appBar.preferredSize.height - statusBar) * 0.3,
        child: Chart(recentTransactions: _recentTransactions),
      ),
      transactionsList
    ];
  }

  ObstructingPreferredSizeWidget _buildIOSAppBar() {
    return CupertinoNavigationBar(
      middle: Text(
        widget.title,
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            onTap: () => _showAddNewTransaction(context),
            child: const Icon(CupertinoIcons.add),
          ),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildAndroidAppBar() {
    return AppBar(
      title: Text(
        widget.title,
      ),
      actions: [
        IconButton(
          onPressed: () => _showAddNewTransaction(context),
          icon: const Icon(Icons.add_rounded),
          tooltip: 'Add Expense',
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    Size size = mediaQuery.size;

    var statusBar = mediaQuery.padding.top;

    final PreferredSizeWidget appBar = Platform.isIOS
        ? _buildIOSAppBar()
        : _buildAndroidAppBar();

    final _isLanscapeMode = mediaQuery.orientation == Orientation.landscape;

    var transactionsList = SizedBox(
      height: (size.height - appBar.preferredSize.height - statusBar) * 0.7,
      child: TransactionList(
        transactions: _transactions,
        delete: _deleteTransaction,
      ),
    );

    var pageBody = SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            if (_isLanscapeMode)
              ..._buildLandscapeContent(
                size,
                appBar,
                statusBar,
                transactionsList,
              ),
            if (!_isLanscapeMode)
              ..._buildPortraitContent(
                size,
                appBar,
                statusBar,
                transactionsList,
              ),
          ],
        ),
      ),
    );

    return Platform.isIOS
        ? CupertinoPageScaffold(
            navigationBar: appBar as ObstructingPreferredSizeWidget,
            child: pageBody,
          )
        : Scaffold(
            appBar: appBar,
            floatingActionButton: Platform.isIOS
                ? Container()
                : FloatingActionButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    elevation: 10,
                    splashColor: Colors.blueGrey,
                    backgroundColor: Theme.of(context).primaryColor,
                    onPressed: () => _showAddNewTransaction(context),
                    tooltip: 'Add Expense',
                    child: const Icon(
                      Icons.add_rounded,
                    ),
                  ),
            body: pageBody,
          );
  }
}
