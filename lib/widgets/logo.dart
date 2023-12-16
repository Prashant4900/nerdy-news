import 'package:flutter/material.dart';
import 'package:mobile/gen/assets.gen.dart';

class MyFullTextLogo extends StatelessWidget {
  const MyFullTextLogo({
    super.key,
    this.width,
  });

  final double? width;

  @override
  Widget build(BuildContext context) {
    final isDarkTheme = Theme.of(context).brightness == Brightness.dark;

    return Assets.svg.tcnText.svg(
      width: width,
      colorFilter: ColorFilter.mode(
        isDarkTheme ? Colors.white : Colors.black,
        BlendMode.srcIn,
      ),
    );
  }
}

class MyLogoWidget extends StatelessWidget {
  const MyLogoWidget({
    super.key,
    this.width,
  });

  final double? width;

  @override
  Widget build(BuildContext context) {
    final isDarkTheme = Theme.of(context).brightness == Brightness.dark;

    return Assets.svg.tcn.svg(
      width: width,
      colorFilter: ColorFilter.mode(
        isDarkTheme ? Colors.white : Colors.black,
        BlendMode.srcIn,
      ),
    );
  }
}
