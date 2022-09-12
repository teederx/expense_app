import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdaptiveDatePicker extends StatelessWidget {
  const AdaptiveDatePicker({
    super.key,
    required this.cupertinoDatePicker,
    required this.androidDatePicker,
  });

  final VoidCallback cupertinoDatePicker;
  final VoidCallback androidDatePicker;

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoButton(
            onPressed: cupertinoDatePicker,
            child: const Text(
              'Select Date',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          )
        : TextButton(
            onPressed: androidDatePicker,
            child: const Text(
              'Select Date',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          );
  }
}
