import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Copy to clipboard
Future<void> copyToClipboard(
  BuildContext context, {
  required String text,
}) async {
  await Clipboard.setData(ClipboardData(text: text)).whenComplete(() {
    const snackBar = SnackBar(
      content: Text('Copied to clipboard'),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  });
}
