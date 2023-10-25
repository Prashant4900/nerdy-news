import 'package:flutter/material.dart';
import 'package:mobile/constants/commons.dart';
import 'package:mobile/widgets/buttons.dart';

class MyErrorScreen extends StatelessWidget {
  const MyErrorScreen({this.onTap, super.key});

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: MediaQuery.sizeOf(context).width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Oops!',
              style: Theme.of(context)
                  .textTheme
                  .headlineMedium!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
            verticalMargin16,
            Text(
              'Something went wrong please try again',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            verticalMargin32,
            Padding(
              padding: horizontalPadding16,
              child: CustomElevatedButton(
                  label: 'Try again.',
                onTap: onTap,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
