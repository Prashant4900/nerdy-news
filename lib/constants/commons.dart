import 'package:flutter/material.dart';

const emptyWidget = SizedBox.shrink();
const emptyWidgetWide = SizedBox(width: double.infinity);
const emptySliver = SliverToBoxAdapter();
const spacer = Spacer();

// Margins

const horizontalMargin4 = SizedBox(width: 4);
const horizontalMargin8 = SizedBox(width: 8);
const horizontalMargin12 = SizedBox(width: 12);
const horizontalMargin16 = SizedBox(width: 16);
const horizontalMargin24 = SizedBox(width: 24);
const horizontalMargin32 = SizedBox(width: 32);
const horizontalMargin48 = SizedBox(width: 48);

const verticalMargin4 = SizedBox(height: 4);
const verticalMargin8 = SizedBox(height: 8);
const verticalMargin12 = SizedBox(height: 12);
const verticalMargin16 = SizedBox(height: 16);
const verticalMargin24 = SizedBox(height: 24);
const verticalMargin32 = SizedBox(height: 32);
const verticalMargin48 = SizedBox(height: 48);

// Paddings

const emptyPadding = EdgeInsets.zero;

const horizontalPadding4 = EdgeInsets.symmetric(horizontal: 4);
const horizontalPadding8 = EdgeInsets.symmetric(horizontal: 8);
const horizontalPadding12 = EdgeInsets.symmetric(horizontal: 12);
const horizontalPadding16 = EdgeInsets.symmetric(horizontal: 16);
const horizontalPadding24 = EdgeInsets.symmetric(horizontal: 24);
const horizontalPadding32 = EdgeInsets.symmetric(horizontal: 32);
const horizontalPadding48 = EdgeInsets.symmetric(horizontal: 48);

const verticalPadding4 = EdgeInsets.symmetric(vertical: 4);
const verticalPadding8 = EdgeInsets.symmetric(vertical: 8);
const verticalPadding12 = EdgeInsets.symmetric(vertical: 12);
const verticalPadding16 = EdgeInsets.symmetric(vertical: 16);
const verticalPadding24 = EdgeInsets.symmetric(vertical: 24);
const verticalPadding32 = EdgeInsets.symmetric(vertical: 32);
const verticalPadding48 = EdgeInsets.symmetric(vertical: 48);

const allPadding2 = EdgeInsets.all(2);
const allPadding4 = EdgeInsets.all(4);
const allPadding8 = EdgeInsets.all(8);
const allPadding12 = EdgeInsets.all(12);
const allPadding16 = EdgeInsets.all(16);
const allPadding24 = EdgeInsets.all(24);
const allPadding32 = EdgeInsets.all(32);
const allPadding48 = EdgeInsets.all(48);

const topPadding4 = EdgeInsets.only(top: 4);
const topPadding8 = EdgeInsets.only(top: 8);
const topPadding12 = EdgeInsets.only(top: 12);
const topPadding16 = EdgeInsets.only(top: 16);
const topPadding24 = EdgeInsets.only(top: 24);
const topPadding32 = EdgeInsets.only(top: 32);
const topPadding48 = EdgeInsets.only(top: 48);

const leftPadding4 = EdgeInsets.only(left: 4);
const leftPadding8 = EdgeInsets.only(left: 8);
const leftPadding12 = EdgeInsets.only(left: 12);
const leftPadding16 = EdgeInsets.only(left: 16);
const leftPadding24 = EdgeInsets.only(left: 24);
const leftPadding32 = EdgeInsets.only(left: 32);
const leftPadding48 = EdgeInsets.only(left: 48);

const rightPadding4 = EdgeInsets.only(right: 4);
const rightPadding8 = EdgeInsets.only(right: 8);
const rightPadding12 = EdgeInsets.only(right: 12);
const rightPadding16 = EdgeInsets.only(right: 16);
const rightPadding24 = EdgeInsets.only(right: 24);
const rightPadding32 = EdgeInsets.only(right: 32);
const rightPadding48 = EdgeInsets.only(right: 48);

const bottomPadding4 = EdgeInsets.only(bottom: 4);
const bottomPadding8 = EdgeInsets.only(bottom: 8);
const bottomPadding12 = EdgeInsets.only(bottom: 12);
const bottomPadding16 = EdgeInsets.only(bottom: 16);
const bottomPadding24 = EdgeInsets.only(bottom: 24);
const bottomPadding32 = EdgeInsets.only(bottom: 32);
const bottomPadding48 = EdgeInsets.only(bottom: 48);

const startPadding4 = EdgeInsetsDirectional.only(start: 4);
const startPadding8 = EdgeInsetsDirectional.only(start: 8);
const startPadding12 = EdgeInsetsDirectional.only(start: 12);
const startPadding16 = EdgeInsetsDirectional.only(start: 16);
const startPadding24 = EdgeInsetsDirectional.only(start: 24);
const startPadding32 = EdgeInsetsDirectional.only(start: 32);
const startPadding48 = EdgeInsetsDirectional.only(start: 48);

const endPadding4 = EdgeInsetsDirectional.only(end: 4);
const endPadding8 = EdgeInsetsDirectional.only(end: 8);
const endPadding12 = EdgeInsetsDirectional.only(end: 12);
const endPadding16 = EdgeInsetsDirectional.only(end: 16);
const endPadding24 = EdgeInsetsDirectional.only(end: 24);
const endPadding32 = EdgeInsetsDirectional.only(end: 32);
const endPadding48 = EdgeInsetsDirectional.only(end: 48);

extension MergeMargins on SizedBox {
  /// Returns the sum of two [SizedBox].
  SizedBox operator +(SizedBox other) {
    return SizedBox(
      width: (width ?? 0.0) + (other.width ?? 0.0),
      height: (height ?? 0.0) + (other.height ?? 0.0),
      child: other.child,
    );
  }

  /// Returns the difference between two [SizedBox].
  SizedBox operator -(SizedBox other) {
    return SizedBox(
      width: (width ?? 0.0) - (other.width ?? 0.0),
      height: (height ?? 0.0) - (other.height ?? 0.0),
      child: other.child,
    );
  }
}
