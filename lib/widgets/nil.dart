import 'package:flutter/material.dart';

class Nil extends Widget {
  const Nil({super.key});

  @override
  Element createElement() => _NilElement(this);
}

class _NilElement extends Element {
  _NilElement(super.widget);

  @override
  bool get debugDoingBuild => false;
}
