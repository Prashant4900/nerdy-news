// ignore_for_file: prefer_const_constructors

import 'package:auth/auth.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Auth', () {
    test('can be instantiated', () {
      expect(MyAuth(), isNotNull);
    });
  });
}
