import 'package:flutter/material.dart';

Future<T> showLoading <T> (BuildContext context, Future<T> future, Widget? child) async {
  var children = <Widget>[const CircularProgressIndicator()];
  if (child != null) {
    children.add(const SizedBox(height: 16));
    children.add(child);
  }
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) {
      return Dialog(          
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: children,
          ),
        ),
      );
    }
  );
  T rv = await future;
  if (context.mounted) {
    Navigator.pop(context);
  }
  return rv;
}