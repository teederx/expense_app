import 'package:expense_planner/widgets/transactions_data/adaptive_date_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  const NewTransaction({
    Key? key,
    required this.onPressed,
  }) : super(key: key);

  final Function onPressed;

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleEditingController = TextEditingController();
  final _amountEditingController = TextEditingController();
  DateTime? _selectedDate;

  void _submitData() {
    try {
      final enteredTitle = _titleEditingController.text;
      final enteredAmount = double.parse(_amountEditingController.text);
      if (enteredTitle.isEmpty ||
          enteredAmount.isNegative ||
          _selectedDate == null) {
        return;
      }
      widget.onPressed(
        enteredTitle,
        enteredAmount,
        _selectedDate,
      );
      Navigator.of(context).pop();
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      // Navigator.of(context).pop();
    }
  }

  void _cupertinoDatePicker() {
    CupertinoDatePicker(onDateTimeChanged: (pickedValue) {
      if (pickedValue == null) {
        return null;
      }
      setState(() {
        _selectedDate = pickedValue;
      });
    });
  }

  void _datePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    ).then((pickedValue) {
      if (pickedValue == null) {
        return null;
      }
      setState(() {
        _selectedDate = pickedValue;
      });
    });
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Padding(
          padding: EdgeInsets.only(
              top: 10,
              bottom: MediaQuery.of(context).viewInsets.bottom + 10,
              left: 10,
              right: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextField(
                style: Theme.of(context).textTheme.bodyMedium,
                decoration: const InputDecoration(
                  labelText: 'Title',
                ),
                controller: _titleEditingController,
                onSubmitted: (_) => _submitData(),
              ),
              TextField(
                style: Theme.of(context).textTheme.bodyMedium,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                decoration: const InputDecoration(
                  prefix: Text('₦'),
                  labelText: 'Amount',
                ),
                controller: _amountEditingController,
                onSubmitted: (_) => _submitData(),
              ),
              Container(
                margin: const EdgeInsets.symmetric(
                  vertical: 10,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        _selectedDate == null
                            ? 'No Selected Date'
                            : 'Date: ${DateFormat.MMMEd().format(_selectedDate!)}',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                    AdaptiveDatePicker(
                      cupertinoDatePicker: _cupertinoDatePicker,
                      androidDatePicker: _datePicker,
                    )
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: _submitData,
                style: ElevatedButton.styleFrom(
                  elevation: 5,
                  primary: Theme.of(context).primaryColor,
                ),
                child: const Text(
                  'Add Transaction',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}