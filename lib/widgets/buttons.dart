import 'package:flutter/material.dart';
import 'package:mobile/constants/commons.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({
    required this.label,
    this.onTap,
    this.backgroundColor,
    this.textColor,
    super.key,
  });

  final String label;
  final VoidCallback? onTap;
  final Color? backgroundColor;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 50,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: onTap != null
              ? backgroundColor ?? Theme.of(context).colorScheme.onBackground
              : Colors.grey.withOpacity(.3),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Center(
          child: Text(
            label,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: textColor ?? Theme.of(context).colorScheme.background,
                  fontWeight: FontWeight.w500,
                ),
          ),
        ),
      ),
    );
  }
}

class CustomOutlineButton extends StatelessWidget {
  const CustomOutlineButton({
    required this.label,
    super.key,
    this.onTap,
  });

  final String label;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 50,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          border: Border.all(
            color: Theme.of(context).colorScheme.onBackground,
          ),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Center(
          child: Text(
            label,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: Theme.of(context).colorScheme.onBackground,
                ),
          ),
        ),
      ),
    );
  }
}

class CustomTextButton extends StatelessWidget {
  const CustomTextButton({
    required this.label,
    super.key,
    this.onTap,
    this.textColor,
  });

  final String label;
  final VoidCallback? onTap;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: verticalPadding4 + horizontalPadding8,
        child: Text(
          label,
          style: Theme.of(context).textTheme.bodySmall!.copyWith(
                decoration: TextDecoration.underline,
                color: textColor,
              ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

class ShareButtonWidget extends StatelessWidget {
  const ShareButtonWidget({
    required this.message,
    this.iconData,
    this.icon,
    super.key,
    this.onTap,
  });

  final IconData? iconData;
  final Widget? icon;
  final String message;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: ColoredBox(
            color: const Color(0xFFF1F1F1),
            child: InkWell(
              onTap: onTap,
              child: Padding(
                padding: allPadding12,
                child: icon ??
                    Icon(
                      iconData,
                      size: 26,
                      color: Colors.black.withOpacity(.6),
                    ),
              ),
            ),
          ),
        ),
        Text(
          message,
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ],
    );
  }
}
